
:- consult('Menu.pl').


main :-
    menu,
    read(X),
    option(X).
    

    

option(1) :- !,estafetasHeader,estafetas(R),printEstafetas(R).
option(2) :- !,encomendaHeader,encomendas(R),printEncomendas(R).
option(3) :- !,transporteHeader,transportes(R),printList(R).
option(4) :- !,menuEncomenda.
option(5) :- !,menuestatisticas.
option(6) :- !,menuEntrega.
option(7) :- !,printTabelaPreco.
option(8) :- !,menuMudaPreco.
option(9) :- !,writeln('Thank you for using our program!!!'),fail.
option(_) :- write('Not an option').

