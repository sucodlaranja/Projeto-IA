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
mapa(sarreleis,cardielos,2.5).
mapa(santa_marta_de_portuzelo,sarreleis,2.5).
mapa(sarreleis,perre,2.5).
mapa(santa_marta_de_portuzelo,algedes,2.5).
mapa(santa_marta_de_portuzelo,perre,5).
mapa(perre,outeiro,5).
mapa(santa_marta_de_portuzelo,meadela,5).
mapa(meadela,darque,10).
mapa(darque,vila_de_punhe,10).

%peso de cada fator na formula que calcula o peso
%preco(distancia(km),peso(Kg),volume(m³),1/prazo,bicicleta,moto,carro)
preco(0.5,0.5,0.5,1,1,2,3).

n_encomendas(0).
%encomenda(cliente,id,peso(kg),volume(m^3),prazo(Horas),preco,freguesia,data(Timestamp s),
%estafeta,transporte,(estado-boolean entregue,a entregar)).