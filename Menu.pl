:- consult('Funcionalidades.pl').
:- consult('queries.pl').

/****************************************************************
 * Menus
****************************************************************/
menu :-
    writeln('--------------------------------MENU-----------------------------------'),nl,
    writeln('1 - consultar os estafetas'),
    writeln('2 - consultar encomendas'),
    writeln('3 - consultar transporte'),
    writeln('4 - adicionar encomenda'),
    writeln('5 - verificar estatisticas encomendas'),
    writeln('6 - Dar entrega da encomenda'),
    writeln('7 - Exit'),
    write('Choose: ').



/*
    ================================================================================================
    menu para quando o utilizador faz a encomenda, pergunta os dados da encomenda, estes sao direcionados para o handler
    que vai ser responsavel por avaliar se a encomenda e possivel, atraves do caminho,transportes e estafetas disponiveis,
    calcula tambem preco da encomenda.
    ================================================================================================
*/
menuEncomenda :- 
    write('Insira o seu nome: '),read(Nome),
    write('Insira o Peso: '),read(Peso),
    write('Insira o Volume: '),read(Volume),
    write('Insira o Prazo: '),read(Prazo),
    write('Insira o Freguesia: '),read(Freguesia),
    fazEncomendaHandler(Nome,Peso,Volume,Prazo,Freguesia).


/*
    ================================================================================================
    menu entrega para quando um utilizador da entrega de uma encomendas
    pede o id da encomenda que vai dar com entregue,os dados de quando entregou
    e a avaliacao este e direcionado para o handler para verificar se existiu atrasos
    e fazer o procedimento correspondente
    ================================================================================================
*/
menuEntrega :-
    write('Coloque o Id da encomenda: '),read(Id),
    write('Coloque o ano da entrega: '),read(Ano),
    write('Coloque o mes da entrega: '),read(Mes),
    write('Coloque o dia da entrega: '),read(Dia),
    write('Coloque a hora de entrega: '),read(Hora),
    write('Coloque os minutos da entrega: '),read(Minutos),
    write('Coloque a avaliacao da entrega: '),read(Avaliacao),
    entregaEncomendaHandler(Id,Ano,Mes,Dia,Hora,Minutos,Avaliacao).

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

    

/****************************************************************
 * Opcoes estatisticas
****************************************************************/

opcaoestatisticas(6):- 
    write('Insira o nome do estafeta'),
    read(X).
