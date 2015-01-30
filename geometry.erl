-module(geometry).
-author("abaranov@linux.com").
-export([area/1]).

area({rectangle, Width, Height}) -> Width * Height;
area({circle, Radius})           -> 3.14159 * Radius * Radius;
area({square, Side})             -> Side * Side;
area({triangle, A, B})           -> A*B / 2;
area(_)                          -> {error, invalid_object}.

