# we need to define a function to call in GAP in the terminal, we call the function ModavgPSLqi
# in GAP, we need to specify the local variables we want to define or call at the beginning

ModavgPSLqi := function(m, n)
    local primes, p, i, G, summe, E1, E2, ergebnisse, file_res;

    # initialize an empty list to store the results

    ergebnisse := [];

    # produce a file we can analyze with Python to plot etc., with group parameters and the computed values

    file_res := OutputTextFile("results_conjugacy_pslqi.txt", false);
    WriteLine(file_res, "GroupName, GroupOrder, E(G)value, E(G)value_decimal");

    # generate the first m primes
    primes := [];;
    p := 2;;
    while Length(primes) < m do
        Add(primes, p);
        p := NextPrimeInt(p + 1);
    od;

    # for each of the first m prime numbers p, and for i from 1 to n, we build PSL(2, p^i),
    # compute the sum over all conjugacy classes of size times order of representative,
    # then compute the E(G) value in both normal and decimal form
    # finally, we print it to the terminal, write it to the file, and add it to the ergebnisse list

    for p in primes do
        for i in [1..n] do
            G := ProjectiveSpecialLinearGroup(2, p^i);
            summe := Sum(ConjugacyClasses(G), cl -> Size(cl) * Order(Representative(cl)));
            E1 := (summe - 1) / (Order(G) - 1);
            E2 := (summe - 1.0) / (Order(G) - 1.0);

            Print("p = ", p, ", i = ", i, " → p^i = ", p^i, " → E(G) = ", E1, " ", E2, "\n");
            WriteLine(file_res, Concatenation("PSL2_", String(p^i), ",", String(Order(G)), ",", String(E1), ",", String(E2)));
            Add(ergebnisse, E1);
        od;
    od;

    # close the file and return the list of results

    CloseStream(file_res);
    return ergebnisse;
end;
