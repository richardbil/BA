comp_dihetimes := function(n)
    local i, dihedral_group, D6, G, g, summe, E1, E2, oG1, oG2, diff, ergebnisse, file_res;

    # initialize an empty list to store the results
    ergebnisse := [];

    # produce a file we can analyze with Python
    file_res := OutputTextFile("results_compare_dihedral.txt", false);
    WriteLine(file_res, "GroupName, GroupOrder, E(G)value, E(G)value_decimal, o(G)value, o(G)value_decimal, diff");



    # Initialize dihedral_group list for the direct product
    dihedral_group := [];

    # Loop through the primes and exponents
        for i in [1..n] do
            # Create the dihedral group D6
            D6 := DihedralGroup(6);
            Add(dihedral_group, D6);

            # Compute the direct product of all dihedral groups up to this point
            G := DirectProduct(dihedral_group);

            # Calculate the sum of element orders and E(G)
            summe := Sum(Elements(G), g -> Order(g));
            E1 := (summe - 1) / (Order(G) - 1);
            E2 := (summe - 1.0) / (Order(G) - 1.0);

            # Calculate the average element order for G
            oG1 := summe / Order(G);
            oG2 := 1.0 * summe / Order(G);

            diff := oG2 - E2;

            # Print the results to the terminal
            Print("D6, ",i , " → E(G) = ", E1, " ", E2, " ", oG1, " ", oG2, " ", diff, "\n");

            # Write the results to the file
            WriteLine(file_res, Concatenation("D6, ", String(i), ",", String(Order(G)), ",", String(E1), ",", String(E2), ",", String(oG1), ",", String(oG2), ",", String(diff)));

            # Add the diff value to the results list
            Add(ergebnisse, diff);
        od;

    # Close the file and return the results
    CloseStream(file_res);
    return ergebnisse;
end;
