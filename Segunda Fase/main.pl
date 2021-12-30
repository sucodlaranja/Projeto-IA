
:- consult('Menu.pl').


main :-
    repeat,
    menu(X),
    option(X).
    
    

    

option(1) :- !,estafetasHeader,estafetas(R),printEstafetas(R),nl,writeln('escreva ok para continuar'),read(_),fail.
option(2) :- !,encomendaHeader,encomendas(R),printEncomendas(R),nl,writeln('escreva ok para continuar'),read(_),fail.
option(3) :- !,transporteHeader,transportes(R),printList(R),nl,writeln('escreva ok para continuar'),read(_),fail.
option(4) :- !,menuEncomenda,nl,writeln('escreva ok para continuar'),read(_),fail.
option(5) :- !,menuestatisticas,nl,writeln('escreva ok para continuar'),read(_),fail.
option(6) :- !,menuEntrega,nl,writeln('escreva ok para continuar'),read(_),fail.
option(7) :- !,printTabelaPreco,nl,writeln('escreva ok para continuar'),read(_),fail.
option(8) :- !,menuMudaPreco,nl,writeln('escreva ok para continuar'),read(_),fail.
option(9) :- !,writeln('Obrigado por utilizar o nosso programa!!!').
option(_) :- invalida.

