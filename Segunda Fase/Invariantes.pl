:- consult('BaseDeConhecimento.pl').

:- op( 900,xfy,'::' ).


%invariante Estrutural , não pode existir transportes com o mesmo id.

+transporte(Id,_,_) ::(
    findall(Id,transporte(Id,_,_),S),
    length(S,N),
    N==1
      ).

%invariante Referencial , não pode existir transportes que nao existem na base de conhecimento .
+transporte(_,Type,_) ::(
    findall(Type,specs_transporte(Type,_,_,_),S),
    length(S,N),
    N==1     
).      

%invariante Estrutural , não pode existir estafetas com o mesmo id.

+estafeta(Id,_,_,_,_) :: (
    findall(Id,estafeta(Id,_,_,_,_),S),
    length(S,X),
    X==1    
).

%invariante Estrutural , não pode existir encomendas com o mesmo id!!!!!!

+encomenda(_,Id,_,_,_,_,_,_,_,_,_) :: (
    findall(Id,encomenda(_,Id,_,_,_,_,_,_,_,_,_),S),
    length(S,N),
    N==1    
).


%invariante Estrutural , não pode existir encomendas com o mesmo id .

+preco(_,_,_,_,_,_,_) :: (
    findall(Preco,preco(Preco,_,_,_,_,_,_),S),
    length(S,N),
    N==1    
).

+circuito(_,Id) :: (
    findall(Id,circuito(_,Id),S),
    length(S,N),
    N==1
).

evolucao(Termo) :- findall(Inv,+Termo::Inv,Lista),
	insercao(Termo),
	teste(Lista).

involucao(Termo) :- findall(I,-Termo::I,Lista),
    teste(Lista),
    remove(Termo).


insercao( Termo ) :-
    assert( Termo ).
insercao( Termo ) :-
    retract( Termo ),!,fail.

remove(Termo) :- retract(Termo).
remove(Termo) :- assert(Termo),!,fail.

teste([]).
teste([H | T]) :- H, teste(T).

