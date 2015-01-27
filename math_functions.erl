-module(math_functions).
-export([even/1, odd/1, filter/2]).


even(X) when (X rem 2) =:= 0 -> true;
even(_) -> false.

odd(X) when (X rem 2) =:= 1 -> true;
odd(_) -> false.

filter(_,[])    -> [];
filter(F,L) ->
  [X || X <- L, F(X) =:= true].

