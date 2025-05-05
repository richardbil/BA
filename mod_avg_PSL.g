#we need to define a function to call in gap in terminal, we call the function ModifiedAvgOrderConjugate,
#in gap we need to tell the function the locals we want to define or call in the beginnig

ModavgPSL := function(n, q)
    local i, G, summe, E1, E2, ergebnisse, file_res, p;

#print an empty ergebnisse list

    ergebnisse := [];

#produce a file we can analyze with python to plot etc. with n and the values 

    file_res := OutputTextFile("psl_conjugacy_results.txt", false); 
    WriteLine(file_res, "GroupName, GroupOrder, E(G)value, E(G)value_decimal");

#for every i <= n we build PSL(2, q^i) and build a sum over every order of conjugacy class times the order of the elements of that class, 
#and than we produce the E(G) value in normal and decimal
#then we print it to the terminal, to the file and to the ergebnisse list, which we print too

    for i in [1..n] do
        G := ProjectiveSpecialLinearGroup(2, q^i);
        summe := Sum(ConjugacyClasses(G), cl -> Size(cl) * Order(Representative(cl)));
        E1 := (summe - 1) / (Order(G) - 1);
        E2 := (summe - 1.0) / (Order(G) - 1.0);  

        Print("q^n = ", q^i, " → E(G) = ", E1, " ", E2, "\n");
        WriteLine(file_res, Concatenation("PSL2_", String(q^i), ",", String(Order(G)), ",", String(E1), ",", String(E2)));
        Add(ergebnisse, E1);
    od;

#we now do the same for PSL(2, p) where p runs over the first n primes

    for i in [1..n] do
        p := NextPrimeInt(i + 1);  # simple way to get a sequence of increasing primes
        G := ProjectiveSpecialLinearGroup(2, p);
        summe := Sum(ConjugacyClasses(G), cl -> Size(cl) * Order(Representative(cl)));
        E1 := (summe - 1) / (Order(G) - 1);
        E2 := (summe - 1.0) / (Order(G) - 1.0);  

        Print("p = ", p, " → E(G) = ", E1, " ", E2, "\n");
        WriteLine(file_res, Concatenation("PSL2_", String(p), ",", String(Order(G)), ",", String(E1), ",", String(E2)));
        Add(ergebnisse, E1);
    od;    

#we close the file we produced and print the list of ergebnisse to the terminal

    CloseStream(file_res);  
    return ergebnisse;
end;
