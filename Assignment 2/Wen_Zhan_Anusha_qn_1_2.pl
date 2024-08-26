/* ------------ Facts and Definitions ----------- 
    company(x) -> x is a company
    competitor(x, y) -> x and y are competitors
    develop(x, y) -> x develops Product y
    steal(x, y) -> x steals Product y
    boss(x, y) -> x is the boss of y

*/

company(sumsum).
company(appy).
competitor(sumsum, appy).
develop(sumsum, galactica-s3).
smart_phone_tech(galactica-S3).
steal(stevey, galactica-s3).
boss(stevey, appy).

/* ------------ Rules and Definitions -----------*/
/* Defined by logic */
competitor(X, Y) :- company(X), company(Y), X \= Y.
boss(X, Y) :- company(Y).
develop(X, Y) :- company(X), business(Y).
steal(X, Y) :- business(Y). 

/* Defined by question */
rival(X, Y) :- competitor(X, Y), X \= Y.
business(Product) :- smart_phone_tech(Product).
unethical(Person) :- boss(Person, X), steal(Person, Product), business(Product), rival(X, Y), develop(Y, Product).