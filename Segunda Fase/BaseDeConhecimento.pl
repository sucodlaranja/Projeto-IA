%esta condicao e pra dizer ao prolog que a encomenda nao e estatica e podemos adicionar
:- dynamic(encomenda/11).
:- dynamic(transporte/2).
:- dynamic(estafeta/4).
:- dynamic(n_encomendas/1).
:- dynamic(preco/7).

%-------------------------estafetas--------------------------------
%estafeta(nome,avaliacao total, numero de ecomendas,ocupado)
estafeta(joao,0,0,false).
estafeta(jorge,0,0,false).
estafeta(ruben,0,0,false).
estafeta(neiva,0,0,false).

%-------------------------transporte-------------------------------
%specs_transporte(tipo,peso,velocidade media,índice de poluição)
specs_transporte(bicicleta,5,10,1).
specs_transporte(moto,20,35,2).
specs_transporte(carro,100,3,3).

%transporte(tipo,ocupado)
transporte(bicicleta,false).
transporte(bicicleta,false).
transporte(moto,false).
transporte(moto,false).
transporte(carro,false).
transporte(carro,false).



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
mapa(darque,neves,7).
mapa(neves,vila_de_punhe,5).

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
estima(neves,22).
estima(nogueira,11).
estima(santa_marta_de_portuzelo,0).
goal(santa_marta_de_portuzelo).

%peso de cada fator na formula que calcula o peso
%preco(distancia(km),peso(Kg),volume(m³),1/prazo,bicicleta,moto,carro)
preco(0.5,0.5,0.5,1,1,2,3).

n_encomendas(0).
%encomenda(cliente,id,peso(kg),volume(m^3),prazo(Horas),preco,freguesia,data(Timestamp s),
%estafeta,transporte,(estado-boolean entregue,a entregar)).