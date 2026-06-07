fa_search(Pattern_String, Text_String, Match_Index) :-
    string_chars(Pattern_String, Pattern_Characters),
    string_chars(Text_String, Text_Characters),
    sort(Pattern_Characters, Alphabet),
    fa_run_search(Pattern_Characters, Text_Characters, Alphabet, 0, 0, Match_Index).

fa_run_search(Pattern_Characters, _, _, Text_Index, Current_State, Match_Index) :-
    length(Pattern_Characters, Pattern_Length),
    Current_State =:= Pattern_Length,
    Match_Index is Text_Index - Pattern_Length.

fa_run_search(Pattern_Characters, Text_Characters, Alphabet, Text_Index, Current_State, Match_Index) :-
    nth0(Text_Index, Text_Characters, Current_Char),
    compute_next_state(Pattern_Characters, Alphabet, Current_State, Current_Char, Next_State),
    
    Next_Text_Index is Text_Index + 1,
    fa_run_search(Pattern_Characters, Text_Characters, Alphabet, Next_Text_Index, Next_State, Match_Index).

compute_next_state(Pattern_Characters, _, Current_State, Current_Char, Next_State) :-
    nth0(Current_State, Pattern_Characters, Current_Char), !,
    Next_State is Current_State + 1.

compute_next_state(Pattern_Characters, _, Current_State, Current_Char, Next_State) :-
    Current_State > 0,
    take(Current_State, Pattern_Characters, Prefix_So_Far),
    append(Prefix_So_Far, [Current_Char], Combined_Text),
    
    Fallback_Start is Current_State,
    find_fallback_state(Pattern_Characters, Combined_Text, Fallback_Start, Next_State), !.

compute_next_state(_, _, 0, _, 0).

find_fallback_state(Pattern_Characters, Combined_Text, Try_State, Try_State) :-
    take(Try_State, Pattern_Characters, Pattern_Prefix),
    append(_, Pattern_Prefix, Combined_Text). 

find_fallback_state(Pattern_Characters, Combined_Text, Try_State, Next_State) :-
    Try_State > 0,
    Lower_State is Try_State - 1,
    find_fallback_state(Pattern_Characters, Combined_Text, Lower_State, Next_State).

take(0, _, []) :- !.
take(N, [H|T], [H|Result]) :- N > 0, M is N - 1, take(M, T, Result).