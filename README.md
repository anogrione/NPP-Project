# Exact String Matching in Prolog: KMP and Finite Automata

This project implements two distinct string matching algorithms in Prolog:
1. **Knuth-Morris-Pratt (KMP) Algorithm** (`kmp.pl`)
2. **Deterministic Finite Automaton (DFA) Matcher** (`automaton.pl`)

Both approaches solve the string-matching problem by scanning the input text from left to right without ever backtracking the text pointer, achieving an efficient $O(N)$ runtime context during the search phase.

---

## File Structure

* `kmp.pl`: Contains the KMP implementation. 
* `automaton.pl`: Contains the Finite Automaton implementation.

---

## How to Load and Run the Programs

Open your terminal, navigate to the directory containing your files, and boot SWI-Prolog with the KMP(Automaton) file loaded:
swipl kmp.pl 
or
swipl automaton.pl

Sample query:
?- kmp_search("fox", "the quick brown fox jumps", Match_Index).

The result:
Match_Index = 16.

Sample query:
?- kmp_search("abab", "abababab", Match_Index).

The result:
Match_Index = 0 ;
Match_Index = 2 ;
Match_Index = 4.
