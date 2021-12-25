:-consult('auxiliar.pl').
:-style_check(-singleton).

/*
===============================================================================================
Dois predicados muito similares, responsaveis por atualizar estados
o True atualiza o estado quando o programa recebe uma nova encomenda
O False atualiza o estado quando o utilizador da entrega de uma encomenda
===============================================================================================
*/
updateallTrue(Transporte,Estafeta,Id) :- 
	remove(Transporte),remove(Estafeta),remove(Id),
	addNewTrue(Transporte,Estafeta,Id).

updateallFalse(Transporte,Estafeta,Encomenda,Avaliacao) :- 
	remove(Transporte),remove(Estafeta),remove(Encomenda),
	addNewFalse(Transporte,Estafeta,Encomenda,Avaliacao).

/***************************************************************
 * Algoritmos de Procura não informada
****************************************************************/
%Calcula se existe caminho do ponto A ate ao B 
caminho(A,B,P,Km) :- caminho1(A,[B],P,Km).
caminho1(A,[A|P1],[A|P1],0).
caminho1(A,[Y|P1],P,K1) :- 
  adjacente(X,Y,Ki), 
  \+(member(X,[Y|P1])),
  caminho1(A,[X,Y|P1],P,K), K1 is K + Ki.

%Algoritmo dfs
caminhoDfs(Nodo,[Nodo|Caminho],C,NodoFinal) :- profundidade(Nodo,[Nodo],Caminho,C,NodoFinal).


profundidade(NodoFinal,_,[],0,NodoFinal).

profundidade(Nodo,Historico,[ProxNodo|Caminho],C,NodoFinal) :- 
    adjacente(Nodo,ProxNodo,C1),
    not(member(ProxNodo,Historico)),
    profundidade(ProxNodo,[ProxNodo|Historico],Caminho,C2,NodoFinal), C is C1+C2.


%Busca Iterativa Limitada em Profundidade
caminhoDfslimite(Nodo,[Nodo|Caminho],C,NodoFinal,Limite) :- profundidadelimite(Nodo,[Nodo],Caminho,C,NodoFinal,Limite).


profundidadelimite(NodoFinal,_,[],0,NodoFinal,_).

profundidadelimite(Nodo,Historico,[ProxNodo|Caminho],C,NodoFinal,Limite) :- 
    adjacente(Nodo,ProxNodo,C1),
    not(member(ProxNodo,Historico)), length(Historico,N), Limite >= N,
    profundidadelimite(ProxNodo,[ProxNodo|Historico],Caminho,C2,NodoFinal,Limite), C is C1+C2.



%caminho bfs
caminhoBfs(Dest,Solucao,Distancia) :- caminhoBfsaux(santa_marta_de_portuzelo,Dest,Solucao),calculaDist(Solucao,Distancia).

caminhoBfsaux(Orig, Dest, Cam):- bfs3(Dest,[[Orig]],Cam).

bfs3(Dest,[[Dest|T]|_],Solucao)  :- reverse([Dest|T],Solucao).
bfs3(Dest,[EstadoA|Outros],Solucao) :- 
    EstadoA = [Act|_],
    findall([X|EstadoA],
            (Dest\==Act,
            adjacente(Act,X,_),
            not(member(X,EstadoA))),
            Novos),
    append(Outros,Novos,Todos),
    bfs3(Dest,Todos,Solucao).

calculaDist([],0).
calculaDist([X],0).
calculaDist([H,X2|T],Dist) :- adjacente(H,X2,K1), calculaDist([X2|T],K2),Dist is K1 + K2.


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
	Calcula se o transporte aguenta o peso da encomenda, a velocidade media que perde por determinado 
	peso e se consegue chegar ao local no prazo estipulado
	====================================================================================================
*/
escolhetransporte(Peso,Distancia,Prazo,R) :- 
  findall((X,Indice),(transporte(X,false),specs_transporte(X,_,_,Indice)),Y),sort(2,@=<,Y,Transportes),
  escolhetransporte_aux(R,Transportes,Peso,Distancia,Prazo).

escolhetransporte_aux(H,[(H,_)],Peso,Distancia,Prazo) :- 
	specs_transporte(H,P,Velocidade,_),
	calculaVelocidade(H,P,Velocidade,VelocidadeFinal),
	P >= Peso, VelocidadeFinal >= (Distancia/Prazo),!.
escolhetransporte_aux(Nome,[(Nome,_)|_],Peso,Distancia,Prazo) :- 
	specs_transporte(Nome,P,Velocidade,_),
	calculaVelocidade(H,P,Velocidade,VelocidadeFinal),
	P >= Peso, VelocidadeFinal >= (Distancia/Prazo),!.
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
    date_time_stamp(date(Ano,Mes,Dia,Hora,Minutos,0,0,-,-), TimeStamp), PrazoS is Prazo*3600,Data < TimeStamp,
    (Data+PrazoS) >= TimeStamp,
    updateallFalse(transporte(Transporte,true),estafeta(Estafeta,_,_,true)
    	,encomenda(_,Id,_,_,Prazo,_,_,Data,Estafeta,Transporte,False),Avaliacao),
	write('A encomenda foi entregue sem atrasos, a avalicao foi: '),writeln(Avaliacao).

entregaEncomendaHandler(Id,Ano,Mes,Dia,Hora,Minutos,Avaliacao):-
	encomenda(_,Id,_,_,Prazo,_,_,Data,Estafeta,Transporte,False),
	validadata(date(Ano,Mes,Dia,Hora,Minutos,0,0,-,-)),
    date_time_stamp(date(Ano,Mes,Dia,Hora,Minutos,0,0,-,-), TimeStamp), PrazoS is Prazo*3600,Data < TimeStamp,
    (Data+PrazoS) < TimeStamp,divisao(Avaliacao,2,NewAV),
    updateallFalse(transporte(Transporte,true),estafeta(Estafeta,_,_,true)
    	,encomenda(_,Id,_,_,Prazo,_,_,Data,Estafeta,Transporte,False),NewAV),
	write('A encomenda foi entregue com atrasos, a avalicao leva penalizacao de 50%, avalicao é: '),writeln(NewAV).

entregaEncomendaHandler(Id,Ano,Mes,Dia,Hora,Minutos,_) :-
	encomenda(_,Id,_,_,_,_,_,Data,_,_,False),
	validadata(date(Ano,Mes,Dia,Hora,Minutos,0,0,-,-)),
	date_time_stamp(date(Ano,Mes,Dia,Hora,Minutos,0,0,-,-), TimeStamp),
	Data > TimeStamp, writeln('A data inserida nao e uma data valida.').


/* 
	================================================================================================
	Handler que trata da criacao da encomenda e da update dos estados do transporte,estafetas
	Calcula se existe caminho, se existe transporte disponivel por indice de poluicao e calcula o 
	estafeta pela sua avaliacao
	================================================================================================
*/
fazEncomendaHandler(Nome,Peso,Volume,Prazo,Freguesia) :-
	get_time(TimeStamp),
	inicio(X),
    caminho(X,Freguesia,_,Distancia),
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
