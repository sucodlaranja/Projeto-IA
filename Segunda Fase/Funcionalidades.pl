:-consult('auxiliar.pl').

/* Querie 1
	Identificar o estafeta que utilizou mais vezes um meio de transporte mais ecológico.
	Vamos encontrar o estafeta que tem menor media de indice de poluição por encomenda. 
*/ 
estafeta_mais_ecologico(Mais_ecologico) :- 
	findall(Estafeta,(estafeta(_,Estafeta,_,Num_encomendas,_) , Num_encomendas =\= 0),L_estafeta),
	maplist(quantas_vezes_usou,L_estafeta,L_pares),
	min_member((_,Mais_ecologico),L_pares).

/* função auxiliar a querie 1, que dado um nome de um estafeta 
   calcula o seu indice de poluição por encomenda,
   gera o par (indice de poluição por encomenda,estafeta).*/ 
quantas_vezes_usou(Nome_estafeta,(Pol_media,Nome_estafeta)) :-
	aggregate_all((sum(Ind_poluicao),count),
		(specs_transporte(Meio_transporte,_,_,Ind_poluicao)
			,encomenda(_,_,_,_,_,_,_,_,Nome_estafeta,Meio_transporte,true)),
		(Ind_poluicao_total,Num_encomendas)),
		Pol_media is Ind_poluicao_total/Num_encomendas.

/* Querie 2
	Identificar que estafetas entregaram determinada(s) encomenda(s) a um determinado cliente.
	Vamos procurar os estafetas que fizeram entregas a este cliente 
	e depois encontrar os ids dessas entregas.
*/
estafetas_que_servem(Cliente,Lista) :-
	findall(Estafeta,encomenda(Cliente,_,_,_,_,_,_,_,Estafeta,_,_),Lista_dup),
	sort(Lista_dup,Lista_Est),
	maplist(que_encomendas(Cliente),Lista_Est,Lista).

/* função auxiliar a querie 2, que dado um nome de um estafeta e de um cliente 
   encontra os ids dos pedidos associados aos dois,
   gera o par (Estafeta,[id]).*/ 
que_encomendas(Cliente,Estafeta,(Estafeta,Lista_Ids)) :-
	findall(Ids,encomenda(Cliente,Ids,_,_,_,_,_,_,Estafeta,_,_),Lista_Ids).

/* Querie 3
	Identificar os clientes servidos por um determinado estafeta.
	Fazemos a lista dos clinetes servidos pelo estafeta.
*/
clientes_servidos(Estafeta,Lista) :-
	findall(Cliente,encomenda(Cliente,_,_,_,_,_,_,_,Estafeta,_,_),Lista_wdup),
	sort(Lista_wdup,Lista). 

/* Querie 4
	Calcular o valor faturado pela Green Distribution num determinado dia.
	Somamos os preços de todas as encomendas, acabadas, dentro dos Time_stamps dados.
*/
numero_total_faturado(Time_stamp_inicial,Time_stamp_final,Valor_faturado) :-
	aggregate_all(sum(Preco),
		(encomenda(_,_,_,_,_,Preco,_,Time,_,_,true),
			mybetween(Time_stamp_inicial,Time_stamp_final,Time)),
		Valor_faturado).

/* Querie 5
	Identificar quais as zonas (e.g., rua ou freguesia) com maior volume de entregas por parte da Green Distribution.
	Vamos encontrar as top N zonas mais usadas, encontrando quantas vezes foi usado cada zona.
	Depois ordenamos decrescentemente.
*/
zonas_com_mais_volume(N,Top_n_zones_pair) :-
	findall(Zona,isZona(Zona),Lista_zona_dup),
	sort(Lista_zona_dup,Lista_zona),
	maplist(volume_zona,Lista_zona,Lista_zona_volume),
	sort(1,@>=,Lista_zona_volume,Lista_zona_volume_sorted),
	take(N,Lista_zona_volume_sorted,Top_n_zones_pair).

/* função auxiliar a pergunta 5, que dado um nome de uma zona calcula o numero de vezes que foi usada,
   gera o par (numero de vezes que foi usada,zona).*/ 
volume_zona(Zona,(Volume,Zona)) :-
	aggregate_all(count,encomenda(_,_,_,_,_,_,Zona,_,_,_,_),Volume).

/* Querie 6
	Calcular a classificação média de satisfação de cliente para um determinado estafeta.
*/
mediaestafeta(Estafeta,Media) :- 
	estafeta(_,Estafeta,Total,Numero,_),
	Numero =\= 0,
	Media is Total/ Numero.

/* Querie 7
	Identificar o número total de entregas pelos diferentes meios de transporte,
	num determinado intervalo de tempo.
	Fazemos uma lista com todos os meios de transporte.
	Depois para cada transporte calculamos em quantas encomendas foram utilizados.
*/
entregas_meio_transporte(Time_stamp_inicial,Time_stamp_final,Lista) :- 
	findall(Meio_transporte,transporte(Meio_transporte,_),Lista_mt_dup),
	sort(Lista_mt_dup,Lista_mt),
	maplist(quantas_vezes_usou_transporte(Time_stamp_inicial,Time_stamp_final),Lista_mt,Lista).

/* função auxiliar a querie 7, que dado um nome de um intervalo de tempo e um meio de trasnporte,
   conta as vezes que foi utilizado nesse intervalo,
   gera o par (Vezes usado,Meio transporte).*/ 
quantas_vezes_usou_transporte(Time_stamp_inicial,Time_stamp_final,Meio_transporte,
	(Vezes_usado,Meio_transporte)) :-
	aggregate_all(count,
		(encomenda(_,_,_,_,_,_,_,Time,_,Meio_transporte,true),
			mybetween(Time_stamp_inicial,Time_stamp_final,Time)),
		Vezes_usado).

/* Querie 8
	Identificar o número total de entregas pelos estafetas, num determinado
intervalo de tempo.
*/
numero_total_entregas(Time_stamp_inicial,Time_stamp_final,Numero_total_entregas) :-
	aggregate_all(count,
		(encomenda(_,_,_,_,_,_,_,Time,_,_,true),
			mybetween(Time_stamp_inicial,Time_stamp_final,Time)),
		Numero_total_entregas).

/* Querie 9
	Calcular o número de encomendas entregues e não entregues pela Green
		Distribution, num determinado período de tempo.
	Contamos o número de encomendas não entregues e depois calculamos as entregues com o numero de entregas total.
*/
entregas_comp(Time_stamp_inicial,Time_stamp_final,Comp,Ncomp) :- 
	aggregate_all(count,
		(encomenda(_,_,_,_,_,_,_,Time,_,_,false),
			mybetween(Time_stamp_inicial,Time_stamp_final,Time)),
		Ncomp),
	aggregate_all(count,
		(encomenda(_,_,_,_,_,_,_,Time,_,_,true),
			mybetween(Time_stamp_inicial,Time_stamp_final,Time)),
		Comp).
	
/* Querie 10
	Calcular o peso total transportado por estafeta num determinado dia.
*/
peso_total_entrege(Time_stamp_inicial,Time_stamp_final,Peso_total) :-
	aggregate_all(sum(Peso),
		(encomenda(_,_,Peso,_,_,_,_,Time,_,_,true),mybetween(Time_stamp_inicial,Time_stamp_final,Time)),
		Peso_total).