allsmall := function(m,n)
    local G, g, file_out, avgOrder, tolerance, target, groupName, ord, i, nr, count;

    file_out := OutputTextFile("elem_abel_solv_res.txt", false);
    WriteLine(file_out, "GroupName, GroupOrder, AvgElementOrder, isElemAbel2");

    target := 13/6;
    tolerance := n;
    count:=0;

    for ord in [1..m] do
        nr := NrSmallGroups(ord);
        for i in [1..nr] do
            count := count +1;
            G := SmallGroup(ord, i);
            avgOrder := Sum(Elements(G), g -> Order(g)) / Size(G);
            if AbsoluteValue(avgOrder - target) < tolerance then
                groupName := StructureDescription(G);
                WriteLine(file_out,
                    Concatenation(groupName, ", ",
                                  String(Size(G)), ", ",
                                  String(avgOrder), ", ",
                                  String(IsElementaryAbelian(G) and Size(G) mod 2 = 0)));
            fi;
        od;
    od;
    CloseStream(file_out);
    Print("checked", count, "groups");
end;
