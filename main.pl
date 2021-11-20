
:- consult('Menu.pl').


main :-
    menu,
    read(X),
    option(X).

    
%ta a dar um bug no choose mas deve ser do meu compiler
option(1) :- estafetas(R),write(R),!.
option(2) :- true,!.
option(3) :- true,!.
option(4) :- menuencomenda,!.
option(5) :- menuestatisticas,!.
option(_) :- write('Not an option').

