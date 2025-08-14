comp_PSL := function(n)
    local G, summe, E1, E2, oG1, oG2, ergebnisse, file_res, p, primes;

    # print an empty ergebnisse list
    ergebnisse := [];

    # produce a file we can analyze with python to plot etc. with n and the values 
    file_res := OutputTextFile("results_compare_pslp.txt", false); 
    WriteLine(file_res, "GroupName, GroupOrder, E(G)value, E(G)value_decimal, o(G)value, o(G)value_decimal");

    # generate the first n primes
    primes := [];;
    p := 2;;
    while Length(primes) < n do
        Add(primes, p);
        p := NextPrimeInt(p + 1);
    od;

    # for every prime p in the list of primes we build PSL(2, p) and build a sum over every order of 
    # conjugacy class times the order of the elements of that class,
    # then we compute E(G) and o(G) values (exact and decimal), and write them to file
    for p in primes do
        G := ProjectiveSpecialLinearGroup(2, p);
        summe := Sum(ConjugacyClasses(G), cl -> Size(cl) * Order(Representative(cl)));
        
        E1 := (summe - 1) / (Order(G) - 1);
        E2 := (summe - 1.0) / (Order(G) - 1.0);  

        oG1 := summe / Order(G);
        oG2 := 1.0 * summe / Order(G);

        Print("p = ", p, " → E(G) = ", E1, " ", E2, " ; o(G) = ", oG1, " ", oG2, "\n");
        WriteLine(file_res, Concatenation("PSL2_", String(p), ",", String(Order(G)), ",", 
            String(E1), ",", String(E2), ",", String(oG1), ",", String(oG2)));

        Add(ergebnisse, E1);
    od;    

    # we close the file we produced and return the list of E(G) values
    CloseStream(file_res);  
    return ergebnisse;
end;
