AvgOrder := function(n)
    local i, G, summe, E, ergebnisse, file_res;

    ergebnisse := [];

    file_res := OutputTextFile("alt_Sym_D_results.txt", false); 
    WriteLine(file_res, "GroupName,GroupOrder,E(G)value");

    for i in [3..n] do
        G := SymmetricGroup(i);
        summe := Sum(Elements(G), g -> Order(g));
        E := (summe - 1) / (Order(G) - 1);
        
        Print("n = ", i, " → E(G) = ", E, "\n");
        WriteLine(file_res, Concatenation("S", String(i), ",", String(Order(G)), ",", String(E)));
        Add(ergebnisse, E);
    od;

    for i in [3..n] do
        G := AlternatingGroup(i);
        summe := Sum(Elements(G), g -> Order(g));
        E := (summe - 1) / (Order(G) - 1);
        
        Print("n = ", i, " → E(G) = ", E, "\n");
        WriteLine(file_res, Concatenation("A", String(i), ",", String(Order(G)), ",", String(E)));
        Add(ergebnisse, E);
    od;    

    CloseStream(file_res);  
    return ergebnisse;
end;
