(*
 * lns2pgm
 * A tool which renders an lns file into a Portable Grayscale Map
 *
 * $Id: lns2pgm.ml,v 1.3 2002/12/11 16:37:21 tek Exp $
 *)

exception Bad_line_file;;

type line = { start : int*int;
              finish : int*int;
              genre : int }
	    ;;

(* grab_line
 * Read a (geometric) line from an input file.
 *)
let grab_line file =
    match (Str.split (Str.regexp "[ \t]+") (input_line file)) with
    | [x;y;x';y';g;f] -> { start = (int_of_string x, int_of_string y);
                           finish = (int_of_string x', int_of_string y');
			   genre = int_of_string g }
    | _ -> raise Bad_line_file
    ;;

let ctr = ref 0;;

let render_line img w line =
    incr ctr;
    if !ctr > 14 then ctr := 0;

    let x = ref (fst line.start)
    and y = ref (snd line.start) in

    let ax = 2 * (abs ((fst line.finish) - (fst line.start)))
    and ay = 2 * (abs ((snd line.finish) - (snd line.start))) in

    let sign x y =  if (x - y) >= 0 then 1 else -1 in
    let sx = sign (fst line.finish) (fst line.start)
    and sy = sign (snd line.finish) (snd line.start)
    in

    let c = Char.chr ((14 * !ctr) + 32) in

    if ax > ay then (
	let d = ref (ay - ax/2) in

	img.[!x + !y * w] <- c;
	while !x <> (fst line.finish) do
	    if !d >= 0 then (
		y := !y + sy;
		d := !d - ax;
	    );
	    x := !x + sx;
	    d := !d + ay;
	    img.[!x + !y*w] <- c;
	done;
    ) else (
	let d = ref (ax - ay/2) in

	img.[!x + !y * w] <- c;
	while !y <> (snd line.finish) do
	    if !d >= 0 then (
		x := !x + sx;
		d := !d - ay;
	    );
	    y := !y + sy;
	    d := !d + ax;
	    img.[!x + !y*w] <- c;
	done;
    );
    ;;

let main unit =
    let rec grab_ll file list =
	let eof = ref false in
	let l = try grab_line file with
		| End_of_file -> eof := true;
		                 {start=(0,0);finish=(0,0);genre=0};
	in
	if not !eof then l :: (grab_ll file list) else list
    in


    let line_file = open_in Sys.argv.(1) in
    let line_list = grab_ll line_file [] in

    let f a b = (max (max a (fst b.start)) (max a (fst b.finish))) in
    let max_w = (List.fold_left f 0 line_list) + 1 in

    let f a b = (max (max a (snd b.start)) (max a (snd b.finish))) in
    let max_h = (List.fold_left f 0 line_list) + 1 in

    let bitmap = String.make (max_w * max_h) (Char.chr 0) in

    List.iter (render_line bitmap max_w) line_list;
    Printf.printf "P5 %d %d 255\n%s\n" max_w max_h bitmap;

    close_in line_file;
    ;;

main();;

(* EOF lns2pgm.ml *)
