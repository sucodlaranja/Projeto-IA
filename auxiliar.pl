
isPar(X):-mod(X,2) =:= 0.
isImpar(X):-mod(X,2) =\= 0.

%valida a data da encomenda
validadata(D,2,Y,H,M) :- 
    Y mod 4 =\= 0,
    D >=1,D=<29,
    Y > 2000,
    H>= 0, H=<23,
    M>=1,M=<59.
validadata(D,2,Y,H,M) :- 
    Y mod 4 =:= 0,
    D >=1,D=<28,
    Y > 2000,
    H>= 0, H=<23,
    M>=1,M=<59.


validadata(D,M,Y,H,M) :- 
    isImpar(M),
    D >= 1,D =< 31,
    Y > 2000,
    H>= 0, H=<23,
    M>=1,M=<59.
validadata(D,M,Y,H,M) :- 
    isPar(M),
    D >=1,D=<30,
    Y > 2000,
    H>= 0, H=<23,
    M>=1,M=<59.




