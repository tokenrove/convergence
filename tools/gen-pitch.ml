(*
 * Generate pitch table
 *)

let xlate n = int_of_float ( 2048. *. ((n -. 64.) /. n) ) ;;

(* rest *)
Format.printf "0, ";;
(* starts from C-0 (65.40639133Hz) *)
let hz = ref 65.40639133;;
(* 7 octaves, 12 notes per octave *)
for i = 0 to 12*8 do
    (* ignore (Format.printf "%f, " !hz); *)
    ignore (Format.printf "%d, " (xlate !hz));
    hz := !hz *. (2. ** (1. /. 12.));
done;;
