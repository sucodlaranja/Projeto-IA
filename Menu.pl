menu :-
    write('--------------------------------MENU-----------------------------------'),nl,nl,
    write('1 - consultar os estafetas'),nl,
    write('2 - consultar encomendas'),nl,
    write('3 - consultar transporte'),nl,
    write('4 - adicionar encomenda'),nl,
    write('5 - verificar estatisticas encomendas'),nl,
    write('6 - Exit'),nl,
    write('Choose: ').


%falta adicionar o algoritmo que verifica que e possivel e que verifica a data.
%output vai ser um conjunto de frases com a seguinte informacao: estafeta,transporte ou false se nao for possivel
menuencomenda :- 
    write('Peso: '),read(Peso),
    write('prazo: '),read(Prazo),
    write('freguesia',read(Freguesia)),
    write('data(XX-YY-ZZZZ,hh:mm'),read(Data).


menuestatisticas :- 
    write('1 - estafeta mais ecologico'),nl,
    write('2 - entrega a determinado cliente'),nl,
    write('3 - clientes servidos por um determinado estafeta'),nl,
    write('4 - valor faturado num determinado dia'),nl,
    write('5 - zonas com maior volume de entregas'),nl,
    write('6 - classificacao media de um estafeta'),nl,
    write('7 - numero total de entregas pelos diferentes meios de transporte'),nl,
    write('8 - numero total de encomendas entregues e nao entregues num determinado intervalo de tempo'),nl,
    write('9 - calcular o peso total transportado por estafeta num determiado dia'),nl,
    write('10 - voltar atras').