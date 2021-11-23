%esta condicao e pra dizer ao prolog que a encomenda nao e estatica e podemos adicionar
:- dynamic(encomenda/11).
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
%encomenda(cliente,id,peso(kg),volume(m^3),prazo(Horas),preco,freguesia,data(Timestamp s),estafeta,transporte,(estado-boolean entregue,a entregar)).
encomenda(jj,0,2.5,10,2,12,darque,0,joao,bicicleta,true).
encomenda(ogs,1,2.5,10,2,12,darque,1,joao,bicicleta,true).
encomenda(jj,2,2.5,10,2,12,darque,2,jorge,bicicleta,true).
encomenda(jj,3,2.5,10,2,12,darque,3,ruben,bicicleta,true).
encomenda(jj,4,2.5,10,2,12,vila_de_punhe,2,joao,carro,true).
encomenda(jj,5,2.5,10,2,12,vila_de_punhe,1,joao,carro,true).
encomenda(rego,6,2.5,10,2,12,vila_de_punhe,0,jorge,moto,true).
encomenda(rego,7,2.5,10,2,12,vila_de_punhe,2,jorge,carro,true).
encomenda(rego,8,2.5,10,2,12,vila_de_punhe,3,ruben,moto,true).
encomenda(rego,8,2.5,10,2,12,vila_de_punhe,3,neiva,moto,true).