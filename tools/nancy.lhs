
				 Nancy
	   a tool to construct 2D segment trees from textual
			   line segment data.

			      Convergence
		    Copyright Pureplay Games / 2002
	   $Id: nancy.lhs,v 1.11 2002/12/07 18:03:48 tek Exp $


OVERVIEW


Nancy's purpose in life is to build segment trees from LNS format line
data.  She works best in combination with pcx2lns, which extracts LNS
data from PCX images.  The following list roughly sketches Nancy's
typical operation:

    * Read in LNS data.
    * Extract the endpoints of these lines.
    * Create an empty segment tree from the elementary intervals formed
      by these endpoints.
    * Populate this segment tree with the lines.
    * Output the finished tree in binary form.


> module Main where
> import Char
> import Data.FiniteMap
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

A segment tree is an ordinary binary tree, where each node has
associated with it a horizontal span and a list of lines.  The lines are
stored as indices into the table of lines.

> data SegTree = Empty
>              | Node { left :: SegTree, right :: SegTree,
> 	                x_span :: (Integer,Integer), linelist :: [Integer] }



For the purposes of debugging, we define show instances for segment
trees and lines.

> instance Show SegTree where
>     showsPrec p = showTree
 
> showTree Empty s = "empty" ++ s
> showTree Node { left = l, right = r, x_span = x_s, linelist = ll } s =
>     "< " ++ show x_s ++ " " ++ show ll ++ " " ++
>     showTree l " " ++ showTree r " " ++ " >" ++ s
 
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


This dumps the tree in dot format, which is very handy for visualizing
the trees.

