-module(boolean).
-author("abaranov@linux.com").
-export([
         b_not/1,
         b_and/2,
         b_or/2,
         b_nand/2
        ]).

b_not(false) -> true;
b_not(true)  -> false;
b_not(_)     -> {error,not_boolean}.


b_and(true,true) -> true;
b_and(_,_)       -> false.

b_or(true, false) -> true;
b_or(false, true) -> true;
b_or(_,_)         -> false.

b_nand(A,B) -> b_not(b_and(A,B)).

