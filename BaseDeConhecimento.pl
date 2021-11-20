%esta condicao e pra dizer ao prolog que a encomenda nao e estatica e podemos adicionar
:- dynamic(encomenda/8).
:- dynamic(inicio/1).

%-------------------------estafetas--------------------------------
%estafeta(nome,avaliacao(5-0),ocupado) secalhar meter um id aqui e nos transportes?
estafeta(joao,4,false).
estafeta(jorge,3,false).
estafeta(ruben,2,false).
estafeta(neiva,1,false).




%-------------------------transporte-------------------------------
%transporte(tipo,peso maximo, velocidade media,indice de poluicao,ocupado)
transporte(bicicleta,5,10,1,false).
transporte(bicicleta,5,10,1,false).
transporte(moto,20,35,2,false).
transporte(moto,20,35,2,false).
transporte(carro,100,3,25,false).
transporte(carro,100,3,25,false).



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
mapa(darque,vila_do_punhe,10).


%encomenda(id,peso,prazo,freguesia,data,estafeta,transporte,(estado?-boolean entregue,a entregar?)).
