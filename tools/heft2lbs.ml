(* heft2lbs
 * Take a heft value and return the number of pounds.
 *
 * $Id: heft2lbs.ml,v 1.1 2002/09/08 13:05:33 tek Exp $
 *)

let b = 1.04 in (* the universal heft constant *)
let v = read_float() in

Printf.printf "%g hefts is %g lbs.\n" v (b**v);
