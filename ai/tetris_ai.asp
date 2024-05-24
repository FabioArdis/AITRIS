% INPUT
% spawnedTetromino(_,_,_, _,_,_)
% busyCell(_,_)

% OUTPUT
%

rows(0..19).
cols(0..9).
cell(R,C) :- rows(R), cols(C).

freeCell(R,C) | notFreeCell(R,C) :- cell(R,C).
:- freeCell(R,C), busyCell(R,C).

% availablePosition for shapes defined like [[_,_,_], [_,_,_]] (for shape: 'T', 'L', 'J', 'Z, S')
availablePosition(R, C, Rotation) | notAiPosition(R, C, Rotation) :- cell(R, C), Rotation=0.

% Ricorda che le lettere A,B,C1,D,E,F di spawnedTetromino[] sono disposte cosi:
%
% ↓  Origin Point
% A -- B -- C1
% D -- E -- F
%
% Non è possibile che la cella scelta per availablePosition collida con una cella occupata (for shape: 'T', 'L', 'J', 'Z, S')
:- availablePosition(R, C, Rotation), spawnedTetromino(A,B,C1, D,E,F), not freeCell(R, C), A=1.
:- availablePosition(R, C, Rotation), spawnedTetromino(A,B,C1, D,E,F), not freeCell(R, C+1), B=1.
:- availablePosition(R, C, Rotation), spawnedTetromino(A,B,C1, D,E,F), not freeCell(R, C+2), C1=1.
:- availablePosition(R, C, Rotation), spawnedTetromino(A,B,C1, D,E,F), not freeCell(R+1, C), D=1.
:- availablePosition(R, C, Rotation), spawnedTetromino(A,B,C1, D,E,F), not freeCell(R+1, C+1), E=1.
:- availablePosition(R, C, Rotation), spawnedTetromino(A,B,C1, D,E,F), not freeCell(R+1, C+2), F=1.


%
% Rotation
%


%occupiedCellByTetromino(N) :- spawnedTetromino(A,B,C1, D,E,F), N=D+E+F.
%occupiedCellByTetromino(N) :- spawnedTetromino(A,B,C1, D,E,F), N=A+B+C1.
%
%numberOfCellFreeInARow(R, N) :- rows(R), N=#count{C: freeCell(R,C)}.
%consecutiveFreeCells(R, C1, C3) :- rows(R), col(C1), col(C2), col(C3), C2 = C1+1, C3 = C2+1, freeCell(R, C1), freeCell(R, C2), freeCell(R, C3).

%
% Find Best Position (work in progress)
%
bestPos(R, C, Rotation) :- R = #max{R1 : availablePosition(R1, _, _)}, availablePosition(R, C, Rotation).

% Controllo per vedere se il tetromino riesce effettivamente a passare
ceiling(R1, R) :- rows(R1), rows(R), R1 < R.
:- bestPos(R, C, Rotation), ceiling(R1, R), busyCell(R1, C).
:- bestPos(R, C, Rotation), ceiling(R1, R), busyCell(R1, C+1).
:- bestPos(R, C, Rotation), ceiling(R1, R), busyCell(R1, C+2).























% TODO
% availablePosition for shapes defined like [[_,_,_,_]] (for shape: 'I')
%availablePosition(R, C, A,B,C1,D) | notAiPosition(R, C, A,B,C1,D) :- spawnedTetromino(A,B,C1,D), freeCell(R,C).

% availablePosition for shapes defined like [[_,_],[_,_]] (for shape: 'CUBE')
%availablePosition(R, C, A,B, C1,D) | notAiPosition(R, C, A,B, C1,D) :- spawnedTetromino(A,B, C1,D), freeCell(R,C).

% Ricorda che le lettere A,B,C1,D di spawnedTetromino[] sono disposte cosi:
%
% A -- B -- C1 -- D
%
% Non è possibile che la cella scelta per availablePosition collida con una cella occupata (for shape: 'I')
%:- availablePosition(R, C, A,B,C1,D), spawnedTetromino(A,B,C1,D), not freeCell(R, C), A=1.
%:- availablePosition(R, C, A,B,C1,D), spawnedTetromino(A,B,C1,D), not freeCell(R, C+1), B=1.
%:- availablePosition(R, C, A,B,C1,D), spawnedTetromino(A,B,C1,D), not freeCell(R, C+2), C1=1.
%:- availablePosition(R, C, A,B,C1,D), spawnedTetromino(A,B,C1,D), not freeCell(R, C+3), D=1.


% Ricorda che le lettere A,B,C1,D di spawnedTetromino[] sono disposte cosi:
%
% A  -- B
% C1 -- D
%
% Non è possibile che la cella scelta per availablePosition collida con una cella occupata (for shape: 'CUBE')
%:- availablePosition(R, C, A,B, C1,D), spawnedTetromino(A,B, C1,D), not freeCell(R, C), A=1.
%:- availablePosition(R, C, A,B, C1,D), spawnedTetromino(A,B, C1,D), not freeCell(R, C+1), B=1.
%:- availablePosition(R, C, A,B, C1,D), spawnedTetromino(A,B, C1,D), not freeCell(R+1, C), C1=1.
%:- availablePosition(R, C, A,B, C1,D), spawnedTetromino(A,B, C1,D), not freeCell(R+1, C+1), D=1.
