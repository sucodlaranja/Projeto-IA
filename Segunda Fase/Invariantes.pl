:- consult('BaseDeConhecimento_TesteNeiva.pl').

:- op( 900,xfy,'::' ).


%invariante Estrutural , não pode existir transportes com o mesmo id.

+transporte(Id,Y,_) ::(
    findall(Id,transporte(Id,_,_),S),
    length(S,X),
    X==1
      ).

%invariante Referencial , não pode existir transportes que nao existem na base de conhecimento .
+transporte(Id,Y,_) ::(
    findall(Y,specs_transporte(Y,_,_,_),T),
    length(T,H),
    H==1     
).      

%invariante Estrutural , não pode existir estafetas com o mesmo id.

+estafeta(Id,_,_,_) :: (
    findall(Id,estafeta(Id,_,_,_),S),
    length(S,X),
    X==1    
).

%invariante Estrutural , não pode existir encomendas com o mesmo id!!!!!!

+encomenda(Id,_,_,_,_,_,_,_,_,_,_,_) :: (
    findall(Id,encomenda(Id,_,_,_,_,_,_,_,_,_,_,_),S),
    length(S,X),
    X==1    
).


%invariante Estrutural , não pode existir encomendas com o mesmo id .

+preco(Id,_,_,_,_,_,_,_) :: (
    findall(Id,preco(Id,_,_,_,_,_,_,_) ,S),
    length(S,X),
    X==1    
).


evolucao(Termo) :- findall(Inv,+Termo::Inv,Lista),
	insercao(Termo),
	teste(Lista).

involucao(Termos) :- findall(I,-Termos::I,Lista),
    teste(Lista),
    remove(T).


insercao( Termo ) :-
    assert( Termo ).
insercao( Termo ) :-
    retract( Termo ),!,fail.

remove(Termo) :- retract(Termo).
remove(Termo) :- assert(Termo),!,fail.

teste([]).
teste([H | T]) :- H, teste(T).

