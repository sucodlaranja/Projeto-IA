:- consult('Funcionalidades.pl').
:- consult('Menu.pl').


main :-
    repeat,
    menu,
    read(X),
    option(X).

    
option(_) :- true.

option(5) :- 
    menuestatisticas,
    read(X),
    optionestatistica(X).
