:- consult('Invariantes.pl').

isPar(X):-mod(X,2) =:= 0.
isImpar(X):-mod(X,2) =\= 0.
printTabelaPreco :- preco(Distancia,Peso,Volume,Prazo,Bicicleta,Moto,Carro),
    write('Preco por km: '),writeln(Distancia),
    write('Preco por kg: '),writeln(Peso),
    write('Preco por Volume: '),writeln(Volume),
    write('Preco por Prazo: '),write(Prazo),writeln('/Prazo'),
    write('Taxa Bicicleta: '),writeln(Bicicleta),
    write('Taxa Moto: '),writeln(Moto),
    write('Taxa Carro: '),writeln(Carro).

/****************************************************************
 * Operacoes sobre datas
****************************************************************/
/*
    ================================================================
    verifica se a data da é uma data real
    ================================================================
*/

validadata(date(Y,2,D,H,Min,_,_,_,_)) :- 
    Y mod 4 =\= 0,
    D >=1,D=<29,
    Y > 2000,
    H>= 0, H=<23,
    Min>=1,Min=<59.
validadata(date(Y,2,D,H,Min,_,_,_,_)) :- 
    Y mod 4 =:= 0,
    D >=1,D=<28,
    Y > 2000,
    H>= 0, H=<23,
    Min>=1,Min=<59.


validadata(date(Y,M,D,H,Min,_,_,_,_)) :- 
    isImpar(M),
    D >= 1,D =< 31,
    Y > 2000,
    H>= 0, H=<23,
    Min>=1,Min=<59.
validadata(date(Y,M,D,H,Min,_,_,_,_)) :- 
    isPar(M),
    D >=1,D=<30,
    Y > 2000,
    H>= 0, H=<23,
    Min>=1,Min=<59.

/*
    ========================================================================
    Recebe um timestamp e transforma em algo mais apelativo para ler
    ========================================================================
*/
visual_data(Timestamp) :-
    stamp_date_time(Timestamp,date(Ano,Mes,Dia,Hora,Minuto,_,_,_,_),0),
    write(Ano),write('/'),write(Mes),write('/'),write(Dia),write(' '),write(Hora),write(':'),write(Minuto).

/****************************************************************
 * Operacoes sobre listas
****************************************************************/
take(N, _, Xs) :- N =< 0, !, N =:= 0, Xs = [].
take(_, [], []).
take(N, [X|Xs], [X|Ys]) :- M is N-1, take(M, Xs, Ys).

%Da print de uma lista
printList([]).
printList([H|T]) :- writeln(H),printList(T).

printListQ2([]).
printListQ2([(IdEstafeta,Lista_Ids)|T]) :- 
    estafeta(IdEstafeta,Estafeta,_,_,_),
    write(Estafeta),
    write(' -> Ids das encomendas : '),
    printListQ2aux(Lista_Ids),
    writeln('.'),
    printListQ2(T).

printListQ2aux([]).
printListQ2aux([LastID]) :- write(LastID).
printListQ2aux([ID|Others]) :- 
    write(ID),
    write(', '),
    printListQ2aux(Others).

printListQ5([],_).
printListQ5([(N_encomendas,Zona)|T],N) :-
    write(N),write('ª -> '),
    write(Zona),write(' com '),
    write(N_encomendas),writeln(' encomendas.'),
    Nseg is N + 1,
    printListQ5(T,Nseg).

printListQ7([]).
printListQ7([(Vezes_usado,Meio_transporte)|T]) :-
    write(Meio_transporte),write(' com '),
    write(Vezes_usado),writeln(' encomendas.'),
    printListQ7(T).


%remove a cabeca de uma lista
removeHead([_|T],T).

%devolve a cabeca de uma lista
getHead([H|_],H).

%faz uma lista com o segundo elemento de uma lista de pares
secondPairList([],[]).
secondPairList([(_,R)|T],L) :- secondPairList(T,L1), append([R], L1, L).

%faz uma lista com o primeiro elemento de uma lista de pares
firstPairList([],[]).
firstPairList([(F,_)|T],L) :- firstPairList(T,L1), append([F], L1, L).

%faz uma lista de freguesias
makeFregList([],[]).
makeFregList([Id|T],R) :- 
	encomenda(_,Id,_,_,_,_,Freguesia,_,_,_,_),
	makeFregList(T,R1),R =[Freguesia|R1].

%inverte uma lista
inverso(Xs,Ys):-
	inverso(Xs,[],Ys).

inverso([],Xs,Xs).
inverso([X|Xs],Ys,Zs):-
	inverso(Xs,[X|Ys],Zs).

seleciona(E,[E|Xs],Xs).
seleciona(E,[X|Xs],[X|Ys]) :- seleciona(E,Xs,Ys).

%soma o peso de todas as encomendas com determinado circuito
countPeso((_,Id),[],Peso) :- encomenda(_,Id,Peso,_,_,_,_,_,_,_,_).
countPeso((C,_),[(C,Id)|T],R) :- countPeso((C,_),T,R1),encomenda(_,Id,Peso,_,_,_,_,_,_,_,_), R is Peso + R1.
countPeso((C,_),[_|T],R) :- countPeso((C,_),T,R).

