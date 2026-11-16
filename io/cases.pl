:- module(cases, [title/1, case/3]).
:- use_module('../prolog/agentecon').
:- use_module(engine).
title('agentecon').
side_g(Xs) :- rnd_int(0, 6, N), length(Xs, N), maplist([X]>>rnd_int(1, 20, X), Xs).
case(clear, [Bs, Ss], clear) :- side_g(Bs), side_g(Ss).
case(surplus, [Bs, Ss], surplus) :- side_g(Bs), side_g(Ss).
case(best_surplus, [Bs, Ss], best_surplus) :- side_g(Bs), side_g(Ss).
