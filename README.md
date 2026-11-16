# agentecon

a market of buyer and seller agents cleared as a double auction. Buyers are sorted from the highest value, sellers from the lowest cost, and pairs trade while the buyer values the good at least as much as the seller's cost. Everyone trades at one price, halfway between the last trading pair, so no agent loses by trading and the total gain from trade is the largest possible.

## Use

```prolog
?- use_module(prolog/agentecon).
?- clear([10, 8, 3], [2, 5, 9], R).   % R = market(2, 6, [10-2, 8-5])  (2 trades at price 6)
?- surplus([10, 8, 3], [2, 5, 9], S). % S = 11
```

## Proofs

`proofs/theorems.pl` proves 4 theorems by exhaustion: each one is checked for every case in a finite domain that covers every branch of the definitions. 0..3 buyers and 0..3 sellers, each value or cost from 1..4.

1. The market's gain from trade is the largest possible.
2. No agent loses: every trading buyer values the good at least the price, every trading seller's cost is at most it.
3. Money is conserved: buyers pay what sellers receive.
4. Adding a buyer never reduces the number of trades or the gain from trade.

```sh
swipl -g main -t halt proofs/theorems.pl
```

## 200 inputs and outputs

`io/ios.txt` lists 200 inputs and outputs from real runs, and `io/ios.pl` has the same as Prolog facts. The inputs come from a fixed seed (`io/cases.pl`). `swipl -g check -t halt io/run.pl` runs them again. It fails if any output changes, or if a predicate doesn't confirm its own recorded output, which checks steadfastness. GitHub Actions runs the proofs and the examples on every push, and records the examples on the first push.

Licence: BSD-3-Clause.
