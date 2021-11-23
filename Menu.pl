:- consult('Funcionalidades.pl').
menu :-
    writeln('--------------------------------MENU-----------------------------------'),nl,
    writeln('1 - consultar os estafetas'),
    writeln('2 - consultar encomendas'),
    writeln('3 - consultar transporte'),
    writeln('4 - adicionar encomenda'),
    writeln('5 - verificar estatisticas encomendas'),
    writeln('6 - finalizar entrega'),
    writeln('7 - Dar entrega da encomenda'),
    writeln('8 - Exit'),
    write('Choose: ').



%output vai ser um conjunto de frases com a seguinte informacao: estafeta,transporte ou false se nao for possivel
%ta tudo feito o que esta escrito, so falta calcular o preco
menuencomenda :- 
    write('Insira o seu nome: '),read(Nome),
    write('Insira o Peso: '),read(Peso),
    write('Insira o Prazo: '),read(Prazo),
    write('Insira o Freguesia: '),read(Freguesia),
    get_time(TimeStamp),
    stamp_date_time(TimeStamp,_, 0),
    caminho(santa_marta_de_portuzelo,Freguesia,_,Distancia),
    escolhetransporte(Peso,Distancia,Prazo,Transporte),
    escolheestafeta(Estafeta),
    n_encomendas(Id),
    insere(encomenda(Nome,Id,Peso,Prazo,Freguesia,TimeStamp,Estafeta,Transporte,false)),
    updateallTrue(transporte(Transporte,false),estafeta(Estafeta,_,_,false),n_encomendas(Id)),
    calculapreco(Distancia,Peso,Prazo,Transporte,Preco),
    write('O id da sua encomenda é: '),writeln(Id),
    write('A sua encomenda sera entregue por: '),writeln(Estafeta),
    write('Modo de Transporte: '),writeln(Transporte),
    write('Preco Total: '),writeln(Preco).


%mudar a data para timestamp e verifica la,talvez criar um handle para isto.
%criar um handler para o caso da (data+pRAZO NAO SE confirmar)
menuEntrega :-
    write('Coloque o Id da encomenda: '),read(Id),
    write('Coloque o ano da entrega: '),read(Ano),
    write('Coloque o mes da entrega: '),read(Mes),
    write('Coloque o dia da entrega: '),read(Dia),
    write('Coloque a hora de entrega: '),read(Hora),
    write('Coloque os minutos da entrega: '),read(Minutos),
    write('Coloque a avaliacao da entrega: '),read(Avaliacao),
    entregaEncomendaHandler(Id,Ano,Mes,Dia,Hora,Minutos,Avaliacao).

menuestatisticas :- 
    writeln('1 - estafeta mais ecologico'),
    writeln('2 - entrega a determinado cliente'),
    writeln('3 - clientes servidos por um determinado estafeta'),
    writeln('4 - valor faturado num determinado dia'),
    writeln('5 - zonas com maior volume de entregas'),
    writeln('6 - classificacao media de um estafeta'),
    writeln('7 - numero total de entregas pelos diferentes meios de transporte'),
    writeln('8 - numero total de encomendas entregues e nao entregues num determinado intervalo de tempo'),nl,
    writeln('9 - calcular o peso total transportado por estafeta num determiado dia'),
    writeln('10 - voltar atras'),
    write('Choose: '),
    read(X),
    opcaoestatisticas(X). 

    



opcaoestatisticas(6):- 
    write('Insira o nome do estafeta'),
    read(X).
