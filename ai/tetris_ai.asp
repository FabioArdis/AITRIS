% INPUT
% spawnedTetromino([[_,_,_],[_,_,_]])
% busyCell(_,_)

% OUTPUT
%

rows(0..15). %20
cols(0..9).
cell(R,C) :- rows(R), cols(C).

%tetromino(1, 1, 1, 1).         % I
%tetromino(1, 1, 1, 0, 1, 0). % T
%tetromino(1, 1, 1, 1, 0, 0). % L
%tetromino(1, 1, 1, 0, 0, 1). % J
%tetromino(1, 1, 1, 1).       % Cube
%tetromino(1, 1, 0, 0, 1, 1). % Z
%tetromino(0, 1, 1, 1, 1, 0). % S
%spawnedTetromino(1,1,1, 0,1,0).
%position(10,2).

freeCell(R,C) | notFreeCell(R,C) :- cell(R,C).
:- freeCell(R,C), busyCell(R,C).

% aiPosition for shapes defined like [[_,_,_], [_,_,_]] (for shape: 'T', 'L', 'J', 'Z, S')
aiPosition(R, C, A,B,C1, D,E,F) | notAiPosition(R, C, A,B,C1, D,E,F) :- spawnedTetromino(A,B,C1, D,E,F), freeCell(R,C).
% aiPosition for shapes defined like [[_,_,_,_]] (for shape: 'I')
aiPosition(R, C, A,B,C1,D) | notAiPosition(R, C, A,B,C1,D) :- spawnedTetromino(A,B,C1,D), freeCell(R,C).
% aiPosition for shapes defined like [[_,_],[_,_]] (for shape: 'CUBE')
aiPosition(R, C, A,B, C1,D) | notAiPosition(R, C, A,B, C1,D) :- spawnedTetromino(A,B, C1,D), freeCell(R,C).

%, R1 = #max{R2:aiPosition(R2,_,[[A,B,C], [D,E,F]])}. %, C1=#max{C:aiPosition(_,C)}.
%:~ aiPosition(R, C, [[A,B,C1], [D,E,F]]), R>14. [R@1] % stavo cercando di mettere un "possibilmente scegli la R piu' grande possibile", ma quel che ho scritto qui non funziona


% Ricorda che le lettere A,B,C1,D,E,F di spawnedTetromino[] sono disposte cosi:
%
% A -- B -- C1
% D -- E -- F
%
% Non è possibile che la cella scelta per aiPosition collida con una cella occupata (for shape: 'T', 'L', 'J', 'Z, S')
:- aiPosition(R, C, A,B,C1, D,E,F), spawnedTetromino(A,B,C1, D,E,F), not freeCell(R, C), A=1.
:- aiPosition(R, C, A,B,C1, D,E,F), spawnedTetromino(A,B,C1, D,E,F), not freeCell(R, C+1), B=1.
:- aiPosition(R, C, A,B,C1, D,E,F), spawnedTetromino(A,B,C1, D,E,F), not freeCell(R, C+2), C1=1.
:- aiPosition(R, C, A,B,C1, D,E,F), spawnedTetromino(A,B,C1, D,E,F), not freeCell(R+1, C), D=1.
:- aiPosition(R, C, A,B,C1, D,E,F), spawnedTetromino(A,B,C1, D,E,F), not freeCell(R+1, C+1), E=1.
:- aiPosition(R, C, A,B,C1, D,E,F), spawnedTetromino(A,B,C1, D,E,F), not freeCell(R+1, C+2), F=1.


% Ricorda che le lettere A,B,C1,D di spawnedTetromino[] sono disposte cosi:
%
% A -- B -- C1 -- D
%
% Non è possibile che la cella scelta per aiPosition collida con una cella occupata (for shape: 'I')
:- aiPosition(R, C, A,B,C1,D), spawnedTetromino(A,B,C1,D), not freeCell(R, C), A=1.
:- aiPosition(R, C, A,B,C1,D), spawnedTetromino(A,B,C1,D), not freeCell(R, C+1), B=1.
:- aiPosition(R, C, A,B,C1,D), spawnedTetromino(A,B,C1,D), not freeCell(R, C+2), C1=1.
:- aiPosition(R, C, A,B,C1,D), spawnedTetromino(A,B,C1,D), not freeCell(R, C+3), D=1.


% Ricorda che le lettere A,B,C1,D di spawnedTetromino[] sono disposte cosi:
%
% A  -- B
% C1 -- D
%
% Non è possibile che la cella scelta per aiPosition collida con una cella occupata (for shape: 'CUBE')
:- aiPosition(R, C, A,B, C1,D), spawnedTetromino(A,B, C1,D), not freeCell(R, C), A=1.
:- aiPosition(R, C, A,B, C1,D), spawnedTetromino(A,B, C1,D), not freeCell(R, C+1), B=1.
:- aiPosition(R, C, A,B, C1,D), spawnedTetromino(A,B, C1,D), not freeCell(R+1, C), C1=1.
:- aiPosition(R, C, A,B, C1,D), spawnedTetromino(A,B, C1,D), not freeCell(R+1, C+1), D=1.

rotatedTetromino("Right", D,A, E,B, F,C1) :- spawnedTetromino(A,B,C1, D,E,F).
rotatedTetromino("Down", D,E,F, A,B,C1) :- spawnedTetromino(A,B,C1, D,E,F).
rotatedTetromino("Left", A,D, B,E, C1,F) :- spawnedTetromino(A,B,C1, D,E,F).

%:- aiPosition(R, C, [[A,B,C1], [D,E,F]]), rotatedTetromino("Right", [[D,A],[E,B],[F,C1]]), not freeCell(R, C), A=1.

%
% Find Best Position (work in progress)
%
%bestPos(R, C) :- R = #max{R1 : aiPosition(R1, C, [[_,_,_], [_,_,_]])}.%, aiPosition(R, C, [[_,_,_], [_,_,_]]). %, C = #min{C1 : aiPosition(R, C1, [[_,_,_], [_,_,_]])}.
%:~ aiPosition(R, C, [[A,B,C1],[D,E,F]]), R>=15. [R@1]
%:~ aiPosition(R, C, [[A,B,C1],[D,E,F]]), R>=10. [R@500]
%:~ aiPosition(R, C, [[A,B,C1],[D,E,F]]), R>=0. [R@1000]
%:~ aiPosition(R, _, [[_,_,_], [_,_,_]]), R=#min{R1:aiPosition(R1, _, [[_,_,_], [_,_,_]])}.
