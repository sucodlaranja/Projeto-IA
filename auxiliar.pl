%:- consult('BaseDeConhecimento.pl').
:- consult('BaseDeConhecimento_TesteJorge.pl').

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
printEncomendas([(C,P,F,T,Time)|Tail]) :- write(C),write(','),write(P),
    write(','),write(F),write(','),
    write(T),write(','),
    visual_data(Time),nl,printEncomendas(Tail).

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
	preco(PD,PPeso,PPrazo,PBicicleta,_,_),
	R is (PD*Distancia + Peso*PPeso + PPrazo/Prazo + PBicicleta).

calculapreco(Distancia,Peso,Volume,Prazo,moto,R) :- 
	preco(PD,PPeso,PPrazo,_,PMoto,_),
	R is (PD*Distancia + Peso*PPeso + PPrazo/Prazo + PMoto).

calculapreco(Distancia,Peso,Volume,Prazo,carro,R) :- 
	preco(PD,PPeso,PPrazo,_,_,PCarro),
	R is (PD*Distancia + Peso*PPeso + PPrazo/Prazo + PCarro).

%para verificar que existe caminho e ja diz a distancia
adjacente(A,B,Km) :- mapa(A,B,Km).
adjacente(A,B,Km) :- mapa(B,A,Km).



/****************************************************************
 * Operacoes Aritmeticas
****************************************************************/
soma(X,Y,R) :- R is X+Y.

divisao(_,0,0) :- !.
divisao(0,_,0) :- !.
divisao(A,B,R) :- R is (A/B).

/****************************************************************
 * Headers
****************************************************************/
encomendaHeader :- writeln('Id,Nome,Prazo,Freguesia,estafeta,transporte,Data').