(* PCX
 * $Id: pcx.mli,v 1.1 2002/09/04 14:32:00 tek Exp $
 *)

exception Bad_PCX

val load : in_channel -> string*int*int*string

(* EOF pcx.mli *)
