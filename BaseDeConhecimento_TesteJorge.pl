%esta condicao e pra dizer ao prolog que a encomenda nao e estatica e podemos adicionar
:- dynamic(encomenda/8).
:- dynamic(transporte/2).
:- dynamic(estafeta/4).
:- dynamic(inicio/1).

%-------------------------estafetas--------------------------------
%estafeta(nome,avaliacao total, numero de ecomendas,ocupado) secalhar meter um id aqui e nos transportes?
estafeta(neiva,20,5,false).
estafeta(jorge,10,1,false).
estafeta(ruben,90,10,false).
estafeta(joao,3,50,false).

%-------------------------transporte-------------------------------
%transporte(tipo,peso maximo, velocidade media,indice de poluicao)

specs_transporte(bicicleta,5,10,1).
specs_transporte(moto,20,35,10).
specs_transporte(carro,100,3,20).

transporte(bicicleta,false).
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

n_encomendas(0).
%encomenda(cliente,id,peso,prazo,freguesia,data,estafeta,transporte,(estado-boolean entregue,a entregar)).
encomenda(jj,0,2.5,2,darque,(2000,2,1,1,1),joao,bicicleta,true).
encomenda(ogs,0,2.5,2,darque,(2000,2,1,1,1),joao,bicicleta,true).
encomenda(jj,0,2.5,2,darque,(2000,2,1,1,1),jorge,bicicleta,true).
encomenda(jj,0,2.5,2,darque,(2000,2,1,1,1),ruben,bicicleta,true).
encomenda(jj,0,2.5,2,vila_de_punhe,(2000,2,1,1,1),joao,carro,true).
encomenda(jj,0,2.5,2,vila_de_punhe,(2000,2,1,1,1),joao,carro,true).
encomenda(rego,0,2.5,2,vila_de_punhe,(2000,2,1,1,1),jorge,moto,true).
encomenda(rego,0,2.5,2,vila_de_punhe,(2000,2,1,1,1),jorge,carro,true).
encomenda(rego,0,2.5,2,vila_de_punhe,(2000,2,1,1,1),ruben,moto,true).