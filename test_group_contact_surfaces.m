% Test group contact surfaces

P = [0 6.5; 2.5 8;2.5 5;6.5 8; 6.5 5; 8 6.5; 8 5];
T = [5 6 7; 1 2 3; 2 3 4];
TR = triangulation(T,P);
triplot(TR);
vec = [1 2 3];
y = groupContacts(TR, vec)