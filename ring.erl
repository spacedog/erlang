-module(ring).
-export([
         start/3,
         loop/0
        ]).


start(Num, MNum, Message) ->
  Pid = spawn(?MODULE, loop, []),
  io:format("First spawned: ~w~n", [Pid]), 
  Procs = start(Num, Pid),
  Ring = lists:append(Procs, [hd(Procs)]),
  io:format("Ring is : ~w~n", [Ring]), 
  send_messages(MNum, Message, Ring).

send_messages(0, _, Ring) -> 
  send_message(quit, Ring);
send_messages(MNum, Message, Ring) ->
  send_message(Message, Ring),
  send_messages(MNum-1, Message, Ring).

send_message(_, []) ->
  ok;
send_message(Message, [{pid, Pid}| Tail]) ->
  Pid ! Message,
  send_message(Message, Tail).

start(0, Pid) ->
  io:format("Last spawned: ~w~n", [Pid]), 
  [{pid, Pid}];

start(Num, Pid) ->
  NextPid = spawn(?MODULE, loop, []),
  io:format("Spawned: ~w~n", [NextPid]), 
  [{pid, Pid} | start(Num -1, NextPid)].

loop() ->
  receive
    quit ->
      io:format("[~w]: Bye!~n", [self()]);
    Message ->
      io:format("[~w]: Received: ~w!~n", [self(), Message]),
      loop()
  end.
