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

updateDelivery(Estafeta,Encomenda,Avaliacao) :- 
	remove(Estafeta),remove(Encomenda),
	addNewDeliveryDone(Estafeta,Encomenda,Avaliacao).

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

bestWayDfs(Nodo,Caminho,Dist,NodoFinal) :- findall((Caminhoaux,Distaux),
	caminhoDfs(Nodo,Caminhoaux,Distaux,NodoFinal),Caminhos), 
	sort(2,@=<,Caminhos,[(Caminho,Dist)|_]). 


%Busca Iterativa Limitada em Profundidade
caminhoDfslimite(Nodo,[Nodo|Caminho],C,NodoFinal,Limite) :- profundidadelimite(Nodo,[Nodo],Caminho,C,NodoFinal,Limite).


profundidadelimite(NodoFinal,_,[],0,NodoFinal,_).

profundidadelimite(Nodo,Historico,[ProxNodo|Caminho],C,NodoFinal,Limite) :- 
    adjacente(Nodo,ProxNodo,C1),
    not(member(ProxNodo,Historico)), length(Historico,N), Limite >= N,
    profundidadelimite(ProxNodo,[ProxNodo|Historico],Caminho,C2,NodoFinal,Limite), C is C1+C2.

bestWayDfslimite(Nodo,Caminho,Dist,NodoFinal,Limite) :- findall((Caminhoaux,Distaux),
	caminhoDfslimite(Nodo,Caminhoaux,Distaux,NodoFinal,Limite),Caminhos), 
	sort(2,@=<,Caminhos,[(Caminho,Dist)|_]). 

%caminho bfs
caminhoBfs(Inicio,Solucao,Distancia,Dest) :- caminhoBfsaux(Inicio,Dest,Solucao),calculaDist(Solucao,Distancia).

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

bestWayBfs(Nodo,Caminho,Dist,NodoFinal) :- findall((Caminhoaux,Distaux),
	caminhoBfs(Nodo,Caminhoaux,Distaux,NodoFinal),Caminhos), 
	sort(2,@=<,Caminhos,[(Caminho,Dist)|_]). 

/***************************************************************
 * Algoritmos de Procura informada
****************************************************************/

%Algoritmo A estrela
resolve_aestrela(Nodo,CaminhoDistancia/CustoDist) :-
	estima(Nodo,EstimaD),
	aestrela_distancia([[Nodo]/0/EstimaD],InvCaminho/CustoDist/_),
	inverso(InvCaminho,CaminhoDistancia).

aestrela_distancia(Caminhos,Caminho) :-
	obtem_melhor_distancia(Caminhos,Caminho),
	Caminho = [Nodo|_]/_/_,goal(Nodo).

aestrela_distancia(Caminhos,SolucaoCaminho) :-
	obtem_melhor_distancia(Caminhos,MelhorCaminho),
	seleciona(MelhorCaminho,Caminhos,OutrosCaminhos),
	expande_aestrela_distancia(MelhorCaminho,ExpCaminhos),
	append(OutrosCaminhos,ExpCaminhos,NovoCaminhos),
        aestrela_distancia(NovoCaminhos,SolucaoCaminho).	

obtem_melhor_distancia([Caminho],Caminho) :- !.
obtem_melhor_distancia([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos],MelhorCaminho) :-
	Custo1 + Est1 =< Custo2 + Est2,!,
	obtem_melhor_distancia([Caminho1/Custo1/Est1|Caminhos],MelhorCaminho). 
obtem_melhor_distancia([_|Caminhos],MelhorCaminho) :- 
	obtem_melhor_distancia(Caminhos,MelhorCaminho).
	

expande_aestrela_distancia(Caminho,ExpCaminhos) :-
	findall(NovoCaminho,adjacente_distancia(Caminho,NovoCaminho),ExpCaminhos).


%Pesquisa Gulosa
resolve_gulosa(Nodo,CaminhoDistancia/CustoDist) :-
	estima(Nodo,EstimaD),
	agulosa_distancia_g([[Nodo]/0/EstimaD],InvCaminho/CustoDist/_),
	inverso(InvCaminho,CaminhoDistancia).

agulosa_distancia_g(Caminhos,Caminho) :-
	obtem_melhor_distancia_g(Caminhos,Caminho),
	Caminho = [Nodo|_]/_/_,
	goal(Nodo).

agulosa_distancia_g(Caminhos,SolucaoCaminho) :-
	obtem_melhor_distancia_g(Caminhos,MelhorCaminho),
	seleciona(MelhorCaminho,Caminhos,OutrosCaminhos),
	expande_agulosa_distancia_g(MelhorCaminho,ExpCaminhos),
	append(OutrosCaminhos,ExpCaminhos,NovoCaminhos),
        agulosa_distancia_g(NovoCaminhos,SolucaoCaminho).	

obtem_melhor_distancia_g([Caminho],Caminho) :- !.
obtem_melhor_distancia_g([Caminho1/Custo1/Est1,_/_/Est2|Caminhos],MelhorCaminho) :-
	Est1 =< Est2,!,
	obtem_melhor_distancia_g([Caminho1/Custo1/Est1|Caminhos],MelhorCaminho). 
