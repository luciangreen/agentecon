% Theorems, proved by exhaustion. Run: swipl -g main -t halt proofs/theorems.pl
:- module(theorems, [main/0]).
:- use_module(prove).
:- discontiguous theorem/1.
:- use_module(library(lists)).
:- use_module(library(apply)).
main :- prove_all(theorems).
:- use_module('../prolog/agentecon').

% Domain: 0..3 buyers and 0..3 sellers, each value or cost from 1..4.
side(Xs) :- between(0, 3, N), length(Xs, N), maplist([X]>>between(1, 4, X), Xs).

% 1. The market's gain from trade is the largest possible.
theorem(efficient) :- forall(( side(Bs), side(Ss) ), ( surplus(Bs, Ss, X), best_surplus(Bs, Ss, X) )).

% 2. No agent loses: every trading buyer values the good at least the price, every trading seller's cost is at most it.
theorem(individually_rational) :- forall(( side(Bs), side(Ss) ), ( clear(Bs, Ss, market(_, P, Ps)), forall(member(B-S, Ps), ( B >= P, P >= S )) )).

% 3. Money is conserved: buyers pay what sellers receive.
theorem(money_conserved) :- forall(( side(Bs), side(Ss) ), ( clear(Bs, Ss, M), payments(M, X-X) )).

% 4. Adding a buyer never reduces the number of trades or the gain from trade.
theorem(more_buyers_never_hurt) :- forall(( side(Bs), side(Ss), between(1, 4, V) ), ( clear(Bs, Ss, market(K, _, _)), clear([V|Bs], Ss, market(K2, _, _)), K2 >= K, surplus(Bs, Ss, X), surplus([V|Bs], Ss, X2), X2 >= X )).
