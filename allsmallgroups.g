allsmall := function(m,n)
    local G, g, file_out, avgOrder, tolerance, target, groupName, ord, i, nr;

    file_out := OutputTextFile("results_averageorder_near_67_24_1.txt", false);
    WriteLine(file_out, "GroupName, GroupOrder, AvgElementOrder");

    target := 67/24;
    tolerance := n;

    for ord in [1..m] do
        nr := NrSmallGroups(ord);
        for i in [1..nr] do
            G := SmallGroup(ord, i);
            avgOrder := Sum(Elements(G), g -> Order(g)) / Size(G);
            if AbsoluteValue(avgOrder - target) < tolerance then
                groupName := StructureDescription(G);
                WriteLine(file_out,
                    Concatenation(groupName, ", ",
                                 String(Size(G)), ", ",
                                 String(avgOrder)));
            fi;
        od;
    od;

    CloseStream(file_out);
end;
