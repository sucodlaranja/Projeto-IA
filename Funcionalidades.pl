:-consult('BaseDeConhecimento.pl').
%:-consult('BaseDeConhecimento_Teste.pl').
:-consult('auxiliar.pl').

/* pergunta 1
	Identificar o estafeta que utilizou mais vezes um meio de transporte mais ecológico.
	Vamos encontrar o estafeta que tem menor media de indice de poluição por encomenda. 
*/ 
estafeta_mais_ecologico(Mais_ecologico) :- 
	findall(Estafeta,(estafeta(Estafeta,_,Num_encomendas,_) , Num_encomendas =\= 0),L_estafeta),
	maplist(quantas_vezes_usou,L_estafeta,L_pares),
	min_member((_,Mais_ecologico),L_pares).

/* função auxiliar a pergunta 1, que dado um nome de um estafeta 
   calcula o seu indice de poluição por encomenda,
   gera o par (indice de poluição por encomenda,estafeta).*/ 
quantas_vezes_usou(Nome_estafeta,(Pol_media,Nome_estafeta)) :-
	aggregate_all((sum(Ind_poluicao),count),
		(specs_transporte(Meio_transporte,_,_,Ind_poluicao),encomenda(_,_,_,_,_,Nome_estafeta,Meio_transporte,true)),
		(Ind_poluicao_total,Num_encomendas)),
		Pol_media is Ind_poluicao_total/Num_encomendas.

/* pergunta 3
	Identificar os clientes servidos por um determinado estafeta.
	Fazemos a lista dos clinetes servidos pelo estafeta e removemos duplicados.
	*/
clientes_servidos(Estafeta,Lista) :-
	findall(Cliente,encomenda(Cliente,_,_,_,_,_,Estafeta,_,_),Lista_wdup),
	sort(Lista_wdup,Lista). 

/* pergunta 5
	Identificar quais as zonas (e.g., rua ou freguesia) com maior volume de
		entregas por parte da Green Distribution.
	Vamos encontrar as top N zonas mais usadas
*/
zonas_com_mais_volume(N,Top_n_zones) :-
	findall(Zona,isZona(Zona),Lista_zona_dup),
	sort(Lista_zona_dup,Lista_zona),
	maplist(volume_zona,Lista_zona,Lista_zona_volume),
	sort(1,@>=,Lista_zona_volume,Lista_zona_volume_sorted),
	take(N,Lista_zona_volume_sorted,Top_n_zones_pair),
	maplist(second_pair,Top_n_zones_pair,Top_n_zones).

/* função auxiliar a pergunta 5, que dado um nome de uma zona calcula o numero de vezes que foi usada,
   gera o par (numero de vezes que foi usada,zona).*/ 
volume_zona(Zona,(Volume,Zona)) :-
	aggregate_all(count,encomenda(_,_,_,_,Zona,_,_,_,_),Volume).

/* pergunta 6
	Calcular a classificação média de satisfação de cliente para um determinado estafeta.
*/
mediaestafeta(Estafeta,Media) :- 
	estafeta(Estafeta,Total,Numero,_),
	Numero =\= 0,
	Media is Total/ Numero.

/* pergunta 7
	identificar o número total de entregas pelos diferentes meios de transporte,
	num determinado intervalo de tempo.
*/
entregas_meio_transporte(Lista) :- 
	findall(Meio_transporte,transporte(Meio_transporte,_),Lista_mt_dup),
	sort(Lista_mt_dup,Lista_mt),
	maplist(quantas_vezes_usou_transporte,Lista_mt,Lista).

quantas_vezes_usou_transporte(Meio_transporte,(Vezes_usado,Meio_transporte)) :-
	aggregate_all(count,encomenda(_,_,_,_,_,_,_,Meio_transporte,true),Vezes_usado).

/* pergunta 8
	Identificar o número total de entregas pelos estafetas, num determinado
intervalo de tempo.
*/
numero_total_entregas(Numero_total_entregas) :-
	aggregate_all(count,encomenda(_,_,_,_,_,_,_,_,true),Numero_total_entregas).

/* pergunta 10
	Calcular o peso total transportado por estafeta num determinado dia.
*/
peso_total_entrege(Peso_total,Time_stamp_inicial,Time_stamp_final) :-
	aggregate_all(sum(Peso),encomenda(_,_,Peso,_,_,_,_,_,true),Peso_total).


%DA UPDATE GERAL A FAZER A ENCOMENDA, DIZER QUE FOI ENTREGUE MUDAR DE NOME QUE TA CONFUSO

updateallTrue(Transporte,Estafeta,Id) :- 
	remove(Transporte),remove(Estafeta),remove(Id),addNewTrue(Transporte,Estafeta,Id).


updateallFalse(Transporte,Estafeta,Encomenda,Avaliacao) :- 
	remove(Transporte),remove(Estafeta),remove(Encomenda),addNewFalse(Transporte,Estafeta,Encomenda,Avaliacao).



%para verificar que existe caminho e ja diz a distancia
adjacente(A,B,Km) :- mapa(A,B,Km).
adjacente(A,B,Km) :- mapa(B,A,Km).

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
estafetas(Result) :- findall(A,estafeta(A,_,_,_),Result).

%Mostra todas as encomendas
encomendas(Result) :- findall((C,P,F,T),encomenda(C,_,P,_,F,_,_,T,_),Result).


%Isto so retorna o nome mas nao tenho bem a certeza que e isto que queremos
escolhetransporte(Peso,Distancia,Prazo,R) :- 
  findall((X,Indice),(transporte(X,false),specs_transporte(X,_,_,Indice)),Y),sort(2,@=<,Y,Transportes),
  escolhetransporte_aux(R,Transportes,Peso,Distancia,Prazo).

escolhetransporte_aux(H,[(H,_)],_,_,_) :- !.
escolhetransporte_aux(Nome,[(Nome,_)|_],Peso,Distancia,Prazo) :- 
	specs_transporte(Nome,P,Velocidade,_),
	P > Peso, Velocidade > (Distancia/Prazo),!.
escolhetransporte_aux(Nome,[_|T],Peso,Distancia,Prazo) :- escolhetransporte_aux(Nome,T,Peso,Distancia,Prazo).

%Isto e so a base, precisa de ter em conta a avaliacao
escolheestafeta(R):- findall((X,H),(estafeta(X,A,T,false),divisao(A,T,H)),Y),sort(2,@>=,Y,R).