> dotTree name t = "digraph " ++ filter dotChars name ++ " { " ++ (dotTree' t 0) ++ " }"

> dotTree' Empty _ = ""
> dotTree' t i | is_leaf t = "n"++(show i)++" [label=\""++(show $ x_span t)++
>                            "\",shape=box]; "
>              | otherwise = "n"++(show i)++" [label=\""++(show $ x_span t)++"\"]; " ++
>			     "n"++(show i)++" -> n"++(show (2*i+1))++"; "++
>                            "n"++(show i)++" -> n"++(show (2*i+2))++"; "++
>                            dotTree' (left t) (2*i+1) ++
>                            dotTree' (right t) (2*i+2)
>   where is_leaf Node { left = Empty, right = Empty } = True
>         is_leaf _ = False

> dotChars '.' = False
> dotChars '/' = False
> dotChars _ = True


PARSING THE INPUT

The readGeomLine function parses a string containing a geometric line
from a .lns file into our internal representation of a line.

> readGeomLine s w = case (map (read) $ words s)
>		     of (x:y:x':y':t:f:[]) ->
>                           Line { start = (x,y), finish = (x',y'),
>			        genre = t, friction = f, idx = 0,
>                               world = w }
>		        _ -> error "nancy: Bad line read."

These functions fill in the monotonically increasing index values for
the lines in the finite map.  They also do appropriate things to combine
the world values.

> idxList [] n = []
> idxList (x:xs) n = (x {idx=n}):(idxList xs (n+1))

> idxFM' fm (x,k) = addToFM (delFromFM fm k) k (y {idx=toInteger x})
>	where y = case lookupFM fm k of
>                   Just foo -> foo
>                   Nothing  -> error $ "No such key: " ++ show k

> idxFM fm = foldl idxFM' fm (zip [1..sizeFM fm] $ keysFM fm)


Our main function reads in the line list from standard input.  We then
extract an indexed and sorted list of the X coordinates of the end
points, and make a skeleton segment trees from them.

We process each file specified in the arguments, merging the lines into
one database (while keeping each tree seperate).


> main = do args <- System.getArgs
>	    let files = tail args
>	    inData <- mapM readFile $ files
>	    let linebankName = (args !! 0) ++ ".lnd"
>	    let parseFile (x,y) = map (\z -> readGeomLine z x) $ lines y
>	    let inData' = (concat$map parseFile$zip [Alpha,Beta] inData)
>           let keyify l = (start l, finish l, genre l, friction l)
>           let mergefun x y = let a = world x
>                                  b = world y
>                              in case (a,b)
>                              of (Alpha,Beta) -> x {world=Both}
>                                 (Beta,Alpha) -> x {world=Both}
>                                 _ -> error $ "mergefun: Got something" ++
>                                              "weird:" ++ show x ++
>                                              show y
>	    let fm = idxFM $
>                    foldl (\x y -> addToFM_C (mergefun) x (keyify y) y)
>                    emptyFM inData'
>	    let lineList = eltsFM fm
>           if (length lineList) > 2048
>               then error $ "nancy: Too many lines! (" ++ (show$length lineList) ++
>                    "): " ++ show args ++ ":" ++ show lineList
>               else putStrLn $ "nancy: number of lines: " ++ (show $ length lineList)
>           writeFile linebankName (dumpLines lineList)
>	    let trees = map (\x -> treeify fm x) (zip files [Alpha,Beta])
>	    mapM (\(x,y) -> writeFile (basename x++"tree") (dumpTree y)) trees
>	    {- let d x = dotTree (fst x) (snd x)
>	       mapM (\x -> putStrLn $ d x) trees -}


> basename s = reverse $ dropWhile (\x->x/='.') $ reverse s

The hspan function grabs the horizontal span from a line as a tuple in
the form (least,greatest).

> hspan line = (min x x', max x x')
>   where x  = fst (start line)
>         x' = fst (finish line)


We get our normalized endpoints via the following function.

> endpoints ll = List.sort . List.nub . (\l -> fst l ++ snd l) . unzip $
>	         map hspan ll


To determine a tree's maximum depth, we recursively descend it, as
follows.

> depth tree = depth' tree 0

> depth' Empty d = d
> depth' Node {left=l,right=r} d = max (depth' l (d+1)) (depth' r (d+1))

> maxPop Empty m = m
> maxPop Node{left=l,right=r,linelist=ll} m =
>	max (max (length ll) m) (max (maxPop l m) (maxPop r m))


SKELETON TREES


We construct the empty segment tree as follows:

If there are at least two nodes in the list, we take the first two nodes
and join them by creating a higher level node.  Note that we always
build nodes with line lists populated only with the zero terminator.

> buildTree' (x1:x2:xs) = let s = (fst $ x_span x1, snd $ x_span x2)
> 			      n = Node { left = x1, right = x2,
>                                        x_span = s, linelist = [0] }
>                         in n : buildTree' xs

Otherwise, if there's only a single remaining node, we put it in the new
list as is.

> buildTree' xs	       = xs
 
We repeat this process until the highest level tree has only one node
(the root).
 
> buildTree list = if length t > 1 then buildTree t else t
>		   where t = buildTree' list


The unit_node and span_node functions are convenient for the purposes of
creating empty endpoint nodes and empty span nodes, respectively.  We
create each node with its terminating 0 line for convenience in dumping
the output.

> unit_node x = Node { left = Empty, right = Empty, x_span = (x,x),
>		       linelist = [0] }

> span_node x x' = Node { left = Empty, right = Empty, x_span = (x,x'),
>		          linelist = [0] }


Creating the empty tree from the elementary intervals involves putting
in both the endpoints and the spaces between the endpoints.

> emptyTree list = head . buildTree . intervals $ endpoints list

> intervals [] = []
> intervals (x1:x2:xs) | x2-x1 > 1 = u1:(span_node (x1+1) (x2-1)):intervals (x2:xs)
>                      | otherwise = u1:intervals (x2:xs)
>   where u1 = unit_node x1
>	  u2 = unit_node x2
> intervals (x1:xs) = unit_node x1:intervals xs


POPULATING THE TREE


