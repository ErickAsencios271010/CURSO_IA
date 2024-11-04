%Hechos
progenitor(pedropablo, cata).
progenitor(pedropablo, berna).
progenitor(pedropablo, leonor).
progenitor(pedropablo, patrocinio).
progenitor(pedropablo, quintin).
progenitor(pedropablo, jesusa).

progenitor(juana, cata).
progenitor(juana, berna).
progenitor(juana, leonor).
progenitor(juana, patrocinio).
progenitor(juana, quintin).
progenitor(juana, jesusa).

progenitor(paulina, emilio).
progenitor(paulina, manuel).
progenitor(paulina, peregrina).
progenitor(paulina, elena).
progenitor(paulina, uve).
progenitor(paulina, bertha).
progenitor(paulina, ernesto).

progenitor(pedrovargas, emilio).
progenitor(pedrovargas, manuel).
progenitor(pedrovargas, peregrina).
progenitor(pedrovargas, elena).
progenitor(pedrovargas, uve).
progenitor(pedrovargas, bertha).
progenitor(pedrovargas, ernesto).

progenitor(emilio, pedro).
progenitor(emilio, emily).

progenitor(jesusa, pedro).
progenitor(jesusa, emily).

progenitor(cesar, kelly).
progenitor(berna, kelly).

progenitor(juan, maria).
progenitor(juan, freddy).
progenitor(juan, patricia).

progenitor(cata, maria).
progenitor(cata, freddy).
progenitor(cata, patricia).

progenitor(cirilo, marisol).
progenitor(cirilo, loy).
progenitor(cirilo, leo).
progenitor(cirilo, rosario).
progenitor(peregrina, marisol).
progenitor(peregrina, loy).
progenitor(peregrina, leo).
progenitor(peregrina, rosario).

progenitor(isabel, gonzalo).
progenitor(isabel, alejandra).
progenitor(loy, gonzalo).
progenitor(loy, alejandra).

progenitor(nemesio, pedropablo).
progenitor(salome, pedropablo).

progenitor(anastacio, juana).
progenitor(valeria, juana).

progenitor(macario, paulina).
progenitor(priscila, paulina).

progenitor(saturnino, pedrovargas).
progenitor(gertrudis, pedrovargas).

progenitor(emilio, jazmin).
progenitor(agustina, jazmin).

progenitor(emilio, sandra).
progenitor(emilio, katty).
progenitor(emilio, john).
progenitor(emilio, fabiola).

progenitor(mirtha, sandra).
progenitor(mirtha, katty).
progenitor(mirtha, john).
progenitor(mirtha, fabiola).

progenitor(emilio, alonso).
progenitor(emilio, guisell).
progenitor(emilio, rodrigo).

progenitor(jenny, alonso).
progenitor(jenny, guisell).
progenitor(jenny, rodrigo).

progenitor(jorge, alex).
progenitor(jorge, rocio).
progenitor(jazmin, alex).
progenitor(jazmin, rocio).

hombre(pedropablo).
hombre(patrocinio).
hombre(quintin).
hombre(pedrovargas).
hombre(emilio).
hombre(manuel).
hombre(ernesto).
hombre(pedro).
hombre(cesar).
hombre(juan).
hombre(feddy).
hombre(cirilo).
hombre(loy).
hombre(gonzalo).
hombre(nemesio).
hombre(anastacio).
hombre(macario).
hombre(saturnino).
hombre(john).
hombre(alonso).
hombre(jorge).
hombre(alex).

mujer(salome).
mujer(valeria).
mujer(priscila).
mujer(gertrudis).
mujer(alejandra).
mujer(isabel).
mujer(leo).
mujer(rosario).
mujer(marisol).
mujer(patricia).
mujer(maria).
mujer(kelly).
mujer(emily).
mujer(cata).
mujer(berna).
mujer(leonor).
mujer(jesusa).
mujer(peregrina).
mujer(elena).
mujer(uve).
mujer(bertha).
mujer(paulina).
mujer(juana).
mujer(agustina).
mujer(mirtha).
mujer(jenny).
mujer(jazmin).
mujer(sandra).
mujer(katty).
mujer(fabiola).
mujer(guisell).
mujer(rocio).

difunto(paulina).
difunto(elena).
difunto(cata).

ahijados(pedro, rodrigo).
ahijados(pedro, alex).
ahijados(manuel, pedro).
ahijados(manuel, emily).
ahijados(cesar, emily).

vecino(pedro, peregrina).
vecino(pedro, cirilo).
vecino(rosario, marisol).
vecino(freddy, patricia).

% Newly added COVID facts

covid_positive(emilio).
covid_positive(loy).

%Reglas

padre(X, Y) :- progenitor(Y, X), hombre(Y).	
madre(X, Y) :- progenitor(Y, X), mujer(Y).

diferente(X, Y) :- not(igual(X, Y)).
igual(X, X).

brothers(X, Y) :- progenitor(Z, X), progenitor(Z, Y), diferente(X, Y).
brothershombre(X, Y) :- brothers(X, Y), hombre(Y).
brothermujer(X, Y) :- brothers(X, Y), mujer(Y).

abuelos(X, Y) :- progenitor(Z, X), progenitor(Y, Z).
abuelosmujer(X, Y) :- abuelos(X, Y), mujer(Y).
abueloshombre(X, Y) :- abuelos(X, Y), hombre(Y).

bisabuelos(X, Y) :- progenitor(Y, Z), abuelos(X, Z).
bisabuelosmujer(X, Y) :- bisabuelos(X, Y), mujer(Y).
bisabueloshombre(X, Y) :- bisabuelos(X, Y), hombre(Y).

