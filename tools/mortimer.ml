(*
 * mortimer
 * A tool for converting PCXs to GBA maps.
 * Julian Squires / Pureplay Games / 2002
 *
 * $Id: mortimer.ml,v 1.12 2002/09/25 12:43:06 tek Exp $
 *)

let max_tiles = 1024;;
let tile_w = 8 and tile_h = 8;;

module TileHashtbl = Hashtbl.Make (Tile);;

let table = TileHashtbl.create 256;;
let tiles = Array.make max_tiles "";;
let idx = ref 0;;


(* block_split
 *)
let block_split img w h idxoffs =
    let map = Array.make (w*h) 0 in
    for x = 0 to w-1 do
	for y = 0 to h-1 do
	    let (t,p) = try Tile.quantize (Tile.grab img x y w) with
	                | Tile.Bad_tile ->
			    Printf.fprintf stderr "at %d %d (%d %d)\n" x y w h;
			    (String.make (tile_w*tile_h) (Char.chr 0),0)
	    in
	    let t_h = Tile.flip_h t and t_v = Tile.flip_v t in
	    let t_vh = Tile.flip_v t_h in

	    if TileHashtbl.mem table t then (
		map.(x+y*w) <- (p lsl 12) lor (TileHashtbl.find table t)
	    ) else if TileHashtbl.mem table t_h then (
		map.(x+y*w) <- (p lsl 12) lor (1 lsl 10)
		               lor (TileHashtbl.find table t_h)
	    ) else if TileHashtbl.mem table t_v then (
		map.(x+y*w) <- (p lsl 12) lor (1 lsl 11)
		               lor (TileHashtbl.find table t_v)
	    ) else if TileHashtbl.mem table t_vh then (
		map.(x+y*w) <- (p lsl 12) lor (3 lsl 10)
		               lor (TileHashtbl.find table t_vh)
	    ) else (
		TileHashtbl.add table t (!idx + idxoffs);
		tiles.(!idx) <- t;
		map.(x+y*w) <- (p lsl 12) lor (!idx + idxoffs);
		incr idx;
	    );
	done;
    done;

    map
    ;;


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


let basename s = try String.sub s 0 (String.rindex s '.') with
		 | Not_found -> s;;


type flag =
    | OptOffset of int
    | OptMerge of string
    | OptNoPalette
    | Filename of string
    ;;

(*
 * Arguments:
 *   -o <n>	Offset all indices by n.
 *   -m <file>	Output a merged tilebank to file, with seperate maps for
 *		each file.
 *   -P		Don't output a palette.
 *)
let main unit =
    let rec getopts args =
	match args with
	| "-P"::args    -> OptNoPalette :: (getopts args)
	| "-o"::s::args -> (OptOffset (int_of_string s)) :: (getopts args)
	| "-m"::s::args -> (OptMerge s) :: (getopts args)
	| s::args       -> (Filename s) :: (getopts args)
	| []            -> []
    in

    let options = getopts (List.tl (Array.to_list Sys.argv)) in
    let files =
	let f = (function | Filename _ -> true | _ -> false) in
	let g = (function | Filename s -> s | _ -> "") in
	List.map g (List.filter f options) in

    if (List.length files) = 0 then
	invalid_arg "not enough files specified.";

    let offset =
	let f = (function | OptOffset _ -> true | _ -> false) in
	let l = List.filter f options in
	if List.length l > 1 then invalid_arg "too many offset options."
	else if List.length l = 1 then
	    match List.hd l with OptOffset x -> x | _ -> 0
	else
	    0
    in

    let tileout =
	let f = (function | OptMerge _ -> true | _ -> false) in
	let l = List.filter f options in
        match l with
        | []           -> (basename (List.hd files)) ^ ".tiles"
        | [OptMerge s] -> s 
        | _	       -> invalid_arg "too many merge options."
    in

    let proc_file s =
	let pcx_file =
	    try open_in_bin s with
	    | Not_found -> Printf.fprintf stderr "couldn't find %s\n" s;
			   raise Exit;
	in
	let orig_image = Pcx.load pcx_file in
	close_in pcx_file;

	let map = match orig_image with
	| (img,w,h,_) -> block_split img (w/8) (h/8) offset
	in

	(* Write the map to a file. *)
	let file = open_out_bin ((basename s) ^ ".map") in
	let dump x = let (l,h) = to_little_endian x in
	             output_byte file l; output_byte file h
	in
	Array.iter dump map;
	close_out file;

	if not (List.mem OptNoPalette options) then (
	    (* Write the palette to a file. *)
	    let file = open_out_bin ((basename s) ^ ".pal") in
	    match orig_image with
	    | (_,_,_,pal) -> output_string file (palette_massage pal);
	    close_out file;
	);
    in

    List.iter proc_file files;

    Printf.printf "final idx: %d\n" !idx;

    Printf.printf "writing tiles to %s, offset of %d.\n" tileout offset;
    if List.mem OptNoPalette options then
	Printf.printf "no palette output.\n";

    (* Write the tile data to a file. *)
    let tiledata_file = open_out_bin tileout in
    for i = 0 to !idx do
	output_string tiledata_file (four_bit tiles.(i))
    done;
    close_out tiledata_file;

    ;;


main ();;


(* EOF mortimer.ml *)
