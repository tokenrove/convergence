(*
 * Roz
 * A simple PCX to raw conversion tool.
 *
 * Some of the code here is borrowed from Mortimer.
 *
 * $Id: roz.ml,v 1.4 2002/11/19 17:33:57 tek Exp $
 *)

(* four_bit
 * Pack an 8x8x4bpp image.
 *)
let four_bit s =
    let t = String.make ((String.length s)/2) (Char.chr 0) in
    for i = 0 to String.length t - 1 do
	let l = Char.code s.[2*i]
	and r = Char.code s.[2*i+1] in
	t.[i] <- Char.chr (l lor (r lsl 4))
    done;

    t
    ;;


(* to_little_endian
 * Takes a 16-bit integer, returns a tuple of the low and high
 * bytes to write out. *)
let to_little_endian i =
    assert(i < 65536);
    assert(i >= 0);
    (i land 0xff, i lsr 8)
    ;;


(* rgb2gba
 * Take 8-bits-per-component RGB, return a GBA palette entry.
 *)
let rgb2gba r g b =
    (r lsr 3) lor ((g lsr 3) lsl 5) lor ((b lsr 3) lsl 10)
    ;;


(* palette_massage
 *)
let palette_massage s =
    let outpal = String.create 512 in
    for i = 0 to 255 do
        let (l,h) = to_little_endian (rgb2gba (Char.code s.[3*i])
                                              (Char.code s.[3*i+1])
                                              (Char.code s.[3*i+2])) in
        outpal.[2*i] <- Char.chr l;
        outpal.[2*i+1] <- Char.chr h;
    done;

    outpal
    ;;


(* palette_massage_16
 *)
let palette_massage_16 s =
    let outpal = String.create 32 in
    for i = 0 to 15 do
        let (l,h) = to_little_endian (rgb2gba (Char.code s.[3*i])
                                              (Char.code s.[3*i+1])
                                              (Char.code s.[3*i+2])) in
        outpal.[2*i] <- Char.chr l;
        outpal.[2*i+1] <- Char.chr h;
    done;

    outpal
    ;;


let base_name s = String.sub s 0 (String.rindex s '.');;


type flag =
    | OptMillerSoft
    | OptPaletteOutput
    | OptNoImage
    | Filename of string
    ;;

(*
 * Arguments:
 *  -millersoft     Output raw256 instead of default raw16.
 *  -p              Output a palette.
 *  -n              No image output.
 *)
let main unit =
    let rec getopts args =
	match args with
	| "-p"::args          -> OptPaletteOutput :: (getopts args)
	| "-millersoft"::args -> OptMillerSoft :: (getopts args)
	| "-n"::args          -> OptNoImage :: (getopts args)
	| s::args             -> (Filename s) :: (getopts args)
	| []                  -> []
    in

    let options = getopts (List.tl (Array.to_list Sys.argv)) in
    let files =
	let f = (function | Filename _ -> true | _ -> false) in
	let g = (function | Filename s -> s | _ -> "") in
	List.map g (List.filter f options) in

    if (List.length files) = 0 then
	invalid_arg "not enough files specified.";

    let proc_file filename =
        let pcx_file =
	    try open_in_bin filename with
	    | Not_found -> Printf.fprintf stderr "couldn't find %s\n" filename;
			   raise Exit;
        in
        let orig_image = Pcx.load pcx_file in
        close_in pcx_file;

        if (List.mem OptMillerSoft options) then (match orig_image with
            | (image,w,h,palette) ->
            (* Write the tile data to a file. *)
            let data_file = open_out_bin ((base_name filename) ^ ".raw256") in
            output_string data_file (image);
            close_out data_file;

            if (List.mem OptPaletteOutput options) then (
                let palette_file = open_out_bin
                    ((base_name filename) ^ ".pal") in
                output_string palette_file (palette_massage palette);
                close_out palette_file;
            );
        ) else (
            let tile_w = 8 and tile_h = 8 in

            (* Do the grunt work. *)
            let tiles = match orig_image with
            | (img,w,h,_) ->
                let tiles = Array.make (w*h) "" in
                for x = 0 to (w/tile_w)-1 do
                    for y = 0 to (h/tile_h)-1 do
                        let (t,_) = try Tile.quantize (Tile.grab img x y (w/tile_w)) with
                                | Tile.Bad_tile ->
                                    Printf.fprintf stderr "at %d,%d\n" x y; ("", 0)
                        in
                        tiles.(x+y*(w/tile_w)) <- t;
                    done;
                done;
                tiles
            in

            (* Write the tile data to a file. *)
            let tiledata_file = open_out_bin ((base_name filename) ^ ".raw") in
            for i = 0 to Array.length tiles - 1 do
                output_string tiledata_file (four_bit tiles.(i))
            done;
            close_out tiledata_file;

            if (List.mem OptPaletteOutput options) then (match orig_image with
            | (_,_,_,palette) ->
                let palette_file = open_out_bin
                    ((base_name filename) ^ ".pal") in
                output_string palette_file (palette_massage_16 palette);
                close_out palette_file;
            );
        )
    in

    List.iter proc_file files;
;;

main ();;

(* EOF roz.ml *)