obtem_melhor_distancia_g([_|Caminhos],MelhorCaminho) :- 
	obtem_melhor_distancia_g(Caminhos,MelhorCaminho).

expande_agulosa_distancia_g(Caminho,ExpCaminhos) :-
	findall(NovoCaminho,adjacente_distancia(Caminho,NovoCaminho),ExpCaminhos).

%algoritmo para varias encomendas
caminhoNEncomendas(L,Caminho,Dist) :- inicio(Nodo),findBestOrder(L,Listaux),firstPairList(Listaux,Listaux2),
	caminhoNEncomendasaux(Listaux2,[],Caminhoaux,Distaux),getHead(Caminhoaux,Head),
	bestWayDfs(Nodo,Caminho1,Dist1,Head),removeHead(Caminhoaux,Caminhoaux2),
	append(Caminho1,Caminhoaux2,Caminho),Dist is Dist1 + Distaux.

/*
	================================================================================================
	Dado uma lista com zonas,calcula o melhor caminho do centro de distribuicao 
	até cada uma das zonas, cria uma lista com a distancia a cada zona e ordena pela menor distancia.
	================================================================================================
*/
findBestOrder([],[]).
findBestOrder([H|T],List) :- inicio(Nodo), bestWayDfs(Nodo,_,Dist1,H),
	findBestOrder(T,Listaux),append([(H,Dist1)], Listaux, Listaux2),
	sort(2,@=<,Listaux2,List).
	
/*
	================================================================================================
	Dado uma lista com zonas,calcula um caminho que passe por todas estas zonas.
	Verifica se a nova zona ja pertence ao caminho se não, calcula um caminho do 
	ultima zona do caminho ja calculado até ao novo. Calcula também a distancia do caminho.
	================================================================================================
*/
caminhoNEncomendasaux([X],_,[],0).
caminhoNEncomendasaux([H,H2|T],Historico,Caminho1,Dist) :- not(member(H2,Historico)),
    caminhoDfs(H,ProxCam,Dist1,H2),not(member(H2,Historico)),
	((length(Historico,N) , N > 0) -> removeHead(ProxCam,ProxCam1) ; ProxCam1 = ProxCam),
	append(ProxCam1,Historico,HistoricoAux),append(ProxCam1,Caminho,Caminho1),
	caminhoNEncomendasaux([H2|T],HistoricoAux,Caminho,Dist2), 
	Dist is Dist1 + Dist2.

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
	peso e se consegue chegar ao local no prazo estipulado.
	====================================================================================================
*/
escolhetransporteEc(Peso,Distancia,Prazo,R) :- 
  findall((X,Indice),(transporte(X,false),specs_transporte(X,_,_,Indice)),Y),sort(2,@=<,Y,Transportes),
  escolhetransporte_aux(R,Transportes,Peso,Distancia,Prazo).

/*
	====================================================================================================
	Escolhe o transporte dando prioridade aos mais rapido,
	Calcula se o transporte aguenta o peso da encomenda, a velocidade media que perde por determinado 
	peso e se consegue chegar ao local no prazo estipulado.
	====================================================================================================
*/
escolhetransporteVel(Peso,Distancia,Prazo,R) :-
	findall((X,VelocidadeFinal),(transporte(X,false),specs_transporte(X,_,Velocidade,_),
	calculaVelocidade(X,Peso,Velocidade,VelocidadeFinal)),Y),
	sort(2,@>=,Y,Transportes),
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
    updateDelivery(estafeta(Estafeta,_,_,true),encomenda(_,Id,_,_,Prazo,_,Freguesia,Data,Estafeta,Transporte,False),Avaliacao),
	write('A encomenda foi entregue sem atrasos, a avalicao foi: '),writeln(Avaliacao),
	writeln('Escolha o tipo de procura para o caminho de volta para o centro de entregas: '),
	writeln('1 - Pesquisa em profundidade'),
    writeln('2 - Pesquisa em largura'),
    writeln('3 - Pesquisa em profundidade limitada'),
    writeln('4 - melhor caminho'),
	writeln('5 - a estrela'),
	writeln('6 - Gulosa'),repeat,choose(TipoP),escolheCaminhovolta(TipoP,Freguesia,CaminhoVolta,DistVolt),writeCaminho(CaminhoVolta,DistVolt).

entregaEncomendaHandler(Id,Ano,Mes,Dia,Hora,Minutos,Avaliacao):-
	encomenda(_,Id,_,_,Prazo,_,_,Data,Estafeta,Transporte,False),
	validadata(date(Ano,Mes,Dia,Hora,Minutos,0,0,-,-)),
    date_time_stamp(date(Ano,Mes,Dia,Hora,Minutos,0,0,-,-), TimeStamp), PrazoS is Prazo*3600,Data < TimeStamp,
    (Data+PrazoS) < TimeStamp,divisao(Avaliacao,2,NewAV),
	updateDelivery(estafeta(Estafeta,_,_,true),encomenda(_,Id,_,_,Prazo,_,Freguesia,Data,Estafeta,Transporte,False),NewAV),
	write('A encomenda foi entregue com atrasos, a avalicao leva penalizacao de 50%, avalicao é: '),writeln(NewAV),
	writeln('Escolha o tipo de procura para o caminho de volta para o centro de entregas: '),
	writeln('1 - Pesquisa em profundidade'),
    writeln('2 - Pesquisa em largura'),
    writeln('3 - Melhor caminho'),
	writeln('4 - Pesquisa em profundidade limitada'),
	writeln('5 - A estrela'),
	writeln('6 - Gulosa'),repeat,choose(TipoP),escolheCaminhovolta(TipoP,Freguesia,CaminhoVolta,DistVolt),writeCaminho(CaminhoVolta,DistVolt).

