:- consult('BaseDeConhecimento.pl').
%:- consult('BaseDeConhecimento_TesteJorge.pl').

isPar(X):-mod(X,2) =:= 0.
isImpar(X):-mod(X,2) =\= 0.

/****************************************************************
 * Operacoes sobre datas
****************************************************************/
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


visual_data(Timestamp) :-
    stamp_date_time(Timestamp,date(Ano,Mes,Dia,Hora,Minuto,_,_,_,_),0),
    write(Ano),write('/'),write(Mes),write('/'),write(Dia),write(' '),write(Hora),write(':'),write(Minuto).

/****************************************************************
 * Operacoes sobre listas
****************************************************************/
take(N, _, Xs) :- N =< 0, !, N =:= 0, Xs = [].
take(_, [], []).
take(N, [X|Xs], [X|Ys]) :- M is N-1, take(M, Xs, Ys).

%prototipo de imprimir uma lista, ficaria mais facil criar headers indiduais e spamar esta funcao pra tudo
printList([]).
printList([H|T]) :- writeln(H),printList(T).


printEncomendas([]).
printEncomendas([(C,Id,P,F,T,Time)|Tail]) :- write(Id),write(','),write(C),write(','),write(P),
    write(','),write(F),write(','),
    write(T),write(','),
    visual_data(Time),nl,printEncomendas(Tail).

printEstafetas([]).
printEstafetas([(N,Av,T)|Tail]) :- write(N),write(','),divisao(Av,T,Avaliacao),writeln(Avaliacao),printEstafetas(Tail).

printListQ2([]).
printListQ2([(Estafeta,Lista_Ids)|T]) :- 
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

/****************************************************************
 * Operacoes sobre Pares
****************************************************************/
second_pair((_,B),B).
first((H,_),H).

/****************************************************************
 * Operacoes sobre base de Conhecimento
****************************************************************/
insere(Termo) :- assert(Termo).
insere(Termo) :- retract(Termo), !, fail.


remove(Termo) :- retract(Termo).
remove(Termo) :- assert(Termo), !, fail.

%-------------------------Funcao auxiliar para a funcionalidade updateall, adiciona os objetos com a variavel 
%"ocupado" para positivo e soma mais um ao id das encomendas.
%PS MUDAR NOME DE FUNCOES
addNewTrue(transporte(Nt,X),estafeta(Ne,Av,T,X),n_encomendas(Y)) :-
	insere(transporte(Nt,true)),insere(estafeta(Ne,Av,T,true)),soma(Y,1,R),insere(n_encomendas(R)).

addNewFalse(transporte(Nt,true),estafeta(Ne,Av,T,true),encomenda(Cliente,Id,Peso,Volume,Prazo,Preco,Freguesia,Data,Estafeta,Transporte,false),Avaliacao) :-
	insere(transporte(Nt,false)),soma(Av,Avaliacao,RAv),soma(T,1,Total),insere(estafeta(Ne,RAv,Total,false)),
    insere(encomenda(Cliente,Id,Peso,Volume,Prazo,Preco,Freguesia,Data,Estafeta,Transporte,true)).






%Calcula o preco da encomenda tendo em conta a distancia,peso, prazo e meio de transporte.
calculapreco(Distancia,Peso,Volume,Prazo,bicicleta,R) :- 
	preco(PD,PPeso,PVolume,PPrazo,PBicicleta,_,_),
	R is (PD*Distancia + Peso*PPeso + PVolume*Volume + PPrazo/Prazo + PBicicleta).

calculapreco(Distancia,Peso,Volume,Prazo,moto,R) :- 
	preco(PD,PPeso,PVolume,PPrazo,_,PMoto,_),
	R is (PD*Distancia + Peso*PPeso + PVolume*Volume + PPrazo/Prazo + PMoto).

calculapreco(Distancia,Peso,Volume,Prazo,carro,R) :- 
	preco(PD,PPeso,PVolume,PPrazo,_,_,PCarro),
	R is (PD*Distancia + Peso*PPeso + PVolume*Volume + PPrazo/Prazo + PCarro).

%para verificar que existe caminho e ja diz a distancia
adjacente(A,B,Km) :- mapa(A,B,Km).
adjacente(A,B,Km) :- mapa(B,A,Km).



/****************************************************************
 * Operacoes Aritmeticas
****************************************************************/
soma(X,Y,R) :- R is X+Y.

divisao(_,0,0).
divisao(A,B,R) :- R is A/B.

mybetween(X,Y,B) :- B>=X, B=<Y. 

/****************************************************************
 * Headers
****************************************************************/
encomendaHeader :- writeln('Id,Nome,Prazo,Freguesia,estafeta,transporte,Data').
transporteHeader :- writeln('tipo de transporte, Peso maximo, Velocidade,indice de poluicao').
estafetasHeader :- writeln('Nome,Avaliacao').