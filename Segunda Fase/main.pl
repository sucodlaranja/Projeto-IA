
:- consult('Menu.pl').


main :-
    repeat,
    menu(X),
    option(X).
    
    

    

option(1) :- !,estafetasHeader,estafetas(R),printEstafetas(R),continue,main.
option(2) :- !,encomendaHeader,encomendas(R),printEncomendas(R),continue,main.
option(3) :- !,transporteHeader,transportes(R),printList(R),continue,main.
option(4) :- !,continue,main.
option(5) :- !,continue,main.
option(6) :- !,menuEncomenda,continue,main.
option(7) :- !,menuestatisticas,continue,main.
option(8) :- !,menuEntrega,continue,main.
option(9) :- !,printTabelaPreco,continue,main.
option(10) :- !,menuMudaPreco,continue,main.
option(11) :- !,menuVariasEncomendas,continue,main.
option(12) :- !,writeln('Obrigado por utilizar o nosso programa!!!').
option(_) :- invalida,main.

