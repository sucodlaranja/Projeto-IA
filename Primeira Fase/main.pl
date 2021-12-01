
:- consult('Menu.pl').


main :-
    repeat,
    menu,
    read(X),
    option(X).
    
    

    

option(1) :- !,estafetasHeader,estafetas(R),printEstafetas(R),nl,writeln('Please insert ok'),read(_),fail.
option(2) :- !,encomendaHeader,encomendas(R),printEncomendas(R),nl,writeln('Please insert ok'),read(_),fail.
option(3) :- !,transporteHeader,transportes(R),printList(R),nl,writeln('Please insert ok'),read(_),fail.
option(4) :- !,menuEncomenda,nl,writeln('Please insert ok'),read(_),fail.
option(5) :- !,menuestatisticas,nl,writeln('Please insert ok'),read(_),fail.
option(6) :- !,menuEntrega,nl,writeln('Please insert ok'),read(_),fail.
option(7) :- !,printTabelaPreco,nl,writeln('Please insert ok'),read(_),fail.
option(8) :- !,menuMudaPreco,nl,writeln('Please insert ok'),read(_),fail.
option(9) :- !,writeln('Thank you for using our program!!!').
option(_) :- write('Not an option').

