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

%0
validPosition(X, Y, 1, 0) :- cell(X, Y), cell(X + 1, Y), cell(X + 2, Y), cell(X + 1, Y + 1), not busyCell(X, Y), not busyCell(X + 1, Y), not busyCell(X + 2, Y), not busyCell(X + 1, Y + 1), spawnedTetromino(1, _, _, _,  _, _, _).
%90
validPosition(X, Y, 1, 1) :- cell(X + 1, Y), cell(X + 1, Y + 1), cell(X + 1, Y + 2), cell(X, Y + 1), not busyCell(X + 1, Y), not busyCell(X + 1, Y + 1), not busyCell(X + 1, Y + 2), not busyCell(X, Y + 1).
%180
validPosition(X, Y, 1, 2) :- cell(X, Y + 1), cell(X + 1, Y + 1), cell(X + 2, Y + 1), cell(X + 1, Y), not busyCell(X, Y + 1), not busyCell(X + 1, Y + 1), not busyCell(X + 2, Y + 1), not busyCell(X + 1, Y).
%270
validPosition(X, Y, 1, 3) :- cell(X, Y), cell(X, Y + 1), cell(X, Y + 2), cell(X + 1, Y + 1), not busyCell(X, Y), not busyCell(X, Y + 1), not busyCell(X, Y + 2), not busyCell(X + 1, Y + 1).

bestPos(Y, X, 0) :- maxRot0(X, Y), maxRot90(X1, Y1), maxRot180(X2, Y2), maxRot270(X3, Y3), Y > Y1, Y > Y2, Y > Y3.
bestPos(Y, X, 1) :- maxRot0(X1, Y1), maxRot90(X, Y), maxRot180(X3, Y3), maxRot270(X2, Y2), Y >= Y1, Y >= Y2, Y >= Y3.
bestPos(Y, X, 2) :- maxRot0(X1, Y1), maxRot90(X2, Y2), maxRot180(X, Y), maxRot270(X3, Y3), Y >= Y1, Y > Y2, Y > Y3.
bestPos(Y, X, 3) :- maxRot0(X1, Y1), maxRot90(X2, Y2), maxRot180(X3, Y3), maxRot270(X, Y), Y >= Y1, Y > Y2, Y >= Y3.

maxRot0(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 1, 0)}, validPosition(X, Y, 1, 0).
maxRot90(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 1, 1)}, validPosition(X, Y, 1, 1).
maxRot180(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 1, 2)}, validPosition(X, Y, 1, 2).
maxRot270(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 1, 3)}, validPosition(X, Y, 1, 3).