tabuelos(X, Y) :- progenitor(Y, Z), bisabuelos(X, Z).
tabuelosmujer(X, Y) :- tabuelos(X, Y), mujer(Y).
tabueloshombre(X, Y) :- tabuelos(X, Y), hombre(Y).

nietos(X, Y) :- progenitor(X, Z), progenitor(Z, Y).
nietosmujer(X, Y) :- nietos(X, Y), mujer(Y).
nietoshombre(X, Y) :- nietos(X, Y), hombre(Y).

bisnietos(X, Y) :- nietos(X, Z), progenitor(Z, Y).
tnietos(X, Y) :- bisnietos(X, Z), progenitor(Z, Y).

pareja(X, Y) :- progenitor(X, Z), progenitor(Y, Z), diferente(X, Y).

parejas(X, Y) :-
    setof(Pareja, pareja(X, Pareja), Y).

cunadospareja(X, Y) :- pareja(X, Z), brothers(Z, Y).
cunadoshermanos(X, Y) :- pareja(Y, Z), brothers(Z, X).
cunados(X, Y) :- cunadospareja(X, Y).
cunados(X, Y) :- cunadoshermanos(X, Y).

tiosdirectos(X, Y) :- progenitor(Z, X), brothers(Z, Y).	
tiospoliticos(X, Y) :- progenitor(Z, X), brothers(Z, W), pareja(W,Y).
tios(X,Y) :- tiosdirectos(X, Y).
tios(X,Y) :- tiospoliticos(X, Y).

primos(X, Y) :- tiosdirectos(X, Z), progenitor(Z, Y).
primoshombre(X, Y) :- primos(X, Y), hombre(Y).
primosmujer(X, Y) :- primos(X, Y), mujer(Y).

sobrinosdirectos(X, Y) :- brothers(X, Z), progenitor(Z, Y).
sobrinospareja(X, Y) :- pareja(X, Z), sobrinosdirectos(Z,Y).
sobrinos(X, Y) :- sobrinosdirectos(X, Y).
sobrinos(X, Y) :- sobrinospareja(X, Y).

ascendencia(Y, X) :- progenitor(X, Y).
ascendencia(Y, X) :- progenitor(Z, Y), ascendencia(Z, X).

descendencia(X, Y) :- progenitor(X, Y).
descendencia(X, Y) :- progenitor(X, Z), descendencia(Z, Y).

suegros(X, Y) :- pareja(X, Z), progenitor(Y,Z).

yernos(X, Y) :- pareja(Y, Z), progenitor(X, Z), hombre(Y).
nueras(X, Y) :- pareja(Y, Z), progenitor(X, Z), mujer(Y).

familiadirecta(X, Y) :- hermanosdirectos(X, Y).
familiadirecta(X, Y) :- progenitor(Y, X).
familiadirecta(X, Y) :- pareja(X, Y).
familiadirecta(X, Y) :- progenitor(X, Y).

hermanosm(X, Y) :- madre(X, Z), progenitor(Z, Y), diferente(X, Y).
hermanosp(X, Y) :- padre(X, Z), progenitor(Z, Y), diferente(X, Y).

en_luto(X, Y) :- familiadirecta(X, Y), difunto(X), not(difunto(Y)).

hermanosmadre(X, Y) :- madre(X, Z), progenitor(Z, Y), diferente(X, Y), not(hermanosp(X,Y)).
hermanospadre(X, Y) :- padre(X, Z), progenitor(Z, Y), diferente(X, Y), not(hermanosm(X,Y)).

hermanosdirectos(X, Y) :- hermanosm(X, Y), hermanosp(X, Y).

hijastros(X, Y) :- pareja(X, Z), progenitor(Z, Y), not(progenitor(X, Y)).

padrino(X, Y) :- ahijados(Y, X).

compadres(X, Y) :- ahijados(X, Z), progenitor(Y, Z).
compadres(X, Y) :- progenitor(X, Z), padrino(Z, Y).

concunados(X, Y) :- cunadospareja(X, Z), pareja(Z, Y).

vecinos(X, Y) :- vecino(X, Y), hombre(Y).
vecinas(X, Y) :- vecino(X, Y), mujer(Y).

vn_y_hd(X, Y) :- hermanosdirectos(X, Y), vecino(X, Y), diferente(X, Y).

pareja_contagiada(X, Y) :-
    covid_positive(X),     
    parejas(X, Y).       

hijos_contagiados(X, Y) :-
    covid_positive(X),    
    progenitor(X, Y).    

hijos_y_parejas(X, Y, Z) :- covid_positive(X),
    findall(Hijo, progenitor(X, Hijo), Y),  
    setof(Pareja, parejas(X, Pareja), Z).


contagio_19m(X, Y, Z, W, Q) :-
    covid_positive(X),                 
    findall(Hijo, progenitor(X, Hijo), Y),
    findall(ParejaHijo, (member(Hijo, Y), parejas(Hijo, ParejaHijo)), Z), 
    findall(Nieto, (member(Hijo, Y), progenitor(Hijo, Nieto)), W),
    findall(ParejaNieto, (member(Nieto, W), parejas(Nieto, ParejaNieto)), Q).


contagio_19c(X, Y) :- covid_positive(X), 
    setof(Pareja, pareja(X, Pareja), ListaParejas),
    findall(Hijo, progenitor(X, Hijo), Hijos),     
    length(ListaParejas, ConteoParejas),       
    length(Hijos, ConteoHijos),           
    Y is ConteoParejas + ConteoHijos.   

descendiente_contagiado(X, X) :- covid_positive(X).

descendiente_contagiado(X, Y) :-
    progenitor(X, Hijo),     
    covid_positive(Hijo),           
    Y = Hijo.          
descendiente_contagiado(X, Y) :-
    progenitor(X, Hijo),                
    descendiente_contagiado(Hijo, Y).


