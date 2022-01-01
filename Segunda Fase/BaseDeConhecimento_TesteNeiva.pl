:- dynamic transporte/3.
:- dynamic estafeta/4.
:- dynamic encomenda/12.
:- dynamic preco/8.


%transporte(id,tipo,ocupado)
transporte(1,bicicleta,false).
transporte(2,bicicleta,false).
transporte(3,moto,false).
transporte(4,moto,false).
transporte(5,carro,false).
transporte(6,carro,false).



%-------------------------transporte------------------------------- verificar se existe specs quando adicionamos transporte
%specs_transporte(tipo,peso,velocidade media,índice de poluição)
specs_transporte(bicicleta,5,10,1).
specs_transporte(moto,20,35,2).
specs_transporte(carro,100,25,3).

%estafeta(id,nome,avaliacao total, numero de encomendas,ocupado)
estafeta(1,joao,0,0,true).
estafeta(2,jorge,0,0,false).
estafeta(3,ruben,0,0,false).
estafeta(4,neiva,0,0,false).


%so pode haver um id
encomenda(1,jj,0,2.5,10,2,12,darque,1640887420.1628525,joao,bicicleta,false).
encomenda(2,jj,1,2.5,10,2,12,perre,1640887420.1628525,joao,bicicleta,false).
%so pode haver um preço
preco(1,0.5,0.5,0.5,1,1,2,3).