

This line code is liberally stolen from nancy.  I'm sure that eventually
it will be broken into its own module.

> module Main where
> import Char
> import Data.FiniteMap
> import Data.Bits
> import Monad
> import qualified System
> import qualified List


TYPES


> data World = Alpha | Beta | Both

We define lines by their end points and the line type associated with
them.  Line type is called genre here to avoid conflicts with reserved
words.

> data Line = Line { start :: (Integer,Integer),
>		     finish :: (Integer,Integer),
>		     genre :: Integer, friction :: Integer,
>                    world :: World, idx :: Integer }

> instance Eq Line where
>   x == y = if start x == start y && finish x == finish y &&
>               genre x == genre y && friction x == friction y
>            then True else False

> instance Ord Line where
>   x <= y = if (fst $ start x) <= (fst $ start y) ||
>               (snd $ start x) <= (snd $ start y) ||
>               (fst $ finish x) <= (fst $ finish y) ||
>               (snd $ finish x) <= (snd $ finish y) ||
>               genre x <= genre y ||
>               friction x <= friction y
>            then True else False

> instance Show Line where
>	showsPrec p = showLine

> showLine l s =
>	show (start l) ++ "->" ++ show (finish l) ++ " t: " ++
>           show (genre l) ++ " f: " ++ show (friction l) ++
>           " w: " ++ show (world l) ++ " idx: " ++ show (idx l) ++ s

> instance Show World where
>       showsPrec p Alpha s = "alpha" ++ s
>       showsPrec p Beta s  = "beta" ++ s
>       showsPrec p Both s  = "both" ++ s


PARSING THE INPUT

The readGeomLine function parses a string containing a geometric line
from a .lns file into our internal representation of a line.

> readGeomLine s = case (map (read) $ words s)
>		   of (x:y:x':y':t:f:[]) ->
>                         Line { start = (x,y), finish = (x',y'),
>		                 genre = t, friction = f, idx = 0,
>                                world = Alpha }
>		      _ -> error "nancy: Bad line read."



MAIN

> main = do args <- System.getArgs
>           inData <- readFile (head args)
>           {- parse lines, filtering out lines we don't care about -}
>           let inLines = filter (\x->all (not.testBit (genre x)) [2,4,5]) $
>                         map readGeomLine $ lines inData
>           {- make polygon groups -}
>           let grp = make_groups inLines
>           {- do sanity check -}
>           let badgrps = filter (\x->(length x) < 3 || (not (adjacentp (head x) (last x)))) grp
>           when (length badgrps > 0) (putStrLn $ "unjoined error!" ++ show badgrps)
>           {- XXX add lines to join gaps -}
>           {- add points to polylist ordered by type -}
>           let grp' = map (concatMap line_to_points.reverse) grp
>           {- output groups -}
>           mapM (\x -> putStrLn "poly" >> mapM (putStrLn.show) x) grp'


ADJACENCY

Here are some primitives for determining adjacency.  For determining
whether two points are adjacent for our purposes (within one pixel
distance), we have point_adjacentp.

> point_adjacentp (x,y) (x',y') = (abs (x-x') <= 1) && (abs (y-y') <= 1)

For checking whether two lines are adjacent, we have adjacentp as
follows.

> adjacentp l l' = point_adjacentp s t || point_adjacentp s f ||
>                  point_adjacentp e t || point_adjacentp e f
>       where (s,e) = (start l, finish l)
>             (t,f) = (start l', finish l')

When making the groups, we start from any line and continue until
nothing else adjacent is left, and then repeat the process for the next
group until no lines remain.

These functions generally working through the tuple of lines in this
group and lines not in this group.  Each run through the adjacents
function, further lines are weeded out of the main list.

> make_groups [] = []
> make_groups (l:lines) = let (g,l') = adjacents l ([],lines) in
>                         g:make_groups l'
> adjacents x (gs,ls)   = let (xs,ls') = List.partition (adjacentp x) ls in
>                         f xs (x:gs,ls')
> f [] foo = foo
> f (x:xs) (gs,ls) = f xs (adjacents x (gs,ls))


THE POLYGON JOURNEY

> line_to_points l | t == 0 = if xs < xf || ys > yf then [s,f] else [f,s]
>                  | t == 1 = if xs > xf || ys > yf then [s,f] else [f,s]
>                  | t == 2 = if xs < xf || ys < yf then [s,f] else [f,s]
>                  | t == 3 = if xs > xf || ys < yf then [s,f] else [f,s]
>       where (s,f) = (start l, finish l)
>             ((xs,ys),(xf,yf)) = (s,f)
>             t = (genre l).&.3

EOF lns2poly.lhs
