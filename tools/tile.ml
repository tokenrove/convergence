(* Tile
 *
 * $Id: tile.ml,v 1.1 2002/09/04 14:32:00 tek Exp $
 *)

type t = string;;

exception Bad_tile;;

let tile_w = 8 and tile_h = 8;;

let equal a b = (String.compare a b) = 0;;

(* hash
 * Hash of a tile which is invariant even when the tile is a flip or
 * mirror of another.
 *)
let hash x =
    let h = ref 0 in
    for i = 0 to String.length x - 1 do
	h := !h + (Char.code x.[i])
    done;

    (!h * 31)
    ;;


(* count_list n
 * Returns a list from 0 to n-1.  NOTE: Beware of off-by-one errors when
 * using this function.
 *)
let count_list n =
    let rec count_list_intr n =
	if n = 1 then [0] else (n-1) :: (count_list_intr (n - 1))
    in
    List.rev (count_list_intr n)
    ;;


(* grab
 * Snarf an 8x8 tile from s (which is theoretically a w*8-by-something
 * 2d image).
 *)
let grab s x y w =
    let f z = ((x*tile_w) + (y*tile_h + z) * (w*tile_w)) in
    let l = List.map (fun z -> String.sub s (f z) tile_h) (count_list 8)
    in String.concat "" l
    ;;


(* quantize
 * Take an 8x8x8bpp tile, return a tuple of an 8x8x4bpp tile and its
 * palette offset.  The pixels in the return image are _unpacked_.
 *)
let quantize tile =
    let offset = (Char.code tile.[0]) / 16 in
    (* Check and quantize the tile indexes *)
    for i = 0 to String.length tile - 1 do
	let x = (Char.code tile.[i]) - (offset*16) in
	if x < 0 || x > 15 then begin
	    Printf.fprintf stderr "got %d (color %d, offset %d) for x\n" x
		(Char.code tile.[0]) offset;
	    raise Bad_tile
	end else
	    tile.[i] <- Char.chr x
    done;

    (tile, offset)
    ;;


(* flip_h
 * Flips a tile horizontally.
 *)
let flip_h tile =
    let tile' = String.copy tile in
    for i = 0 to tile_h - 1 do
	for j = 0 to (tile_w / 2) - 1 do
	   (* Swap pixel at (j, i) with the one at (7-j, i) *)
	   let first = i*tile_w + j
	   and second = i*tile_w + ((tile_w-1)-j) in
	   let u = tile'.[first] and v = tile'.[second] in
	   tile'.[first] <- v;  tile'.[second] <- u;
	done;
    done;
    tile'
    ;;

(* flip_v
 * Flips a tile vertically.
 *)
let flip_v tile =
    let tile' = String.copy tile in
    for i = 0 to tile_w - 1 do
	for j = 0 to (tile_h / 2) - 1 do
	   (* Swap pixel at (i, j) with the one at (i, 7-j) *)
	   let first = i + j*tile_w
	   and second = i + ((tile_h-1)-j)*tile_w in
	   let u = tile'.[first] and v = tile'.[second] in
	   tile'.[first] <- v;  tile'.[second] <- u;
	done;
    done;
    tile'
    ;;


(* EOF tile.ml *)
