cell(0..9, 0..19).

type(0). % I - 0
type(1). % T - 1
type(2). % L - 2
type(3). % J - 3
type(4). %[] - 4
type(5). % Z - 5
type(6). % S - 6

% spawnedTetromino(Shape,  A, B, C,  D, E, F).

%rotated90(Shape,  A, D,  B, E,  C, F) :- spawnedTetromino(Shape,  A, B, C,  D, E, F).
%rotated180(Shape,  D, E, F,  A, B, C) :- spawnedTetromino(Shape,  A, B, C,  D, E, F).
%rotated270(Shape, D, A,  E, B,  F, C) :- spawnedTetromino(Shape,  A, B, C,  D, E, F).

validPosition(X, Y, 1, 0) :- cell(X, Y), cell(X + 1, Y), cell(X + 2, Y), cell(X + 1, Y + 1), not busyCell(X, Y), not busyCell(X + 1, Y), not busyCell(X + 2, Y), not busyCell(X + 1, Y + 1), spawnedTetromino(1, _, _, _,  _, _, _).
validPosition(X, Y, 1, 1) :- cell(X + 1, Y), cell(X + 1, Y + 1), cell(X + 1, Y + 2), cell(X, Y + 1), not busyCell(X + 1, Y), not busyCell(X + 1, Y + 1), not busyCell(X + 1, Y + 2), not busyCell(X, Y + 1).
%validPosition(X, Y, 1, 2) :- cell(X, Y), cell(X, Y + 1), cell(X + 2, Y), not busyCell(X, Y - 1), not busyCell(X + 1, Y - 1), not busyCell(X + 2, Y - 1), not busyCell(X + 1, Y).
%validPosition(X, Y, 1, 3) :- cell(X, Y), cell(X, Y + 1), cell(X + 2, Y), not busyCell(X, Y - 1), not busyCell(X + 1, Y - 1), not busyCell(X + 2, Y - 1), not busyCell(X + 1, Y).

bestPos(Y, X, 0) :- maxRot0(X, Y), maxRot90(X1, Y1), Y > Y1.
bestPos(Y, X, 1) :- maxRot0(X1, Y1), maxRot90(X, Y), Y >= Y1.

maxRot0(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 1, 0)}, validPosition(X, Y, 1, R), R = 0.
maxRot90(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 1, 1)}, validPosition(X, Y, 1, R), R = 1.