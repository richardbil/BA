# we need to define a function to call in gap in terminal, we call the function ModAvgPSL,
# in gap we need to tell the function the locals we want to define or call in the beginning

ModavgPSL := function(n)
    local G, summe, E1, E2, ergebnisse, file_res, p, primes;

    # print an empty ergebnisse list
    ergebnisse := [];

    # produce a file we can analyze with python to plot etc. with n and the values 
    file_res := OutputTextFile("pslp_conjugacy_results.txt", false); 
    WriteLine(file_res, "GroupName, GroupOrder, E(G)value, E(G)value_decimal");

    # generate the first n primes
    primes := [];;
    p := 2;;
    while Length(primes) < n do
        Add(primes, p);
        p := NextPrimeInt(p + 1);
    od;

    # for every prime p in the list of primes we build PSL(2, p) and build a sum over every order of 
    # conjugacy class times the order of the elements of that class,
    # and then we produce the E(G) value in normal and decimal
    # then we print it to the terminal, to the file, and to the ergebnisse list, which we print too

    for p in primes do
        G := ProjectiveSpecialLinearGroup(2, p);
        summe := Sum(ConjugacyClasses(G), cl -> Size(cl) * Order(Representative(cl)));
        E1 := (summe - 1) / (Order(G) - 1);
        E2 := (summe - 1.0) / (Order(G) - 1.0);  

        Print("p = ", p, " → E(G) = ", E1, " ", E2, "\n");
        WriteLine(file_res, Concatenation("PSL2_", String(p), ",", String(Order(G)), ",", String(E1), ",", String(E2)));
        Add(ergebnisse, E1);
    od;    

    # we close the file we produced and print the list of ergebnisse to the terminal
    CloseStream(file_res);  
    return ergebnisse;
end;
