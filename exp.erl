- module(exp).
- export([
          evaluator/1,
          pretty_print/1,
          compile/1
         ]).

p_lb() -> io:format("(").
p_rb() -> io:format(")").
p_mi() -> io:format(" - ").
p_pl() -> io:format(" + ").
p_mu() -> io:format(" * ").
p_dv() -> io:format(" / ").
p_un() -> io:format("~~").

evaluator({num,       N         }) -> N;
evaluator({minus,     Exp1, Exp2}) -> evaluator(Exp1) - evaluator(Exp2);
evaluator({plus,      Exp1, Exp2}) -> evaluator(Exp1) + evaluator(Exp2);
evaluator({multiple,  Exp1, Exp2}) -> evaluator(Exp1) * evaluator(Exp2);
evaluator({devide,    Exp1, Exp2}) -> evaluator(Exp1) / evaluator(Exp2);
evaluator({unary,     Exp1      }) -> - evaluator(Exp1).

pretty_print({num,       N         }) -> io:format("~p",[N]);
pretty_print({minus,     Exp1, Exp2}) -> p_lb(), pretty_print(Exp1), p_mi(), pretty_print(Exp2), p_rb();
pretty_print({plus,      Exp1, Exp2}) -> p_lb(), pretty_print(Exp1), p_pl(), pretty_print(Exp2), p_rb();
pretty_print({multiple,  Exp1, Exp2}) -> p_lb(), pretty_print(Exp1), p_mu(), pretty_print(Exp2), p_rb();
pretty_print({devide,    Exp1, Exp2}) -> p_lb(), pretty_print(Exp1), p_dv(), pretty_print(Exp2), p_rb();
pretty_print({unary,     Exp1      }) -> p_un(), pretty_print(Exp1).


compile(Exp) -> compile(Exp,[]).

compile({num, Num},         Acc) -> [Num | Acc];
compile({Oper, Exp1, Exp2}, Acc) -> lists:concat([compile(Exp1),
                                                  compile(Exp2),
                                                  [Oper | Acc]
                                                 ]);
compile({unary, Exp},       Acc) -> lists:concat([compile(Exp),
                                                  [unary | Acc]
                                                 ]).
