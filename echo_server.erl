-module(echo_server).
-export([
         start/0,
         stop/0,
         print/1,
         loop/0
        ]).


start() ->
  case whereis(?MODULE) of
    undefined ->
      PidA = spawn(?MODULE, loop, []),
      register(?MODULE, PidA),
      ok;
    Pid when is_pid(Pid) ->
      {error, already_started}
  end.

stop() ->
  case whereis(?MODULE) of
    Pid when is_pid(Pid) ->
      Pid ! {self(),{control, stop}},
      ok;
    undefined ->
      {error, not_started}
  end.
 
loop() ->
  receive
    {_Pid,{control, stop}} ->
      true;
    {_Pid, {print, Term}} ->
      io:format("~w~n", [Term]),
      loop();
    _Other ->
      {error, unknown_message}
  end.

print(Term) ->
  case whereis(?MODULE) of
    undefined ->
      exit({error, not_started});
    Pid when is_pid(Pid) ->
      Pid ! {self(),{print, Term}}
  end,
  ok.
