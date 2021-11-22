
isPar(X):-mod(X,2) =:= 0.
isImpar(X):-mod(X,2) =\= 0.

%valida a data da encomenda
validadata(date(Y,2,D,H,Min,_,_,_,_)) :- 
    Y mod 4 =\= 0,
    D >=1,D=<29,
    Y > 2000,
    H>= 0, H=<23,
    Min>=1,Min=<59.
validadata(date(Y,2,D,H,Min,_,_,_,_)) :- 
    Y mod 4 =:= 0,
    D >=1,D=<28,
    Y > 2000,
    H>= 0, H=<23,
    Min>=1,Min=<59.


validadata(date(Y,M,D,H,Min,_,_,_,_)) :- 
    isImpar(M),
    D >= 1,D =< 31,
    Y > 2000,
    H>= 0, H=<23,
    Min>=1,Min=<59.
validadata(date(Y,M,D,H,Min,_,_,_,_)) :- 
    isPar(M),
    D >=1,D=<30,
    Y > 2000,
    H>= 0, H=<23,
    Min>=1,Min=<59.

take(N, _, Xs) :- N =< 0, !, N =:= 0, Xs = [].
take(_, [], []).
take(N, [X|Xs], [X|Ys]) :- M is N-1, take(M, Xs, Ys).

second_pair((_,B),B).
%https://www.swi-prolog.org/pldoc/doc_for?object=date_time_stamp/2