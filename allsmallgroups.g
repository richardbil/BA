allsmall := function(m)
    local G, g, file_out, avgOrder, tolerance, target, groupName;

    # Datei vorbereiten (überschreibt alte Datei)
    file_out := OutputTextFile("results_averageorder_near_67_24.txt", false);
    WriteLine(file_out, "GroupName, GroupOrder, AvgElementOrder");

    # Zielwert und Toleranz definieren
    target := 67/24;
    tolerance := 0.01;

    # Alle Gruppen bis Größe m durchgehen
    for G in AllSmallGroups(m) do
        if Size(G) < m then
            avgOrder := Sum(Elements(G), g -> Order(g)) / Size(G);
            if Abs(avgOrder - target) < tolerance then
                groupName := StructureDescription(G);
                WriteLine(file_out,
                    Concatenation(groupName, ", ",
                                 String(Size(G)), ", ",
                                 String(avgOrder)));
            fi;
        fi;
    od;

    CloseStream(file_out);
end;
