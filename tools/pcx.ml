(* PCX
 * $Id: pcx.ml,v 1.2 2002/09/09 14:04:20 tek Exp $
 *)

exception Bad_PCX;;

let hword_from_string s p = Char.code s.[p] lor (Char.code s.[p+1] lsl 8);;

(* Pcx.load
 * Loads a PCX file.  We only (want to) support 8bpp files with palettes
 * attached, so we're pretty snob-like about the header. *)
let load file =
    (* Read the header *)
    let header_len = 128 in
    let header = String.create header_len in
    really_input file header 0 header_len;
    (* Various header checks. *)
    if Char.code header.[0] <> 10 or
       Char.code header.[1] <> 5 or
       Char.code header.[2] <> 1 or
       Char.code header.[3] <> 8 then
       raise Bad_PCX;
    (* Grab width and height. *)
    let w = (hword_from_string header 8)-(hword_from_string header 4)+1
    and h = (hword_from_string header 10)-(hword_from_string header 6)+1
    in
    (* Decode the actual image data. *)
    let img = String.create (w*h) in
    let i = ref 0 in
    while !i < w*h do
	let c = input_byte file in
	if (c land 0xc0) <> 0xc0 then begin
	    img.[!i] <- Char.chr c; incr i
	end else begin
	    let c' = input_byte file in
	    String.fill img !i (c land 0x3f) (Char.chr c');
	    i := !i + (c land 0x3f);
	    (*for j = (c land 0x3f) downto 1 do
		img.[!i] <- Char.chr c'; incr i
	    done; *)
	end;
    done;
    (* Read in the palette. *)
    let palette = String.create 768 
    and len = in_channel_length file in
    seek_in file (len-768);
    really_input file palette 0 768;
    (* Final return value. *)
    (img,w,h,palette)
    ;;


(* EOF pcx.ml *)
