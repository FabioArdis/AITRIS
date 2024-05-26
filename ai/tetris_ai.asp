cell(0..9, 0..18).

type(0). % I - 0
type(1). % T - 1
type(2). % L - 2
type(3). % J - 3
type(4). %[] - 4
type(5). % Z - 5
type(6). % S - 6

% spawnedTetromino(Shape,  A, B, C,  D, E, F).

rotated90(Shape,  A, D,  B, E,  C, F) :- spawnedTetromino(Shape,  A, B, C,  D, E, F).
rotated180(Shape,  D, E, F,  A, B, C) :- spawnedTetromino(Shape,  A, B, C,  D, E, F).
rotated270(Shape, D, A,  E, B,  F, C) :- spawnedTetromino(Shape,  A, B, C,  D, E, F).

validPosition(X, Y, 1) :- cell(X, Y), cell(X, Y + 1), cell(X + 2, Y), not busyCell(X, Y - 1), not busyCell(X + 1, Y - 1), not busyCell(X + 2, Y - 1), not busyCell(X + 1, Y).

bestPos(Y, X) :- Y = #max{ Y1 : validPosition(_, Y1, 1)}, validPosition(X, Y, 1).