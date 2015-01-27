-module(math_functions).
-export([even/1, odd/1, filter/2, split1/1,split2/1]).


even(X) when (X rem 2) =:= 0 -> true;
even(_) -> false.

odd(X) when (X rem 2) =:= 1 -> true;
odd(_) -> false.

filter(_,[])    -> [];
filter(F,L) ->
  [X || X <- L, F(X) =:= true].


split1(L) ->
  Odd  = filter(fun(X) -> odd(X) end, L),
  Even = filter(fun(X) -> even(X) end, L),
  {Even, Odd}.

split2(L) ->
  split_acc(L,[],[]).

split_acc([H|T], Even, Odd) ->
  case H rem 2 of
    0 -> split_acc(T, [H|Even],Odd);
    1 -> split_acc(T, Even, [H|Odd])
  end;
split_acc([], Even, Odd) ->
  {lists:reverse(Even), lists:reverse(Odd)}.

