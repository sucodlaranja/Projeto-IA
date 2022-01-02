%esta condicao e pra dizer ao prolog que a encomenda nao e estatica e podemos adicionar
:- dynamic(encomenda/11).
:- dynamic(transporte/3).
:- dynamic(estafeta/5).
:- dynamic(n_encomendas/1).
:- dynamic(preco/7).
:- dynamic(circuito/2).
:- dynamic(specs_transporte/4).
%-------------------------estafetas--------------------------------
%estafeta(Id,nome,avaliacao total, numero de encomendas,ocupado)
estafeta(0,joao,5,1,true).
estafeta(1,jorge,0,0,true).
estafeta(2,ruben,0,0,false).
estafeta(3,neiva,0,0,false).

%-------------------------transporte-------------------------------
%specs_transporte(tipo,peso,velocidade media,índice de poluição)
specs_transporte(bicicleta,5,10,1).
specs_transporte(moto,20,35,2).
specs_transporte(carro,100,25,3).

%transporte(tipo,ocupado)
transporte(0,bicicleta,true).
transporte(1,bicicleta,false).
transporte(2,moto,false).
transporte(3,moto,true).
transporte(4,carro,false).
transporte(5,carro,false).




%-------------------------mapa-------------------------------------
%mapa(origem,destino,distancia(km))
inicio(santa_marta_de_portuzelo).
mapa(cardielos,nogueira,5).
mapa(nogueira,outeiro,10).
mapa(nogueira,vila_de_punhe,5).
mapa(sarreleis,cardielos,2.5).
mapa(santa_marta_de_portuzelo,sarreleis,2.5).
mapa(sarreleis,perre,2.5).
mapa(santa_marta_de_portuzelo,algedes,2.5).
mapa(santa_marta_de_portuzelo,perre,5).
mapa(santa_marta_de_portuzelo,gualtar,1).
mapa(gualtar,silvestre,2).
mapa(silvestre,outeiro,2).
mapa(perre,outeiro,5).
mapa(perre,meadela,5).
mapa(santa_marta_de_portuzelo,meadela,5).
mapa(meadela,darque,10).
mapa(darque,vila_de_punhe,10).
mapa(darque,barroselas,7).
mapa(barroselas,vila_de_punhe,5).

estima(sarreleis,2.5).
estima(gualtar,1).
estima(silvestre,4).
estima(perre,5).
estima(meadela,5).
estima(algedes,5).
estima(cardielos,6).
estima(outeiro,6).
estima(darque,17).
estima(vila_de_punhe,25).
estima(barroselas,22).
estima(nogueira,11).
estima(santa_marta_de_portuzelo,0).
goal(santa_marta_de_portuzelo).

%peso de cada fator na formula que calcula o peso
%preco(distancia(km),peso(Kg),volume(m³),1/prazo,bicicleta,moto,carro)
preco(0.5,0.5,0.5,1,1,2,3).

n_encomendas(3).
%encomenda(cliente,id,peso(kg),volume(m^3),prazo(Horas),preco,freguesia,data(Timestamp s),
%estafeta,transporte,(estado-boolean entregue(true),a entregar(false))).
encomenda(jj,0,2.5,10,2,12,darque,1640887420.1628525,0,0,false).
encomenda(jj,1,2.5,10,2,12,darque,1641128070.1527941,0,0,true).
encomenda(jj,2,2.5,10,2,12,perre,1641085714.0908973,1,3,false).

%circuito([freguesias],idEncomenda)
circuito([santa_marta_de_portuzelo,meadela,darque],0).
circuito([santa_marta_de_portuzelo,perre],1).
