(* lbs2heft
 * Take a value in imperial pounds and return the number of hefts.
 *
 * $Id: lbs2heft.ml,v 1.1 2002/09/08 13:05:33 tek Exp $
 *)

let b = 1.04 in (* the universal heft constant *)
let v = read_float() in

Printf.printf "%g lbs. is %g hefts\n" v ((log v)/.(log b));;
