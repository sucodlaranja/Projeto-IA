:-consult('auxiliar.pl').

/*
===============================================================================================
Dois predicados muito similares, responsaveis por atualizar estados
o True atualiza o estado quando o programa recebe uma nova encomenda
O False atualiza o estado quando o utilizador da entrega de uma encomenda
===============================================================================================
*/
updateallTrue(Transporte,Estafeta,Id) :- 
	remove(Transporte),remove(Estafeta),remove(Id),addNewTrue(Transporte,Estafeta,Id).

updateallFalse(Transporte,Estafeta,Encomenda,Avaliacao) :- 
	remove(Transporte),remove(Estafeta),remove(Encomenda),addNewFalse(Transporte,Estafeta,Encomenda,Avaliacao).


%Calcula se existe caminho do ponto A ate ao B
caminho(A,B,P,Km) :- caminho1(A,[B],P,Km).
caminho1(A,[A|P1],[A|P1],0).
caminho1(A,[Y|P1],P,K1) :- 
  adjacente(X,Y,Ki), 
  \+(member(X,[Y|P1])),
  caminho1(A,[X,Y|P1],P,K), K1 is K + Ki.

%para verificar se o local existe
isZona(A) :- mapa(A,_,_).
isZona(A) :- mapa(_,A,_).

%Mostra todos os estafetas, e so copiar isto para os outros...
estafetas(Result) :- findall((N,Av,T),estafeta(N,Av,T,_),Result).

%Mostra todas as encomendas
encomendas(Result) :- findall((C,Id,P,F,T,Time),(encomenda(C,Id,_,_,P,_,F,Time,_,T,_)),Result).

%Mostra todas os Transportes
transportes(Result) :- findall((Nome,Peso,Velocidade,Indice),(transporte(Nome,_),specs_transporte(Nome,Peso,Velocidade,Indice)),Result).


/*
	====================================================================================================
	Escolhe o transporte dando prioridade aos que têm menos indice de poluicao,
	Calcula se o transporte aguenta o peso da encomenda e consegue chegar ao local no prazo estipulado
	====================================================================================================
*/
escolhetransporte(Peso,Distancia,Prazo,R) :- 
  findall((X,Indice),(transporte(X,false),specs_transporte(X,_,_,Indice)),Y),sort(2,@=<,Y,Transportes),
  escolhetransporte_aux(R,Transportes,Peso,Distancia,Prazo).

escolhetransporte_aux(H,[(H,_)],Peso,Distancia,Prazo) :- 
	specs_transporte(H,P,Velocidade,_),
	P >= Peso, Velocidade >= (Distancia/Prazo),!.
escolhetransporte_aux(Nome,[(Nome,_)|_],Peso,Distancia,Prazo) :- 
	specs_transporte(Nome,P,Velocidade,_),
	P >= Peso, Velocidade >= (Distancia/Prazo),!.
escolhetransporte_aux(Nome,[_|T],Peso,Distancia,Prazo) :- escolhetransporte_aux(Nome,T,Peso,Distancia,Prazo).


%Escolhe o estafeta com base na sua avaliacao
escolheestafeta(R):- findall((X,H),(estafeta(X,A,T,false),divisao(A,T,H)),Y),sort(2,@>=,Y,[H|T]),first(H,R).

/***************************************************************
 * Handlers
***************************************************************/


/*	
	======================================================================================================
	handler do menu entrega encomenda, recebe os dados fornecidos pelo estafeta que entregou a encomenda
	calcula se ha atraso na entrega e atualiza os estados do transporte e do estafeta.
	======================================================================================================
*/
entregaEncomendaHandler(Id,Ano,Mes,Dia,Hora,Minutos,Avaliacao):-
	encomenda(_,Id,_,_,Prazo,_,_,Data,Estafeta,Transporte,False),
	validadata(date(Ano,Mes,Dia,Hora,Minutos,0,0,-,-)),
    date_time_stamp(date(Ano,Mes,Dia,Hora,Minutos,0,0,-,-), TimeStamp), PrazoS is Prazo*3600,
    (Data+PrazoS) >= TimeStamp,
    updateallFalse(transporte(Transporte,true),estafeta(Estafeta,_,_,true),encomenda(_,Id,_,_,Prazo,_,_,Data,Estafeta,Transporte,False),Avaliacao),
	write('A encomenda foi entregue sem atrasos, a avalicao foi: '),writeln(Avaliacao).

entregaEncomendaHandler(Id,Ano,Mes,Dia,Hora,Minutos,Avaliacao):-
	encomenda(_,Id,_,_,Prazo,_,_,Data,Estafeta,Transporte,False),
	validadata(date(Ano,Mes,Dia,Hora,Minutos,0,0,-,-)),
    date_time_stamp(date(Ano,Mes,Dia,Hora,Minutos,0,0,-,-), TimeStamp), PrazoS is Prazo*3600,
    (Data+PrazoS) < TimeStamp,divisao(Avaliacao,2,NewAV),
    updateallFalse(transporte(Transporte,true),estafeta(Estafeta,_,_,true),encomenda(_,Id,_,_,Prazo,_,_,Data,Estafeta,Transporte,False),NewAV),
	write('A encomenda foi entregue com atrasos, a avalicao leva penalizacao de 50%, avalicao é: '),writeln(NewAV).



/* 
	================================================================================================
	Handler que trata da criacao da encomenda e da update dos estados do transporte,estafetas
	Calcula se existe caminho, se existe transporte disponivel por indice de poluicao e calcula o 
	estafeta pela sua avaliacao
	================================================================================================
*/
fazEncomendaHandler(Nome,Peso,Volume,Prazo,Freguesia) :-
	get_time(TimeStamp),
    stamp_date_time(TimeStamp,_, 0),
    caminho(santa_marta_de_portuzelo,Freguesia,_,Distancia),
    escolhetransporte(Peso,Distancia,Prazo,Transporte),
    escolheestafeta(Estafeta),
    n_encomendas(Id),
    calculapreco(Distancia,Peso,Volume,Prazo,Transporte,Preco),
    insere(encomenda(Nome,Id,Peso,Volume,Prazo,Preco,Freguesia,TimeStamp,Estafeta,Transporte,false)),
    updateallTrue(transporte(Transporte,false),estafeta(Estafeta,_,_,false),n_encomendas(Id)),!,
    write('O id da sua encomenda é: '),writeln(Id),
    write('A sua encomenda sera entregue por: '),writeln(Estafeta),
    write('Modo de Transporte: '),writeln(Transporte),
    write('Preco Total: '),writeln(Preco).

fazEncomendaHandler(_,_,_,_,_) :- writeln('Pedimos desculpa mas não é possivel fazer a sua encomenda.').
