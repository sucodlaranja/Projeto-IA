
:- consult('Menu.pl').


main :-
    menu,
    read(X),
    option(X).

    
%ta a dar um bug no choose mas deve ser do meu compiler
option(1) :- estafetas(R),write(R),!.
option(2) :- !,encomendaHeader,encomendas(R),printEncomendas(R).
option(3) :- true,!.
option(4) :- !,menuencomenda.
option(5) :- !,menuestatisticas.
option(6) :- true,!.
option(7) :- !,writeln('Thank you for using our program!!!').
option(_) :- write('Not an option').

