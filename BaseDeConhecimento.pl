%esta condicao e pra dizer ao prolog que a encomenda nao e estatica e podemos adicionar
:- dynamic(encomenda/9).
:- dynamic(transporte/2).
:- dynamic(estafeta/4).
:- dynamic(inicio/1).
:- dynamic(n_encomendas/1).

%-------------------------estafetas--------------------------------
%estafeta(nome,avaliacao total, numero de ecomendas,ocupado) secalhar meter um id aqui e nos transportes?
estafeta(joao,0,0,true).
estafeta(jorge,0,0,false).
estafeta(ruben,0,0,false).
estafeta(neiva,0,0,false).

%-------------------------transporte-------------------------------
%transporte(tipo,peso maximo, velocidade media,indice de poluicao,ocupado)

specs_transporte(bicicleta,5,10,1).
specs_transporte(moto,20,35,2).
specs_transporte(carro,100,3,3).

transporte(bicicleta,true).
transporte(bicicleta,false).
transporte(moto,false).
transporte(moto,false).
transporte(carro,false).
transporte(carro,false).



%-------------------------mapa-------------------------------------
%mapa(origem,destino,distancia(km))
%fim(qualquer cidade)
inicio(santa_marta_de_portuzelo).
mapa(cardielos,nogueira,5).
mapa(sarreleis,cardielos,2.5).
mapa(santa_marta_de_portuzelo,sarreleis,2.5).
mapa(santa_marta_de_portuzelo,perre,5).
mapa(perre,outeiro,5).
mapa(santa_marta_de_portuzelo,meadela,5).
mapa(meadela,darque,10).
mapa(darque,vila_de_punhe,10).

%preco(distancia(km),peso(Kg),1/prazo,bicicleta,moto,carro)
preco(0.5,0.5,1,1,2,3).

n_encomendas(1).
%encomenda(cliente,id,peso,prazo,freguesia,data(timestamp(hora)),estafeta,transporte,(estado-boolean entregue,a entregar)).
encomenda(jj,0,2.5,2,darque,454907.11126391427,joao,bicicleta,false).

