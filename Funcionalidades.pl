:-consult('BaseDeConhecimento.pl').
:-consult('auxiliar.pl').


%pergunta 6 das estatisticas not sure se é write ou de outra forma
mediaestafeta(estafeta(_,Y,_)) :- write(Y).


%inserir ou remover base de conhecimento
insere(Termo) :- assert(Termo).
insere(Termo) :- retract(Termo), !, fail.


remove(Termo) :- retract(Termo).
remove(Termo) :- assert(Termo), !, fail.


%para verificar que existe caminho e ja diz a distancia
adjacente(A,B,Km) :- mapa(A,B,Km).
adjacente(B,A,Km) :- mapa(B,A,Km).

caminho(A,B,P,Km) :- caminho1(A,[B],P,Km).
caminho1(A,[A|P1],[A|P1],0).
caminho1(A,[Y|P1],P,K1) :- 
  adjacente(X,Y,Ki), 
  \+(member(X,[Y|P1])),
  caminho1(A,[X,Y|P1],P,K), K1 is K + Ki.


%Mostra todos os estafetas, e so copiar isto para os outros...
estafetas(Result) :- findall(A,estafeta(A,_,_),Result).


%Isto so retorna o nome mas nao tenho bem a certeza que e isto que queremos
escolhetransporte(Peso,Distancia,Prazo,R) :- 
  transporte(R,P,Velocidade,_,false), 
  P > Peso, Velocidade > Distancia/Prazo.



