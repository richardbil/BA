comp_cpitimes := function(m, n)
    local primes, p, i, cyclic_groups, Ci, G, g, summe, E1, E2, oG1, oG2, diff, ergebnisse, file_res;

    # initialize an empty list to store the results
    ergebnisse := [];

    # produce a file we can analyze with Python
    file_res := OutputTextFile("results_compare_cpitimes.txt", false);
    WriteLine(file_res, "GroupName, GroupOrder, E(G)value, E(G)value_decimal, o(G)value, o(G)value_decimal, diff");

    # generate the first m primes
    primes := [];
    p := 2;
    while Length(primes) < m do
        Add(primes, p);
        p := NextPrimeInt(p + 1);
    od;

    # Initialize cyclic_groups list for the direct product
    cyclic_groups := [];

    # Loop through the primes and exponents
    for p in primes do
        for i in [1..n] do
            # Create the cyclic group C_{p^i}
            Ci := CyclicGroup(p^i);
            Add(cyclic_groups, Ci);

            # Compute the direct product of all cyclic groups up to this point
            G := DirectProduct(cyclic_groups);

            # Calculate the sum of element orders and E(G)
            summe := Sum(Elements(G), g -> Order(g));
            E1 := (summe - 1) / (Order(G) - 1);
            E2 := (summe - 1.0) / (Order(G) - 1.0);

            # Calculate the average element order for G
            oG1 := summe / Order(G);
            oG2 := 1.0 * summe / Order(G);

            diff := oG2 - E2;

            # Print the results to the terminal
            Print("C_", p^i, " → E(G) = ", E1, " ", E2, " ", oG1, " ", oG2, " ", diff, "\n");

            # Write the results to the file
            WriteLine(file_res, Concatenation("C_", String(p^i), ",", String(Order(G)), ",", String(E1), ",", String(E2), ",", String(oG1), ",", String(oG2), ",", String(diff)));

            # Add the diff value to the results list
            Add(ergebnisse, diff);
        od;
    od;

    # Close the file and return the results
    CloseStream(file_res);
    return ergebnisse;
end;
