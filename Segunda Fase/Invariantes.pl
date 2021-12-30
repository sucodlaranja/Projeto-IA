:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).
:- op( 900,xfy,'::' ).

evolucao(Termo) :- findall(Inv,+Termo::Inv,Lista),
	insere(Termo),
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