%soma o volume de todas as encomendas com determinado circuito
countVol((_,Id),[],Vol) :- encomenda(_,Id,_,Vol,_,_,_,_,_,_,_).
countVol((C,_),[(C,Id)|T],R) :- countVol((C,_),T,R1),encomenda(_,Id,_,Vol,_,_,_,_,_,_,_), R is Vol + R1.
countVol((C,_),[_|T],R) :- countVol((C,_),T,R).

%apaga todas as ocurrencias de um elemento numa determinada lista
apagat(_,[],[]).
apagat((C,_),[(C,Id)|T],R) :- apagat((C,Id),T,R).
apagat(X,[H|T],R) :- apagat(X,T,R2), append([H],R2,R).


/****************************************************************
 * Operacoes sobre Pares
****************************************************************/
second_pair((_,B),B).
first((H,_),H).


/*
    ==============================================================================
    Atualiza a base de conhecimento no caso de adicionar uma nova encomenda ou 
    quando uma encomenda foi entregue.
    ==============================================================================
*/
addNewEncomenda(transporte(IdT,Nt,X),estafeta(IdE,Ne,Av,T,X),n_encomendas(Y)) :-
	evolucao(transporte(IdT,Nt,true)),evolucao(estafeta(IdE,Ne,Av,T,true)),soma(Y,1,R),evolucao(n_encomendas(R)).

addNewDeliveryDone(estafeta(IdE,Nome,Av,T,true),encomenda(Cliente,Id,Peso,Volume,Prazo,Preco,Freguesia,Data,IdE,IdT,false),Avaliacao,Transporte) :-
	soma(Av,Avaliacao,RAv),soma(T,1,Total),evolucao(estafeta(IdE,Nome,RAv,Total,false)),evolucao(transporte(IdT,Transporte,false)),
    evolucao(encomenda(Cliente,Id,Peso,Volume,Prazo,Preco,Freguesia,Data,IdE,IdT,true)).



/*
    ========================================================================
    calcula o preco de uma encomenda, tendo em conta a sua distancia,
    peso, volume, prazo e modo de transporte.
    ========================================================================
*/
calculapreco(Distancia,Peso,Volume,Prazo,Id,R) :- 
    transporte(Id,bicicleta,_),
	preco(PD,PPeso,PVolume,PPrazo,PBicicleta,_,_),
	R is (PD*Distancia + Peso*PPeso + PVolume*Volume + PPrazo/Prazo + PBicicleta).

calculapreco(Distancia,Peso,Volume,Prazo,Id,R) :-
    transporte(Id,moto,_), 
	preco(PD,PPeso,PVolume,PPrazo,_,PMoto,_),
	R is (PD*Distancia + Peso*PPeso + PVolume*Volume + PPrazo/Prazo + PMoto).

calculapreco(Distancia,Peso,Volume,Prazo,Id,R) :- 
    transporte(Id,carro,_), 
	preco(PD,PPeso,PVolume,PPrazo,_,_,PCarro),
	R is (PD*Distancia + Peso*PPeso + PVolume*Volume + PPrazo/Prazo + PCarro).

%para verificar que existe caminho e ja diz a distancia
adjacente(A,B,Km) :- mapa(A,B,Km).
adjacente(A,B,Km) :- mapa(B,A,Km).

%adjacente para algoritmos de pesquisa informada
adjacente_distancia([Nodo|Caminho]/Custo/_,[ProxNodo,Nodo|Caminho]/NovoCusto/EstDist) :-
	adjacente(Nodo,ProxNodo,PassoCustoDist),
	\+ member(ProxNodo,Caminho),
	NovoCusto is Custo+PassoCustoDist,
	estima(ProxNodo,EstDist).

%calcula a velocidade de determinado transporte tendo em conta a velocidade que perde com o peso
calculaVelocidade(bicicleta,Peso,Velocidade,VelocidadeFinal) :- 
    VelocidadeFinal is Velocidade - (Peso*0.7).
calculaVelocidade(moto,Peso,Velocidade,VelocidadeFinal) :- 
    VelocidadeFinal is Velocidade - (Peso*0.5).
calculaVelocidade(carro,Peso,Velocidade,VelocidadeFinal) :- 
    VelocidadeFinal is Velocidade - (Peso*0.1).

/****************************************************************
 * Operacoes Aritmeticas
****************************************************************/
soma(X,Y,R) :- R is X+Y.

divisao(_,0,0) :- !.
divisao(A,B,R) :- R is A/B.

mybetween(X,Y,B) :- B>=X, B=<Y. 

/****************************************************************
 * Headers
****************************************************************/
encomendaHeader :- writeln('Id,Nome,Prazo,Freguesia,estafeta,transporte,Data,entregue?').
transporteHeader :- writeln('tipo de transporte, Peso maximo, Velocidade,indice de poluicao').
estafetasHeader :- writeln('Id,Nome,Avaliacao').
circuitoHeader :- writeln('Caminho, Id da encomenda').

entregue(false) :- write('não').
entregue(true) :- write('sim').


