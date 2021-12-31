
:- consult('Menu.pl').


main :-
    repeat,
    menu(X),
    option(X).
    
    

    

option(1) :- !,estafetasHeader,estafetas(R),printEstafetas(R),continue.
option(2) :- !,encomendaHeader,encomendas(R),printEncomendas(R),continue.
option(3) :- !,transporteHeader,transportes(R),printList(R),continue.
option(4) :- !,true.
option(5) :- !,true.
option(6) :- !,menuEncomenda,continue.
option(7) :- !,menuestatisticas,continue.
option(8) :- !,menuEntrega,continue.
option(9) :- !,printTabelaPreco,continue.
option(10) :- !,menuMudaPreco,continue.
option(11) :- !,menuVariasEncomendas,continue.
option(12) :- !,writeln('Obrigado por utilizar o nosso programa!!!').
option(_) :- invalida.

