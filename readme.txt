// Patrascoiu Ion - Radu, 336CC

In implementarea temei am folosit 4 stari: INITIAL, STARE_1, STARE_2, STARE_3.
In prima se identifica inceputul antetului functiilor, se initializeaza
variabilele si se trece in STARE_1, care reprezinta identificarea numelui
functiei si se afiseaza. Apoi, in STARE_2, se identifica parametrii functiei
si se afiseaza. STARE_3, cea mai lunga, reprezinta identificarea variabilelor
locale, le numara si le afiseaza. Nu am stiut de la inceput ca variabilele
locale sunt doar pe o linie, la inceput, astfel ca implemenarea era diferita.
Am considerat majoritatea cazurilor, putand totusi, sa existe mici scapari.
La final, cand se gaseste ";", se afiseaza variabilele locale, se iese din
functie si se ajunge din nou in starea INITIAL, intreg procesul reluandu-se.
Am ignorat comentariile si directivele preprocesor.