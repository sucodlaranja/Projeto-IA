:- consult('Funcionalidades.pl').
menu :-
    writeln('--------------------------------MENU-----------------------------------'),nl,
    writeln('1 - consultar os estafetas'),
    writeln('2 - consultar encomendas'),
    writeln('3 - consultar transporte'),
    writeln('4 - adicionar encomenda'),
    writeln('5 - verificar estatisticas encomendas'),
    writeln('6 - finalizar entrega'),
    writeln('7 - Exit'),
    write('Choose: ').


%falta adicionar o algoritmo que verifica que e possivel e que verifica a data.
%output vai ser um conjunto de frases com a seguinte informacao: estafeta,transporte ou false se nao for possivel
menuencomenda :- 
    write('Peso: '),read(Peso),
    write('prazo: '),read(Prazo),
    write('freguesia:'),read(Freguesia),
    write('insira ano: '),read(Ano),
    write('insira mes: '),read(Mes),
    write('insira dia: '),read(Dia),
    write('insira hora: '), read(Hora),
    write('insira minutos: '),read(Minutos),
    validadata(Dia,Mes,Ano,Hora,Minutos).


menuestatisticas :- 
    writeln('1 - estafeta mais ecologico'),
    writeln('2 - entrega a determinado cliente'),
    writeln('3 - clientes servidos por um determinado estafeta'),
    writeln('4 - valor faturado num determinado dia'),
    writeln('5 - zonas com maior volume de entregas'),
    writeln('6 - classificacao media de um estafeta'),
    writeln('7 - numero total de entregas pelos diferentes meios de transporte'),
    writeln('8 - numero total de encomendas entregues e nao entregues num determinado intervalo de tempo'),nl,
    writeln('9 - calcular o peso total transportado por estafeta num determiado dia'),
    writeln('10 - voltar atras'),
    write('Choose: '),
    read(X),
    opcaoestatisticas(X). 

opcaoestatisticas(6):- 
    write('Insira o nome do estafeta'),
    read(X).
