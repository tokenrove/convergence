(*
 * lns2lnd
 * A tool for faking things
 *
 * $Id: lns2lnd.ml,v 1.2 2002/11/06 12:14:40 tek Exp $
 *)

exception Bad_line_file;;

type line = { start : int*int;
              finish : int*int;
              genre : int;
              friction : int }
	    ;;

(* grab_line
 * Read a (geometric) line from an input file.
 *)
let grab_line file =
    match (Str.split (Str.regexp "[ \t]+") (input_line file)) with
    | [x;y;x';y';g;f] -> { start = (int_of_string x, int_of_string y);
                           finish = (int_of_string x', int_of_string y');
			   genre = int_of_string g;
                           friction = int_of_string f }
    | _ -> raise Bad_line_file
    ;;



let main unit =
    let rec grab_ll file list =
	let eof = ref false in
	let l = try grab_line file with
		| End_of_file -> eof := true;
		                 {start=(0,0);finish=(0,0);genre=0;friction=0};
	in
	if not !eof then l :: (grab_ll file list) else list
    in

    let out_lehword oc i =
	if i > 65535 then
	    Printf.fprintf stderr "Warning: hword too large: %d\n" i;
	output_byte oc (i land 0xff);
	output_byte oc ((i asr 8) land 0xff)
    in

    let line_file = open_in Sys.argv.(1) in
    let line_list = grab_ll line_file [] in

    let f line =
	out_lehword stdout (fst (line.start));
	out_lehword stdout (snd (line.start));
	out_lehword stdout (fst (line.finish));
	out_lehword stdout (snd (line.finish));
	output_byte stdout line.friction;
	output_byte stdout line.genre;
	output_byte stdout 0;
	output_byte stdout 0;
    in
    List.iter f line_list;

    close_in line_file;
    ;;

main();;

(* EOF lns2lnd.ml *)
