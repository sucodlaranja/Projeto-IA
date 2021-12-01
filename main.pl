
:- consult('Menu.pl').


main :-
    repeat,
    menu,
    read(X),
    option(X),
    fail.
    

    

option(1) :- !,estafetasHeader,estafetas(R),printEstafetas(R),read(_).
option(2) :- !,encomendaHeader,encomendas(R),printEncomendas(R),read(_).
option(3) :- !,transporteHeader,transportes(R),printList(R),read(_).
option(4) :- !,menuEncomenda,read(_).
option(5) :- !,menuestatisticas,read(_).
option(6) :- !,menuEntrega,read(_).
option(7) :- !,printTabelaPreco,read(_).
option(8) :- !,menuMudaPreco,read(_).
option(9) :- !,writeln('Thank you for using our program!!!'),fail.
option(_) :- write('Not an option').

