

let xlat i = match i with
    | i when i = (Char.code ':') -> 36
    | i when i = (Char.code '!') -> 37
    | i when i = (Char.code '?') -> 38
    | i when i = (Char.code '\'') -> 39
    | i when i = (Char.code ',') -> 40
    | i when i = (Char.code ';') -> 41
    | i when i = (Char.code '.') -> 42
    | i when i = (Char.code '/') -> 43
    | i when i = (Char.code '*') -> 44
    | i when i = (Char.code '$') -> 45
    | i when i >= 48 && i <= 57 -> i - 21
    | i when i >= 65 && i <= 90 -> i - 64
    | i when i >= 97 && i <= 122 -> i - 96
    | _ -> 0;;

for i = 0 to 255 do
    ignore (Format.printf "%d, " (xlat i));
done;;
