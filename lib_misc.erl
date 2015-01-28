-module(lib_misc).
-export([for/3,
         qsort/1,
         pythag/1,
         perms/1,
         filter/2,
         odds_and_evens/1,
         odds_and_evens2/1,
         my_time_func/1,
         my_tuple_to_list/1,
         my_date_string/0,
         count_characters/1,
         map_search_pred/2,
         map_search_pred1/2
        ]).

for(Max, Max, F) -> [F(Max)];
for(I, Max, F)   -> [F(I) | for(I+1, Max, F)].

qsort([]) -> [];
qsort([Pivot|T]) ->
  qsort([X || X <-T, X < Pivot])
  ++ [Pivot] ++
  qsort([X || X <-T, X >= Pivot]).

pythag(N) ->
  [ {A, B, C} ||
    A <- lists:seq(1,N),
    B <- lists:seq(1,N),
    C <- lists:seq(1,N),
    A+B+C =< N,
    A*A + B*B =:= C*C
  ].


perms([]) -> [[]];
perms(L) -> [[H|T] || H <- L, T <- perms(L--[H])].

filter(P, [H|T]) ->
  case P(H) of
    true  -> [H|filter(P,T)];
    false -> filter(P,T)
  end;
filter(_,[]) ->
  [].

odds_and_evens(L) ->
  Odds  = [X || X <- L, (X rem 2) =:= 1],
  Evens = [X || X <- L, (X rem 2) =:= 0],
  {Odds, Evens}.

odds_and_evens2(L) ->
  odds_and_evens_acc(L,[],[]).

odds_and_evens_acc([H|T], Odds, Evens) ->
  case(H rem 2) of
    1 -> odds_and_evens_acc(T, [H|Odds], Evens);
    0 -> odds_and_evens_acc(T, Odds, [H|Evens])
  end;
odds_and_evens_acc([], Odds, Evens) ->
  {lists:reverse(Odds),lists:reverse(Evens)}.

my_tuple_to_list({})    ->
  [];
my_tuple_to_list(Tuple) ->
  E1 = erlang:element(1,Tuple),
  [E1|my_tuple_to_list(erlang:delete_element(1,Tuple))].

my_time_func(F) -> 
  Start   = erlang:now(),
  Result  = F(),
  Stop    = erlang:now(),
  {timer:now_diff(Stop, Start), Result}.

my_date_string() ->
  {Year, Month, Day}  = erlang:date(),
  {Hour, Minute, Sec} = erlang:time(),
  io:format("~B-~2..0B-~2..0B ~2..0B:~2..0B:~2..0B~n",[Year,Month,Day,Hour,Minute,Sec]).


count_characters(Str) ->
  count_characters(Str, #{}).

count_characters([H|T],X) ->
  count_characters(T, maps:put(H, maps:get(H,X,0) + 1, X));
count_characters([], X) ->
  X.

map_search_pred(Map, Pred) ->
  lists:nth(1,[
              {Key, Value} || {Key, Value} <- maps:to_list(Map),
                              Pred(Key,Value) =:= true
             ]).

map_search_pred1(Map, Pred) when is_map(Map) ->
  map_search_pred1(maps:to_list(Map), Pred);
map_search_pred1([], _) ->
  {error,not_found};
map_search_pred1([{Key,Value}|T], Pred) ->
  case Pred(Key,Value) of
    false -> map_search_pred1(T, Pred);
    true  -> {ok,{Key,Value}}
  end.

