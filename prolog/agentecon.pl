% agentecon: a market of buyer and seller agents cleared as a double auction. Buyers are sorted
% from the highest value, sellers from the lowest cost, and pairs trade while the buyer values the
% good at least as much as the seller's cost. Everyone trades at one price, halfway between the
% last trading pair, so no agent loses by trading and the total gain from trade is the largest
% possible.
%?- clear([10, 8, 3], [2, 5, 9], R).   % R = market(2, 6, [10-2, 8-5])  (2 trades at price 6)
%?- surplus([10, 8, 3], [2, 5, 9], S). % S = 11
:- module(agentecon, [clear/3, surplus/3, best_surplus/3, payments/2]).
:- use_module(library(lists)).
:- use_module(library(apply)).

% clear(+BuyerValues, +SellerCosts, -market(Trades, Price, Pairs)); Price is none with no trades.
clear(Bs, Ss, market(K, P, Pairs)) :- msort(Bs, B0), reverse(B0, Bd), msort(Ss, Sa), pairs_trade(Bd, Sa, Pairs), length(Pairs, K), ( last(Pairs, B-S) -> P is (B + S) // 2 ; P = none ).
pairs_trade([B|Bs], [S|Ss], [B-S|Ps]) :- B >= S, !, pairs_trade(Bs, Ss, Ps).
pairs_trade(_, _, []).

surplus(Bs, Ss, X) :- clear(Bs, Ss, market(_, _, Ps)), foldl([B-S, A0, A]>>( A is A0 + B - S ), Ps, 0, X).

% best_surplus(+Bs, +Ss, -Max): brute force over every equal-sized choice of buyers and sellers.
best_surplus(Bs, Ss, Max) :- findall(X, ( sub(Bs, B1), sub(Ss, S1), length(B1, N), length(S1, N), sum_list(B1, SB), sum_list(S1, SS), X is SB - SS ), Xs), max_list(Xs, Max).
sub([], []).
sub([X|Xs], [X|Ys]) :- sub(Xs, Ys).
sub([_|Xs], Ys) :- sub(Xs, Ys).

% payments(+Market, -Paid-Received): money buyers pay and sellers receive.
payments(market(K, P, _), Paid-Received) :- ( P == none -> Paid = 0 ; Paid is K * P ), Received = Paid.
