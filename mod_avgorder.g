ModifiedAvgOrder := function(n)
    local i, G, summe, E1, E2, ergebnisse, file_res;

    ergebnisse := [];

    file_res := OutputTextFile("alt_Sym_results.txt", false); 
    WriteLine(file_res, "GroupName, GroupOrder, E(G)value, E(G)value_decimal");

    for i in [3..n] do
        G := SymmetricGroup(i);
        summe := Sum(Elements(G), g -> Order(g));
        E1 := (summe - 1) / (Order(G) - 1);
        E2 := (summe - 1.0) / (Order(G) - 1.0);  

        Print("n = ", i, " → E(G) = ", E1, E2, "\n");
        WriteLine(file_res, Concatenation("S", String(i), ",", String(Order(G)), ",", String(E1), String(E2)));
        Add(ergebnisse, E1);
        Add(ergebnisse, E2);
        
    od;

    for i in [3..n] do
        G := AlternatingGroup(i);
        summe := Sum(Elements(G), g -> Order(g));
        E1 := (summe - 1) / (Order(G) - 1);
        E2 := (summe - 1.0) / (Order(G) - 1.0);  

        Print("n = ", i, " → E(G) = ", E1, E2, "\n");
        WriteLine(file_res, Concatenation("A", String(i), ",", String(Order(G)), ",", String(E1), String(E2)));
        Add(ergebnisse, E1);
        Add(ergebnisse, E2);
        
    od;    

    CloseStream(file_res);  
    return ergebnisse;
end;
