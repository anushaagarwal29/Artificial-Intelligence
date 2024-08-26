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

% Define son daughter relationships
son_of(X, Y):- child_of(X, Y), male(X).
daughter_of(X, Y):- child_of(X, Y), female(X).

% X is successor of Y when X is child of Y.
successor_of(X,Y) :- child_of(X,Y).

% Order of precedence according to old rule.
% Define rules
predecessor_of(X,Y) :-
    % Rule1 - X predecessor of Y if X and Y are siblings and X is male and Y is female
    successor_of(X,W), successor_of(Y,W), male(X), female(Y);

    % Rule2 - X predecessor of Y if X and Y are siblings and X,Y are males and X older than Y
    successor_of(X,W), successor_of(Y,W), older_than(X,Y), male(X), male(Y);

    % Rule3 - X predecessor of Y if X and Y are siblings and X,Y are females and X older than Y
    successor_of(X,W), successor_of(Y,W), older_than(X,Y), female(X), female(Y).

% Count number of Predecessors of X
count_predecessor(X, Count):- findall(X, predecessor_of(X, _), PredecessorList), length(PredecessorList, Count).

% Find the line of Succession of the Monarch 
line_of_succession(Monarch, SuccessorList):-
    findall(X-Count, (member(X, [princess_ann, prince_charles, prince_andrew, prince_edward]),count_predecessor(X, Count)), Monarch_Count_Pair), 
    sort(2, @>=,Monarch_Count_Pair, SortedList), 
    maplist([X-_,X]>>true, SortedList, SuccessorList).








