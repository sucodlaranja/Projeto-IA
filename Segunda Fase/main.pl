
:- consult('Menu.pl').


main :-
    repeat,
    menu(X),
    option(X).
    
    

    

option(1) :- !,estafetasHeader,estafetas(R),printEstafetas(R),continue.
option(2) :- !,encomendaHeader,encomendas(R),printEncomendas(R),continue.
option(3) :- !,transporteHeader,transportes(R),printList(R),continue.
option(4) :- !,menuEncomenda,continue.
option(5) :- !,menuestatisticas,continue.
option(6) :- !,menuEntrega,continue.
option(7) :- !,printTabelaPreco,continue.
option(8) :- !,menuMudaPreco,continue.
option(9) :- true.
option(10) :- !,writeln('Obrigado por utilizar o nosso programa!!!').
option(_) :- invalida.

