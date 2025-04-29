n := 9;
liste := List([1..10], x -> x);
for i in liste do 
	G := AlternatingGroup(i);
	summe := Sum(Elements(G), g -> Order(g));
	E := summe / Order(G);
	Print(E);

od;