> treeify fm (n,w) = (n, foldl populate (emptyTree ls) ls)
>   where wmatch w' = case (w,w')
>                     of (Alpha,Alpha) -> True
>                        (Beta,Beta)   -> True
>                        (_,Both)      -> True
>                        _             -> False
>         ls = filter (\l -> wmatch (world l)) $ eltsFM fm


Now we must fill in the line lists inside the tree.  We should also sort
the lines by their minimal vertical component, but there isn't a current
need for that.

If the line completely spans the area covered by the current node, we
insert it's index into the line list for this node.  Otherwise, we
attempt to populate the left and right children of this node.

> populate Empty _ = Empty
> populate t l | l `spans` t = t {linelist=(idx l) : (linelist t)}
>              | otherwise   = t {left = choose (left t),
>                                 right = choose (right t)}
>   where spans l t = let (x,x') = hspan l in x <= xl t && x' >= xr t
>         xl t = fst $ x_span t
>         xr t = snd $ x_span t
>         choose Empty = Empty
>         choose t = let (x,x') = hspan l in
>                    if (max (xl t) x) <= (min (xr t) x') then populate t l
>                    else t


DUMPING THE FINISHED PRODUCT


Now that we have our nicely populated segment tree, we have to do a few
things to coerce it into the correct format.  First, we have to dump the
line segment bank in a binary format.

> toHword x | x >= 0 && x < 65536 = [chr $ fromInteger (x `mod` 256), 
>	                             chr $ truncate ((toRational x)/256)]
>	    | otherwise           = error "toHword: bad x"

> toByte x | x >= 0 && x < 256 = [chr $ fromInteger (x `mod` 256)]
>          | otherwise         = error "toByte: bad x"

In front of the real lines, we dump a dummy record which contains the
length of the whole bank (including the dummy record).

> dumpLines ll = (toHword $ toInteger $ length ll' + 12) ++
>		 toHword 0 ++ toHword 0 ++ toHword 0 ++
>		 toHword 0 ++ toHword 0 ++ ll'
>   where ll' = dumpLines' ll

> dumpLines' [] = ""
> dumpLines' (l@(Line{start=(x1,y1),finish=(x2,y2)}):ls) =
>	toHword x1 ++ toHword y1 ++ toHword x2 ++ toHword y2 ++
>	toByte (friction l) ++ toByte ((genre l) + w) ++
>       toByte 0 ++ toByte 0 ++ dumpLines' ls
>   where w = case world l
>             of Alpha -> 64
>                Beta  -> 128
>                Both  -> 192


Finally we use dumpTree to dump the segment tree in a format appropriate
for GBA consumption.  

To dump the tree itself, we have to convert its contents to an
appropriate binary representation, and determine both its own length and
the length of its left node, so as to write out the correct pointers.

The tricky thing about dumping the tree is that the length of each
element is variable, because of the line lists.  We have to come back
and write the pointers afterwards.

> dumpLL [] align | align == 0 = ""
>                 | otherwise  = toHword 0
> dumpLL (x:xs) align | align == 0 = toHword x ++ (dumpLL xs 1)
>                     | otherwise  = toHword x ++ (dumpLL xs 0)

> dumpTree Empty = ""
> dumpTree Node{left=l,right=r,x_span=(x,x'),linelist=ll} =
>	toHword leftptr ++ toHword rightptr ++ toHword x ++
>       toHword x' ++ lldump ++ leftnode ++ rightnode
>   where lldump    = dumpLL ll 0
>	  leftnode  = dumpTree l
>	  rightnode = dumpTree r
>         leftptr   = if length leftnode > 0 then
>			pointerify (length lldump + 8)
>		      else 0
>	  rightptr  = if length rightnode > 0 then
>			pointerify (length lldump + 8 + length leftnode)
>                     else 0

Pointers are not only relative, but also shifted right by two bits, as
they are guaranteed to be word aligned.

> pointerify x | x `mod` 4 == 0 = truncate ((toRational x)/4)
>              | otherwise      = error "pointerify: value not mod 4!"

