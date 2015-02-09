-module(indexing).

-export([
         raw_document/1,
         document/1
        ]).

-define(WORD_DELIM, " \n\t.;?:!|()[]=|\\/<>\"*&^%$#@`").

raw_document(FileName) ->
  case file:open(FileName, [read]) of
    {ok, IoDevice}  -> raw_document(IoDevice, []);
    {error, Reason} -> exit({error,Reason})
  end.

raw_document(IoDevice, Lines) ->
  case file:read_line(IoDevice) of
    {ok,    Data}   -> raw_document(IoDevice, [Data|Lines]);
    eof             -> Lines;
    {error, Reason} -> exit({exit,Reason})
  end.
