kmp_search(Pattern_String, Text_String, Match_Index) :-
    string_chars(Pattern_String, Pattern_Characters),
    string_chars(Text_String, Text_Characters),
    build_lps_table(Pattern_Characters, LPS_Table),
    kmp_run_search(Pattern_Characters, Text_Characters, LPS_Table, 0, 0, Match_Index).

build_lps_table(Pattern_Characters, LPS_Table) :-
    length(Pattern_Characters, Pattern_Length),
    length(LPS_Table, Pattern_Length),
    nth0(0, LPS_Table, 0),
    build_lps_loop(Pattern_Characters, 1, 0, LPS_Table).


build_lps_loop(Pattern_Characters, Current_Index, _, _) :-
    length(Pattern_Characters, Pattern_Length),
    Current_Index >= Pattern_Length.

build_lps_loop(Pattern_Characters, Current_Index, Prefix_Length, LPS_Table) :-
    nth0(Current_Index, Pattern_Characters, Shared_Char),
    nth0(Prefix_Length, Pattern_Characters, Shared_Char), 
    New_Prefix_Length is Prefix_Length + 1,
    nth0(Current_Index, LPS_Table, New_Prefix_Length),
    Next_Index is Current_Index + 1,
    build_lps_loop(Pattern_Characters, Next_Index, New_Prefix_Length, LPS_Table).

build_lps_loop(Pattern_Characters, Current_Index, Prefix_Length, LPS_Table) :-
    Prefix_Length > 0,
    Previous_LPS_Index is Prefix_Length - 1,
    nth0(Previous_LPS_Index, LPS_Table, Fallen_Back_Prefix_Length),
    
    build_lps_loop(Pattern_Characters, Current_Index, Fallen_Back_Prefix_Length, LPS_Table).

build_lps_loop(Pattern_Characters, Current_Index, 0, LPS_Table) :-
    nth0(Current_Index, LPS_Table, 0),
    Next_Index is Current_Index + 1,
    build_lps_loop(Pattern_Characters, Next_Index, 0, LPS_Table).

kmp_run_search(Pattern_Characters, _, _, Text_Index, Pattern_Index, Match_Index) :-
    length(Pattern_Characters, Pattern_Length),
    Pattern_Index =:= Pattern_Length,
    Match_Index is Text_Index - Pattern_Length.

kmp_run_search(Pattern_Characters, Text_Characters, LPS_Table, Text_Index, Pattern_Index, Match_Index) :-
    nth0(Text_Index, Text_Characters, Shared_Char),
    nth0(Pattern_Index, Pattern_Characters, Shared_Char), 
    Next_Text_Index is Text_Index + 1,
    Next_Pattern_Index is Pattern_Index + 1,
    kmp_run_search(Pattern_Characters, Text_Characters, LPS_Table, Next_Text_Index, Next_Pattern_Index, Match_Index).

kmp_run_search(Pattern_Characters, Text_Characters, LPS_Table, Text_Index, Pattern_Index, Match_Index) :-
    Pattern_Index > 0,
    Previous_Pattern_Index is Pattern_Index - 1,
    nth0(Previous_Pattern_Index, LPS_Table, Fallen_Back_Pattern_Index),
    
    kmp_run_search(Pattern_Characters, Text_Characters, LPS_Table, Text_Index, Fallen_Back_Pattern_Index, Match_Index).

kmp_run_search(Pattern_Characters, Text_Characters, LPS_Table, Text_Index, 0, Match_Index) :-
    Next_Text_Index is Text_Index + 1,
    
    kmp_run_search(Pattern_Characters, Text_Characters, LPS_Table, Next_Text_Index, 0, Match_Index).