(* pcx2lns
 * Extract line information from a PCX.
 *
 * $Id: pcx2lns.ml,v 1.11 2002/12/12 01:32:49 tek Exp $
 *)

exception Bad_state;;
exception Too_short;;


let find_first (img,w,h) (x,y) c =
    let i = try String.index_from img (x+y*w) (Char.chr c) with
	    | Not_found -> w*h
    in
    (i mod w,i/w)
    ;;

let rec gcd a b =
    if b > a then
        gcd b a
    else if b = 0 then
        a
    else gcd b (a mod b);;

(* match_line
 *
 * Extracts lines of a given color by recognizing patterns with a state
 * machine.  There are obvious cases which will break this, but for the
 * moment it does quite well.
 *)
let rec match_line (img,w,h) (i_x,i_y) (x,y) c state =
    let get_pel (x,y) =
	if x >= 0 && x < w && y >= 0 && y < h then
	    Char.code img.[x+y*w]
	else
	    -1
    in
    let transition =
	[|
	    [| [| 0;-1;3 |]; [| 1;5;2 |] |]; (* 0 *)
	    [| [| 4;-1;0 |]; [| 1;6;0 |] |]; (* 1 *)
	    [| [| 0;-1;3 |]; [| 0;7;2 |] |]; (* 2 *)
	    [| [| 0;-1;3 |]; [| 0;0;2 |] |]; (* 3 *)
	    [| [| 4;-1;0 |]; [| 1;0;0 |] |]; (* 4 *)
	    [| [| 0;-1;0 |]; [| 1;5;2 |] |]; (* 5 *)
	    [| [| 0;-1;0 |]; [| 1;6;0 |] |]; (* 6 *)
	    [| [| 0;-1;0 |]; [| 0;7;2 |] |]; (* 7 *)
	|]
    in

    if state < 8 then
        let distance_sqr (x',y') = 
            let dx = abs(i_x - x')
            and dy = abs(i_y - y')
            in (dx * dx) + (dy * dy)
        in
	let f (x,y) = get_pel (x,y) = c in
	let g (x',y') = transition.(state).(y'-y).(x'-(x-1)) <> 0 in
        let slope_correct (x',y') =
            if distance_sqr (x',y') > 36 then
                let m_y = abs(i_y-y)
                and m_x = abs(i_x-x) in
                let m_y' = abs(i_y-y')
                and m_x' = abs(i_x-x') in
                let m_g = gcd m_x m_y in
                let m_g' = gcd m_x' m_y' in

                if (m_y/m_g) = (m_y'/m_g') &&
                   (m_x/m_g) = (m_x'/m_g') then
                    true
                else
                    false
            else
                true
        in
	let (x',y') =
	    try List.find f (List.filter (fun t -> (g t) && (slope_correct t))
		[(x-1,y);(x+1,y);(x,y+1);(x-1,y+1);(x+1,y+1)])
	    with
	    | Not_found -> (x,y)
	in
	let state' = transition.(state).(y'-y).(x'-(x-1)) in

	ignore (try img.[x+y*w] <- Char.chr 0; with
	| Invalid_argument _ -> Printf.printf "at %d,%d\n" x y;);

        (* this is if you want lines greater than 255 pixels long not allowed *)
        (*let is_too_long = distance_sqr (x',y') > (255*255) in*)
        let is_too_long = false in

	if state' = -1 or is_too_long then
	    ((i_x,i_y),(x,y))
	else
	    (match_line (img,w,h) (i_x,i_y) (x',y') c state')
    else
	raise Bad_state
    ;;
    

let main unit =
    let (img,w,h,_) = Pcx.load (open_in_bin Sys.argv.(1)) in

    let grab_line (x,y) c genre =
	if x = w || y = h then raise Exit;

	let l = match_line (img,w,h) (x,y) (x,y) c 0 in

        let m_y = ((snd (snd l))-(snd (fst l)))
        and m_x = ((fst (snd l))-(fst (fst l))) in

        let g = let p = (m_y > 0) = (m_x > 0) in
            match genre with
            | 15 when p -> 2
            | 15 -> 3
            | 14 when p -> 1
            | 14 -> 0
            | 13 when p -> 2 lor 4
            | 13 -> 4
            | 12 when p -> 2 lor 8
            | 12 -> 3 lor 8
            | 11 when p -> 1 lor 8
            | 11 -> 0 lor 8
            | 10 when p -> 2
            | 10 -> 0
            | 9 -> 0 lor 16
            | 8 -> 0 lor 32
            (* alternate normal colors *)
            | 1 when p -> 2
            | 1 -> 3
            | 0 when p -> 1
            | 0 -> 0
            | _ -> invalid_arg ("Unhandled genre: " ^ (string_of_int genre))
        in

        let friction g = if g = 10 then 3 else if g = 8 then 10 else 64 in

	Printf.printf "%d\t%d\t%d\t%d\t%d\t%d\n"
	    (fst (fst l)) (snd (fst l))
	    (fst (snd l)) (snd (snd l))
	    g (friction genre);
	    (* ((float_of_int ((snd (snd l)) - (snd (fst l)))) /.
	       (float_of_int ((fst (snd l)) - (fst (fst l))))); *)
    in

    for c = 240 to 255 do
	let x = ref 0 and y = ref 0 in
	let loop = ref true in

	while !loop do
	    let (x',y') = try find_first (img,w,h) (!x,!y) c with
			  | Exit -> loop := false; (w,h)
	    in
	    x := x'; y := y';
	    try grab_line (!x,!y) c (c-240) with
	    | Exit -> loop := false;
	done;
    done;
    ;;

main ();;

(* EOF pcx2lns.ml *)
