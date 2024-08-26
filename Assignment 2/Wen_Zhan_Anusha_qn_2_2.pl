% Define the royal family members
female(queen_elizabeth).
female(princess_ann).
male(prince_charles).
male(prince_andrew).
male(prince_edward).
male(X):- not(female(X)).

% Define parent child relationships
parent_of(queen_elizabeth, prince_charles).
parent_of(queen_elizabeth, princess_ann).
parent_of(queen_elizabeth, prince_andrew).
parent_of(queen_elizabeth, prince_edward).
child_of(X,Y):- parent_of(Y,X).

% Define sibling relationships
older_than(prince_charles, princess_ann).
older_than(prince_charles, prince_andrew).
older_than(prince_charles, prince_edward).
older_than(princess_ann, prince_andrew).
older_than(princess_ann, prince_edward).
older_than(prince_andrew, prince_edward).

% X is successor of Y when X is child of Y.
successor_of(X,Y) :- child_of(X,Y).

% Order of precedence according to new rule.
% Define rules
predecessor_of(X,Y) :-
    % If X and Y are siblings and X is older than Y then X precedes Y.
    successor_of(X,W), successor_of(Y,W), older_than(X,Y).

% Count nuumber of Predecessors of X
count_predecessor(X, Count):- findall(X, predecessor_of(X, _), PredecessorList), length(PredecessorList, Count).

% Find the line of Succession of the Monarch 
line_of_succession(Monarch, SuccessorList):-
    findall(X-Count, (member(X, [princess_ann, prince_charles, prince_andrew, prince_edward]),count_predecessor(X, Count)), Monarch_Count_Pair), 
    sort(2, @>=,Monarch_Count_Pair, SortedList), 
    maplist([X-_,X]>>true, SortedList, SuccessorList).







