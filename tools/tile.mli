(* Tile
 * a module for manipulating fixed-size tiles.
 * $Id: tile.mli,v 1.1 2002/09/04 14:32:00 tek Exp $
 *)

type t = string

exception Bad_tile

val equal : t -> t -> bool
val hash : t -> int
val grab : string -> int -> int -> int -> t
val quantize : t -> t*int
val flip_h : t -> t
val flip_v : t -> t

(* EOF tile.mli *)
