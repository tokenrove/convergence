
exception Bad_note;;
exception Bad_duration;;

let name_to_note s = match s with
    | "C" -> 1
    | "C#" | "Db" -> 2
    | "D" -> 3
    | "D#" | "Eb" -> 4
    | "E" -> 5
    | "F" -> 6
    | "F#" | "Gb" -> 7
    | "G" -> 8
    | "G#" | "Ab" -> 9
    | "A" -> 10
    | "A#" | "Bb" -> 11
    | "B" -> 12
    | "R" -> 0
    | _ -> raise Bad_note
    ;;

let duration s = let x = (match s.[0] with
    | 'w' -> 0
    | 'h' -> 1
    | 'q' -> 2
    | 'e' -> 3
    | 's' -> 4
    | 't' -> 5
    | 'S' -> 6
    | _ -> raise Bad_duration) in if (String.length s) > 1 then
	let y = (match s.[1] with
	| '.' -> 1
	| '~' -> 2
	| '^' -> 4
	| _ -> raise Bad_duration
	) in y lor (x lsl 3)
    else
	x lsl 3
    ;;

let noteparse s =
    let l = Str.full_split (Str.regexp "[0-9]+") s
    in match l with
    | [Str.Text x; Str.Delim y; Str.Text z] ->
	(((name_to_note x) + 12*(int_of_string y)) lsl 6) lor
	(duration z)
    | _ -> raise Bad_note;;

while true do
    let s = try (input_line stdin) with
	| _ -> Format.printf "\n"; flush stdout; exit 0;
    in
    let s = Str.split (Str.regexp "[ \t\n]+") s
    in
	List.iter (fun x -> ignore(Format.printf "0x%04x, " x)) (List.map noteparse s)
done ;;

Format.printf "\n";;
