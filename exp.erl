- module(exp).
- export([
          exp/1,
          print/1
         ]).

p_lb() -> io:format("(").
p_rb() -> io:format(")").
p_mi() -> io:format(" - ").
p_pl() -> io:format(" + ").
p_mu() -> io:format(" * ").
p_dv() -> io:format(" / ").
p_un() -> io:format("~~").
exp({num,       N         }) -> N;
exp({minus,     Exp1, Exp2}) -> exp(Exp1) - exp(Exp2);
exp({plus,      Exp1, Exp2}) -> exp(Exp1) + exp(Exp2);
exp({multiple,  Exp1, Exp2}) -> exp(Exp1) * exp(Exp2);
exp({devide,    Exp1, Exp2}) -> exp(Exp1) / exp(Exp2);
exp({unary,     Exp1      }) -> - exp(Exp1).

print({num,       N         }) -> io:format("~p",[N]);
print({minus,     Exp1, Exp2}) -> p_lb(), print(Exp1), p_mi(), print(Exp2), p_rb();
print({plus,      Exp1, Exp2}) -> p_lb(), print(Exp1), p_pl(), print(Exp2), p_rb();
print({multiple,  Exp1, Exp2}) -> p_lb(), print(Exp1), p_mu(), print(Exp2), p_rb();
print({devide,    Exp1, Exp2}) -> p_lb(), print(Exp1), p_dv(), print(Exp2), p_rb();
print({unary,     Exp1      }) -> p_un(), print(Exp1).

