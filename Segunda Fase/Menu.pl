:- consult('EstruturaGeral.pl').
:- consult('Menuaux.pl').
:- consult('Invariantes.pl').

/****************************************************************
 * Menus
****************************************************************/
menu(X) :-
    writeln('--------------------------------MENU-----------------------------------'),nl,
    writeln('1 - Consultar os estafetas'),
    writeln('2 - Consultar encomendas'),
    writeln('3 - Consultar transporte'),
    writeln('4 - Adicionar estafeta'),
    writeln('5 - Adicionar transporte'),
    writeln('6 - Adicionar encomenda'),
    writeln('7 - Verificar estatisticas encomendas'),
    writeln('8 - Dar entrega da encomenda'),
    writeln('9 - Verificar tabela de precos'),
    writeln('10 - Mudar tabela de precos'),
    writeln('11 - Testar com entrega de varias encomendas'),
    writeln('12 - Exit'),
    choose(X).


menuaddEstafeta :- 
    write('Insira o id do novo estafeta: '),read(Id),
    write('Insira o nome do estafeta: '),read(Nome),
    evolucao(estafeta(Id,Nome,0,0,false)),writeln('estafeta adicionado com sucesso!').

menuaddTransporte :-
    write('Insira o id do novo transporte: '), read(Id),
    write('Insira o tipo de transporte: '), read(Tipo),
    evolucao(transporte(Id,Tipo,false)),writeln('transporte adicionado com sucesso!').
/*
    ================================================================================================
    menu para quando o utilizador faz a encomenda, pergunta os dados da encomenda, estes sao direcionados para o handler
    que vai ser responsavel por avaliar se a encomenda e possivel, atraves do caminho,transportes e estafetas disponiveis,
    calcula tambem preco da encomenda.
    ================================================================================================
*/
menuEncomenda :- 
    write('Insira o seu nome: (em minúsculas)'),read(Nome),
    write('Insira o Peso: '),read(Peso),
    write('Insira o Volume: '),read(Volume),
    write('Insira o Prazo: '),read(Prazo),
    write('Insira o Freguesia: '),read(Freguesia),
    writeln('O que pretende priorizar? '),
    writeln('1 - Velocidade'),writeln('2 - Ecologico'), 
    choose(TipoT),
    repeat,
    writeln('Escolha o tipo de procura para o caminho : '),
    writeln('1 - Pesquisa em profundidade'),
    writeln('2 - Pesquisa em largura'),
    writeln('3 - Pesquisa em profundidade limitada'),
    writeln('4 - melhor caminho'),choose(TipoP),
    fazEncomendaHandler(Nome,Peso,Volume,Prazo,Freguesia,TipoP,TipoT).


menuestatisticas :- 
    writeln('1 - estafeta mais ecologico'),
    writeln('2 - entrega a determinado cliente'),
    writeln('3 - clientes servidos por um determinado estafeta'),
    writeln('4 - valor faturado num determinado dia'),
    writeln('5 - zonas com maior volume de entregas'),
    writeln('6 - classificacao media de um estafeta'),
    writeln('7 - numero total de entregas pelos diferentes meios de transporte'),
    writeln('8 - numero total de entregas pelos estafetas, num determinado intervalo de tempo.'),
    writeln('9 - calcular o número de encomendas entregues e não entregues'),
    writeln('10 - calcular o peso total transportado por estafeta num determiado dia'),
    writeln('11 - calcular circuitos de entrega mais comuns'),
    writeln('12 - voltar atras'),
    choose(X),
    opcaoestatisticas(X). 
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

/* 
    ================================================================
    menu que atualiza a tabela de precos 
    ================================================================
*/
menuMudaPreco :-
    write('Insira o novo preco por km: '),read(PDistancia),
    write('Insira o novo preco por kg: '),read(PPeso),
    write('Insira o novo preco por volume: '),read(PVolume),
    write('Insira o novo preco por prazo: '),read(PPrazo),
    write('Insira o novo preco por bicicleta: '),read(PBicicleta),
    write('Insira o nova preco por moto: '),read(PMoto),
    write('Insira o nova preco por Carro: '),read(PCarro),
    remove(preco(_,_,_,_,_,_,_)),
    evolucao(preco(PDistancia,PPeso,PVolume,PPrazo,PBicicleta,PMoto,PCarro)),
    writeln('Tabela de precos atualizada!'). 

menuVariasEncomendas :-
    writeln('Insira uma lista com os id\'s das encomendas que pretende testar: '),
        read(Lista),
        variasEncomendasHandler(Lista). 