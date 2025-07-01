#computations of the solvability theorem of my BA, namely that a group G of order n is 
#solvable, if the sum of orders (\psi(G)) is bigger or equal to 211/1617 \psi C_n

#we need to initilize a function and tell it the input it will get
SumOfOrders := function(m,n)
    local G, g, grouporder, file_out

    #we want to produce an ouput file 
    file_out := OutputTextFile("results_sumoforder.txt", false);
    WriteLine(file_out, "GroupName, GroupOrder, PsiValue, Psivalue_decimal");

    grouporder := [1..n];

    for n in grouporder do 
        G := 