-module(my_file).
-export([read/1]).


read(File) ->
  read_handler(file:read_file(File)).

read_handler({ok, Bin}) ->
  Bin;
read_handler({error, Why}) ->
  error({errorReadFile, Why}).

