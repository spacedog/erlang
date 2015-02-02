-module(exception).
-export([try_return/1]).

return_error(X) when X < 0 ->
  throw({'EXIT', {badarithy,
                 [{exception, return_error,1},
                  {erl_eval, do_apply, 5},
                  {shell, exprs, 6},
                  {shell, eval_exprs, 5},
                  {shell, eval_loop, 3}]}});
return_error(X) when X == 0 ->
  1/X;

return_error(X) when X > 0 ->
  {'EXIT', {badarithy, [{exception, return_error,1},
                        {erl_eval, do_apply, 5},
                        {shell, exprs, 6},
                        {shell, eval_exprs, 5},
                        {shell, eval_loop, 3}]}}.


try_return(X) when is_integer(X) ->
  try return_error(X) of
    Val -> {normal, Val}
  catch
    exit:Reason -> {exit, Reason};
    trow:Throw  -> {throw,Throw};
    error:Error -> {error, Error}
  end.
