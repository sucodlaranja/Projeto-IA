
:- consult('Menu.pl').


main :-
    repeat,
    menu(X),
    option(X).
    
    

    

option(1) :- !,estafetasHeader,estafetas(R),printEstafetas(R),continue,main.
option(2) :- !,encomendaHeader,encomendas(R),printEncomendas(R),continue,main.
option(3) :- !,transporteHeader,transportes(R),printList(R),continue,main.
option(4) :- !,circuitoHeader,circuitos(R),printList(R),continue,main.
option(5) :- !,menuaddEstafeta,continue,main.
option(6) :- !,menuaddTransporte,continue,main.
option(7) :- !,menuEncomenda,continue,main.
option(8) :- !,menuestatisticas,continue,main.
option(9) :- !,menuEntrega,continue,main.
option(10) :- !,printTabelaPreco,continue,main.
option(11) :- !,menuMudaPreco,continue,main.
option(12) :- !,menuVariasEncomendas,continue,main.
option(13) :- !,writeln('Obrigado por utilizar o nosso programa!!!').
option(_) :- invalida,main.

