-module(mylists).
-export([
         sum/1,
         map/2,
         create/1,
         reverse_create/1,
         filter/2,
         reverse/1
        ]).

sum([H|T]) -> H + sum(T);
sum([])    -> 0.

map(F,[H|T]) -> [F(H)|map(F,T)];
map(_,[])    -> [].


create(N) when N >= 0 ->
  create(1,N);
create(_) -> [].

create(X,N) when X =< N ->
  [X|create(X+1,N)];
create(N,N) -> N;
create(_,_) -> [].

reverse_create(N) when N > 0 ->
  [N|reverse_create(N-1)];
reverse_create(_) -> [].

filter(List, Int) ->
  [X || X <- List, X =< Int].

reverse(List) ->
  reverse(List,[]).

reverse([Head|Tail], Acc) ->
  reverse(Tail,[Head|Acc]);
reverse([], Acc) -> Acc.
