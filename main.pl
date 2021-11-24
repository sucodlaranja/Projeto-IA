
:- consult('Menu.pl').


main :-
	repeat,
    menu,
    read(X),
    option(X),
    fail.

    
%ta a dar um bug no choose mas deve ser do meu compiler
option(1) :- !,estafetasHeader,estafetas(R),printEstafetas(R).
option(2) :- !,encomendaHeader,encomendas(R),printEncomendas(R).
option(3) :- !,transporteHeader,transportes(R),printList(R).
option(4) :- !,menuEncomenda.
option(5) :- !,menuestatisticas.
option(6) :- !,menuEntrega.
option(7) :- !,writeln('Thank you for using our program!!!').
option(_) :- write('Not an option').