entregaEncomendaHandler(Id,Ano,Mes,Dia,Hora,Minutos,_) :-
	encomenda(_,Id,_,_,_,_,_,Data,_,_,False),
	validadata(date(Ano,Mes,Dia,Hora,Minutos,0,0,-,-)),
	date_time_stamp(date(Ano,Mes,Dia,Hora,Minutos,0,0,-,-), TimeStamp),
	Data > TimeStamp, writeln('A data inserida nao e uma data valida.').

escolheCaminhovolta(1,Freguesia,Caminho,Distancia) :- 	!,inicio(Nodo), caminhoDfs(Freguesia,Caminho,Distancia,Nodo).
escolheCaminhovolta(2,Freguesia,Caminho,Distancia) :- 	!,inicio(Nodo), caminhoBfs(Freguesia,Caminho,Distancia,Nodo).
escolheCaminhovolta(3,Freguesia,Caminho,Distancia) :- 	!,inicio(Nodo), bestWayDfs(Freguesia,Caminho,Distancia,Nodo).
escolheCaminhovolta(4,Freguesia,Caminho,Distancia) :-   !,inicio(Nodo),write('Insira o limite'),read(Limite),
	(caminhoDfslimite(Freguesia,Caminho,Distancia,Nodo,Limite) -> true ; fail).
escolheCaminhovolta(5,Freguesia,Caminho,Distancia) :-  	!,resolve_gulosa(Freguesia,Caminho/Distancia).
escolheCaminhovolta(6,Freguesia,Caminho,Distancia) :-  	!,resolve_gulosa(Freguesia,Caminho/Distancia).
escolheCaminho(_,_,_,_) :- invalida,fail.


/* 
	================================================================================================
	Handler que trata da criacao da encomenda e da update dos estados do transporte,estafetas
	Calcula se existe caminho, se existe transporte disponivel por indice de poluicao e calcula o 
	estafeta pela sua avaliacao
	================================================================================================
*/
fazEncomendaHandler(Nome,Peso,Volume,Prazo,Freguesia,TipoP,TipoT) :-
	get_time(TimeStamp),
	inicio(X),
    escolheCaminho(TipoP,X,Freguesia,Caminho,Distancia),
    escolhetransporte(TipoT,Peso,Distancia,Prazo,Transporte),
    escolheestafeta(Estafeta),
    n_encomendas(Id),
    calculapreco(Distancia,Peso,Volume,Prazo,Transporte,Preco),!,
	writeCaminho(Caminho,Distancia),
    write('O id da sua encomenda é: '),writeln(Id),
    write('A sua encomenda sera entregue por: '),writeln(Estafeta),
    write('Modo de Transporte: '),writeln(Transporte),
    write('Preco Total: '),writeln(Preco),nl,
	write('Pretende guardar esta informacão na base de conhecimento? '), read(Resposta),
	(Resposta = 'y' ->
	(insere(encomenda(Nome,Id,Peso,Volume,Prazo,Preco,Freguesia,TimeStamp,Estafeta,Transporte,false)),
    updateallTrue(transporte(Transporte,false),estafeta(Estafeta,_,_,false),n_encomendas(Id))); true).

fazEncomendaHandler(_,_,_,_,_) :- writeln('Pedimos desculpa mas não é possivel fazer a sua encomenda.').

escolheCaminho(1,Nodo,Freguesia,Caminho,Distancia) :- !,caminhoDfs(Nodo,Caminho,Distancia,Freguesia).
escolheCaminho(2,Nodo,Freguesia,Caminho,Distancia) :- !,caminhoBfs(Nodo,Caminho,Distancia,Freguesia).
escolheCaminho(4,Nodo,Freguesia,Caminho,Distancia) :- !,bestWayDfs(Nodo,Caminho,Distancia,Freguesia).
escolheCaminho(3,Nodo,Freguesia,Caminho,Distancia) :- !,write('Insira o limite de profundidade'),
	read(Limite), caminhoDfslimite(Nodo,Caminho,Distancia,Limite,Freguesia).
escolheCaminho(_,_,_,_,_) :- invalida,fail.

escolhetransporte(1,Peso,Distancia,Prazo,Transporte) :- escolhetransporteVel(Peso,Distancia,Prazo,Transporte).
escolhetransporte(2,Peso,Distancia,Prazo,Transporte) :- escolhetransporteEc(Peso,Distancia,Prazo,Transporte).


