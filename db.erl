-module(db).
-export([
         new/0,
         destroy/1,
         write/3,
         delete/2,
         read/2,
         match/2
        ]).


new() -> [].
destroy(_) -> ok.

write(Key, Element,Db) ->
  [{Key,Element}|Db].

delete(Key, Db) ->
  [{K,E} || {K,E} <- Db, K /= Key].

read(Key, [{Key,Element}|_]) ->
  {ok, Element};
read(Key,[_|Tail]) ->
  read(Key,Tail);
read(_,[]) ->
  {error, instance}.

match(Element, Db) ->
  [Key || {Key, E} <- Db, E =:= Element ].
