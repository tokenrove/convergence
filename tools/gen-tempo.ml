

(* produce value for timer set for given tempo *)
let conv t = 3600. /. ((t +. 60.) /. 4.);;

for i = 0 to 255 do
    Format.printf "%d, " (int_of_float (conv (float_of_int i)));
done;;
