# we define a function to compute E(G) for a chain of cyclic groups of prime power order
# the function takes two arguments: m = number of primes, n = exponent limit per prime

ModavgCyclicPrimePowers := function(m, n)
    local primes, p, i, G, g, summe, E1, E2, ergebnisse, file_res;

    # initialize an empty list to store the results
    ergebnisse := [];

    # produce a file we can analyze with Python
    file_res := OutputTextFile("results_normal_cpi.txt", false);
    WriteLine(file_res, "GroupName, GroupOrder, E(G)value, E(G)value_decimal");

    # generate the first m primes
    primes := [];;
    p := 2;;
    while Length(primes) < m do
        Add(primes, p);
        p := NextPrimeInt(p + 1);
    od;

    # since every element in a cyclic group has its own conjugacy class, we dont need to produce members of conjugacy classes
    for p in primes do
        for i in [1..n] do
            G := CyclicGroup(p^i);
            summe := Sum(Elements(G), g -> Order(g));
            E1 := (summe - 1) / (Order(G) - 1);
            E2 := (summe - 1.0) / (Order(G) - 1.0);

            Print("C_", p^i, " → E(G) = ", E1, " ", E2, "\n");
            WriteLine(file_res, Concatenation("C_", String(p^i), ",", String(Order(G)), ",", String(E1), ",", String(E2)));
            Add(ergebnisse, E1);
        od;
    od;

    CloseStream(file_res);
    return ergebnisse;
end;
