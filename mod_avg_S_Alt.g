#we need to define a function to call in gap in terminal, we call the function AvgOrderConjugate,
#in gap we need to tell the function the locals we want to define or call in the beginnig

ModifiedAvgOrderConjugate := function(n)
    local i, G, summe, E1, E2, ergebnisse, file_res;

#print an empty ergebnisse list

    ergebnisse := [];

#produce a file we can analyze with python to plot etc. with n and the values 

    file_res := OutputTextFile("results_conjugacy_sym-alt.txt", false); 
    WriteLine(file_res, "GroupName, GroupOrder, E(G)value, E(G)value_decimal");

#for every S(i) for i <= n we call the symmetric group and build a sum over every order of #conjugacy class times the order of the elements of that class, and than we produce the E(G) value #in normal and decimal
#then we print it to the terminal, to the file and to the ergebnisse list, which we print too

    for i in [3..n] do
        G := SymmetricGroup(i);
        summe := Sum(ConjugacyClasses(G), cl -> Size(cl) * Order(Representative(cl)));
        E1 := (summe - 1) / (Order(G) - 1);
        E2 := (summe - 1.0) / (Order(G) - 1.0);  

        Print("n = ", i, " → E(G) = ", E1, " ", E2, "\n");
        WriteLine(file_res, Concatenation("S", String(i), ",", String(Order(G)), ",", String(E1), ",", String(E2)));
        Add(ergebnisse, E1);
    od;

#we do the same for A(n)

    for i in [3..n] do
        G := AlternatingGroup(i);
        summe := Sum(ConjugacyClasses(G), cl -> Size(cl) * Order(Representative(cl)));
        E1 := (summe - 1) / (Order(G) - 1);
        E2 := (summe - 1.0) / (Order(G) - 1.0);  

        Print("n = ", i, " → E(G) = ", E1, " ", E2, "\n");
        WriteLine(file_res, Concatenation("A", String(i), ",", String(Order(G)), ",", String(E1), ",", String(E2)));
        Add(ergebnisse, E1);
    od;    

#we close the file we produced and print the list of ergebnisse to the terminal

    CloseStream(file_res);  
    return ergebnisse;
end;
