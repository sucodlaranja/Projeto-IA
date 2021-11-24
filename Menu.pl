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




%output vai ser um conjunto de frases com a seguinte informacao: estafeta,transporte ou false se nao for possivel
%ta tudo feito o que esta escrito, so falta calcular o preco
menuencomenda :- 
    write('Insira o seu nome: '),read(Nome),
    write('Insira o Peso: '),read(Peso),
    write('Insira o Volume: '),read(Volume),
    write('Insira o Prazo: '),read(Prazo),
    write('Insira o Freguesia: '),read(Freguesia),
    fazEncomendaHandler(Nome,Peso,Volume,Prazo,Freguesia).


%mudar a data para timestamp e verifica la,talvez criar um handle para isto.
%criar um handler para o caso da (data+pRAZO NAO SE confirmar)
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
    writeln('8 - numero total de entregas pelos estafetas, num determinado intervalo de tempo.'),
    writeln('9 - calcular o peso total transportado por estafeta num determiado dia'),
    writeln('10 - voltar atras'),
    write('Choose: '),
    read(X),
    opcaoestatisticas(X). 

    

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
    write('Nome do estafeta: '),
    read(Estafeta),
    !,
    clientes_servidos(Estafeta,Lista),
    writeln('Lista dos clientes que foram o estafeta serviu: '),
    printList(Lista).

% Queries 4
opcaoestatisticas(4):- 
    readIntervalosTempo(Time_stamp_inicial,Time_stamp_final),
    numero_total_faturado(Time_stamp_inicial,Time_stamp_final,Valor_faturado),
    write('O valor total faturado neste intervalo de tempo é: '),
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
    write('Nome do estafeta: '),
    read(Estafeta),
    !,
    mediaestafeta(Estafeta,Media),
    write('A média das avaliações do cliente é: '),writeln(Media),writeln('.').

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
    write('O numero total de entregas, no intervalo de tempo, é: '),write(Numero_total_entregas),writeln('kg.').

% Queries 9
opcaoestatisticas(9):- 
    entregas_comp(Comp,Ncomp),
    write('O numero de entregas completas é: '),writeln(Comp),
    write('O numero de entregas ainda por concluir é: '),writeln(Ncomp).

% Queries 10
opcaoestatisticas(10):- 
    readIntervalosTempo(Time_stamp_inicial,Time_stamp_final),
    peso_total_entrege(Time_stamp_inicial,Time_stamp_final,Peso_total),
    write('O peso total, no intervalo de tempo, é: '),write(Peso_total),writeln('kg.').
%opcaoestatisticas(_).
