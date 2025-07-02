#computations of the solvability theorem in my BA, namely that a group G of order n is 
#solvable, if the sum of orders (\psi(G)) is bigger or equal to 211/1617 \psi C_n

#List of Groups:
#Symmetric Groups
#Alternating Groups
#Cyclic Groups
#General Linear Groups
#Special Linear Groups
#Projective Special Linear Group



#we need to initilize a function and tell it the input it will get
comppsivalue := function(m)
    local G, g, file_out, maxorder, psi, n, ergebnisse, boundary, p, primes;

    #we want to produce an ouput file 
    file_out := OutputTextFile("results_sumoforder.txt", false);
    WriteLine(file_out, "GroupName, GroupOrder, PsiValue");

    maxorder := m;

    for n in [1..20] do 
        G := SymmetricGroup(n);
        if Size(G) < maxorder then
            psi := Sum(Elements(G), g -> Order(g));
            WriteLine(file_out, Concatenation("S_", String(n), ", ", String(Size(G)), ", ", String(psi)));
        fi;
    od;

    for n in [1..20] do 
        G := AlternatingGroup(n);
        if Size(G) < maxorder then
            psi := Sum(Elements(G), g -> Order(g));
            WriteLine(file_out, Concatenation("A_", String(n), ", ", String(Size(G)), ", ", String(psi)));
        fi;
    od;

    for n in [1..m] do 
        G := CyclicGroup(n);
        psi := Sum(Elements(G), g -> Order(g));
        boundary := 211/1617 * psi;
        WriteLine(file_out, Concatenation("C_", String(n), ", ", String(Size(G)), ", ", String(boundary)));
    od;

    # generate the first m primes
    primes := [];
    p := 2;
    while Length(primes) < m  do
        Add(primes, p);
        p := NextPrimeInt(p + 1);
    od;

    for n in primes do 
        G := GL(2, n);
        if Size(G) < maxorder then
            psi := Sum(Elements(G), g -> Order(g));
            WriteLine(file_out, Concatenation("GL(2.", String(n),")", ", ", String(Size(G)), ", ", String(psi)));
        fi;
    od;

    for n in primes do 
        G := SL(2, n);
        if Size(G) < maxorder then
            psi := Sum(Elements(G), g -> Order(g));
            WriteLine(file_out, Concatenation("SL(2.", String(n),")", ", ", String(Size(G)), ", ", String(psi)));
        fi;
    od;

    for n in primes do 
        G := PSL(2, n);
        if Size(G) < maxorder then
            psi := Sum(Elements(G), g -> Order(g));
            WriteLine(file_out, Concatenation("PSL(2.", String(n),")", ", ", String(Size(G)), ", ", String(psi)));
        fi;
    od;

    CloseStream(file_out);
end;
