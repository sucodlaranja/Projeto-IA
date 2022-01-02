:- consult('Funcionalidades.pl').



menuEscolheCaminho(TipoP) :- 
    writeln('Escolha o tipo de procura para o caminho de volta para o centro de entregas: '),
	writeln('1 - Pesquisa em profundidade'),
    writeln('2 - Pesquisa em largura'),
    writeln('3 - Melhor caminho'),
	writeln('4 - Pesquisa em profundidade limitada'),
	writeln('5 - A estrela'),
	writeln('6 - Gulosa'),choose(TipoP).

menuEscolheCaminhoVolta(TipoP) :-
	writeln('Escolha o tipo de procura para o caminho de volta para o centro de entregas: '),
	writeln('1 - Pesquisa em profundidade'),
    writeln('2 - Pesquisa em largura'),
    writeln('3 - Pesquisa em profundidade limitada'),
    writeln('4 - melhor caminho'),
	writeln('5 - a estrela'),
	writeln('6 - Gulosa'),choose(TipoP).

choose(X) :- write('Escolha uma opção: '),read(X).
invalida :- writeln('Opção Invalida!').
continue :- nl,writeln('escreva ok para continuar'),read(_).
writeCaminho(Caminho,Dist) :- 
    write('O percurso será: '),writeln(Caminho),write('Distancia calculada(Km): '),writeln(Dist).



/****************************************************************
 * Opcoes estatisticas
****************************************************************/

readIntervalosTempo(Time_stamp_inicial,Time_stamp_final) :-
    write('Coloque o ano da 1ª data: '),read(Ano1),
    write('Coloque o mes da 1ª entrega: '),read(Mes1),
    write('Coloque o dia da 1ª entrega: '),read(Dia1),
    write('Coloque o ano da 2ª data: '),read(Ano2),
    write('Coloque o mes da 2ª entrega: '),read(Mes2),
    write('Coloque o dia da 2ª entrega: '),read(Dia2),
    !,
    date_time_stamp(date(Ano1,Mes1,Dia1,0,0,0,0,-,-), Time_stamp_inicial),
    date_time_stamp(date(Ano2,Mes2,Dia2,23,59,59,59,-,-), Time_stamp_final),
    Time_stamp_inicial =< Time_stamp_final.

readDia(Time_stamp_inicial,Time_stamp_final) :-
    write('Coloque o ano '),read(Ano),
    write('Coloque o mes'),read(Mes),
    write('Coloque o dia'),read(Dia),
    !,
    date_time_stamp(date(Ano,Mes,Dia,0,0,0,0,-,-), Time_stamp_inicial),
    date_time_stamp(date(Ano,Mes,Dia,23,59,59,59,-,-), Time_stamp_final).

% Queries 1
opcaoestatisticas(1):- 
    !,
    estafeta_mais_ecologico(Mais_ecologico),
    write('O estafeta mais ecologico é o/a '),
    write(Mais_ecologico),
    writeln('.').

% Queries 2
opcaoestatisticas(2):- 
    write('Nome do cliente: '),
    read(Cliente),
    !,
    estafetas_que_servem(Cliente,Lista),
    writeln('Lista dos estafetas que serviram o cliente: '),
    writeln('Nome do estafeta -> Ids das encomendas'),
    printListQ2(Lista).

% Queries 3
opcaoestatisticas(3):- 
    write('Id do estafeta: '),
    read(Estafeta),
    !,
    clientes_servidos(Estafeta,Lista),
    writeln('Lista dos clientes que foram o estafeta serviu: '),
    printList(Lista).

% Queries 4
opcaoestatisticas(4):- 
    readDia(Time_stamp_inicial,Time_stamp_final),
    numero_total_faturado(Time_stamp_inicial,Time_stamp_final,Valor_faturado),
    write('O valor total faturado neste dia é: '),
    write(Valor_faturado),
    writeln('$.').

% Queries 5
opcaoestatisticas(5):- 
    write('Numero de Zonas :'),
    read(N_zonas),
    !,
    zonas_com_mais_volume(N_zonas,Top_n_zones),
    write('As top '),write(N_zonas),writeln(' mais usadas são:'),
    printListQ5(Top_n_zones,1).

% Queries 6
opcaoestatisticas(6):- 
    write('id do estafeta: '),
    read(Estafeta),
    !,
    mediaestafeta(Estafeta,Media),
    write('A média das avaliações dos clientes é: '),write(Media),writeln('.').

% Queries 7
opcaoestatisticas(7):- 
    readIntervalosTempo(Time_stamp_inicial,Time_stamp_final),
    entregas_meio_transporte(Time_stamp_inicial,Time_stamp_final,Lista),
    writeln('Ranking -> Transporte -> Numero de encomendas'),
    printListQ7(Lista).

% Queries 8
opcaoestatisticas(8):- 
    readIntervalosTempo(Time_stamp_inicial,Time_stamp_final),
    numero_total_entregas(Time_stamp_inicial,Time_stamp_final,Numero_total_entregas),
    write('O numero total de entregas, no intervalo de tempo, é: '),write(Numero_total_entregas).

% Queries 9
opcaoestatisticas(9):-
    readIntervalosTempo(Time_stamp_inicial,Time_stamp_final), 
    entregas_comp(Time_stamp_inicial,Time_stamp_final,Comp,Ncomp),
    write('O numero de entregas completas é: '),writeln(Comp),
    write('O numero de entregas ainda por concluir é: '),writeln(Ncomp).

% Queries 10
opcaoestatisticas(10) :- 
    readDia(Time_stamp_inicial,Time_stamp_final),
    peso_total_entrege(Time_stamp_inicial,Time_stamp_final,Peso_total),
    write('O peso total neste dia foi: '),write(Peso_total),writeln('kg.').

% Querie 11
opcaoestatisticas(11) :- repeat,
    writeln('1 - Por Peso'),
    writeln('2 - Por Volume'),read(Resposta),escolheopcao11(Resposta).

%auxiliar da opcao 11
escolheopcao11(1) :- !,circuitoMaisComunsPeso(R),printList(R).
escolheopcao11(2) :- !,circuitoMaisComunsVol(R),printList(R).
escolheopcao11(_) :- invalida,fail.

%Imprime uma lista de encomendas
printEncomendas([]).
printEncomendas([(C,Id,Prazo,Freguesia,IdEstafeta,IdTransporte,Time,Entregue)|Tail]) :- write(Id),write(', '),
    write(C),write(', '),write(Prazo),write(', '),
    write(Freguesia),write(', '),estafeta(IdEstafeta,Nome,_,_,_),write(Nome),write(', '),
    transporte(IdTransporte,Transporte,_),write(Transporte),write(', '),
    visual_data(Time),write(', '),entregue(Entregue),nl,printEncomendas(Tail).

%Imprime informacoes de uma determinada encomenda
printEncomenda(Id,IdEstafeta,IdTransporte,Preco) :-
    write('O id da sua encomenda é: '),writeln(Id),
    write('A sua encomenda sera entregue por: '),estafeta(IdEstafeta,Nome,_,_,_),writeln(Nome),
    write('Modo de Transporte: '),transporte(IdTransporte,Transporte,_),writeln(Transporte),
    write('Preco Total: '),write(Preco),writeln('$'),nl.

%Imprime informacoes sobre os estafetas
printEstafetas([]).
printEstafetas([(Id,N,Av,T)|Tail]) :- write(Id),write(', '), write(N),write(', '),divisao(Av,T,Avaliacao),writeln(Avaliacao),printEstafetas(Tail).