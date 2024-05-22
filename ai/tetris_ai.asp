% Righe, colonne e celle
rows(0..19).
cols(0..9).
cell(R, C) :- rows(R), cols(C).

% spawnedTetromino(1, 1, 1, 0, 1, 0).

% Due predicati definiti da una disgiunzione, più un constraint
freeCell(R, C) | notFreeCell(R, C) :- cell(R, C).
:- freeCell(R, C), busyCell(R, C).

% Definiamo tutte le posizioni che possono avere le forme di tipo [[_,_,_],
% Ricorda:                                                         [_,_,_]]
% A -- B -- C1
% D -- E -- F
aiPosition(R, C, A, B, C1, D, E, F) | notAiPosition(R, C, A, B, C1, D, E, F) :- spawnedTetromino(A, B, C1, D, E, F), cell(R, C).

% Definiamo dei constraint per evitare che il la posizione di un tetramino [[_,_,_], finisca in una cella occupata
%                                                                           [_,_,_]]
:- aiPosition(R, C, A, B, C1, D, E, F), spawnedTetromino(A, B, C1, D, E, F), not freeCell(R, C), A=1.
:- aiPosition(R, C, A, B, C1, D, E, F), spawnedTetromino(A, B, C1, D, E, F), not freeCell(R, C+1), B=1.
:- aiPosition(R, C, A, B, C1, D, E, F), spawnedTetromino(A, B, C1, D, E, F), not freeCell(R, C+2), C1=1.
:- aiPosition(R, C, A, B, C1, D, E, F), spawnedTetromino(A, B, C1, D, E, F), not freeCell(R+1, C), D=1.
:- aiPosition(R, C, A, B, C1, D, E, F), spawnedTetromino(A, B, C1, D, E, F), not freeCell(R+1, C+1), E=1.
:- aiPosition(R, C, A, B, C1, D, E, F), spawnedTetromino(A, B, C1, D, E, F), not freeCell(R+1, C+2), F=1.

% Definiamo la rotazione dei nostri tetramini
rotatedTetromino(1, D,A, E,B, F,C1) :- spawnedTetromino(A,B,C1, D,E,F). % 90°
rotatedTetromino(2, F,E,D, C1,B,A) :- spawnedTetromino(A,B,C1, D,E,F).  % 180°
rotatedTetromino(3, C1,F, B,E, A,D) :- spawnedTetromino(A,B,C1, D,E,F). % 270°

% Stessi constraint di prima, solo che controlliamo anche la posizione del nostro tetromino ruotato.
% 90°
:- aiPosition(R, C, D,A, E,B, F,C1), rotatedTetromino(1, D,A, E,B, F,C1), not freeCell(R, C), D=1.
:- aiPosition(R, C, D,A, E,B, F,C1), rotatedTetromino(1, D,A, E,B, F,C1), not freeCell(R, C+1), A=1.
:- aiPosition(R, C, D,A, E,B, F,C1), rotatedTetromino(1, D,A, E,B, F,C1), not freeCell(R, C+2), B=1.
:- aiPosition(R, C, D,A, E,B, F,C1), rotatedTetromino(1, D,A, E,B, F,C1), not freeCell(R + 1, C), F=1.
:- aiPosition(R, C, D,A, E,B, F,C1), rotatedTetromino(1, D,A, E,B, F,C1), not freeCell(R + 1, C+1), C1=1.

% 180°
:- aiPosition(R, C, F,E,D, C1,B,A), rotatedTetromino(2, F,E,D, C1,B,A), not freeCell(R, C), F=1.
:- aiPosition(R, C, F,E,D, C1,B,A), rotatedTetromino(2, F,E,D, C1,B,A), not freeCell(R, C+1), E=1.
:- aiPosition(R, C, F,E,D, C1,B,A), rotatedTetromino(2, F,E,D, C1,B,A), not freeCell(R, C+2), D=1.
:- aiPosition(R, C, F,E,D, C1,B,A), rotatedTetromino(2, F,E,D, C1,B,A), not freeCell(R + 1, C), C1=1.
:- aiPosition(R, C, F,E,D, C1,B,A), rotatedTetromino(2, F,E,D, C1,B,A), not freeCell(R + 1, C+1), B=1.

% 270°
:- aiPosition(R, C, C1,F, B,E, A,D), rotatedTetromino(3, C1,F, B,E, A,D), not freeCell(R, C), C1=1.
:- aiPosition(R, C, C1,F, B,E, A,D), rotatedTetromino(3, C1,F, B,E, A,D), not freeCell(R, C+1), F=1.
:- aiPosition(R, C, C1,F, B,E, A,D), rotatedTetromino(3, C1,F, B,E, A,D), not freeCell(R, C+2), E=1.
:- aiPosition(R, C, C1,F, B,E, A,D), rotatedTetromino(3, C1,F, B,E, A,D), not freeCell(R + 1, C), A=1.
:- aiPosition(R, C, C1,F, B,E, A,D), rotatedTetromino(3, C1,F, B,E, A,D), not freeCell(R + 1, C+1), D=1.


% Troviamo la posizione migliore del tetramino
bestPos(R, C) :- R = #max{R1 : aiPosition(R1, _, _, _, _, _, _, _)}, aiPosition(R, C, _, _, _, _, _, _).

% Evitiamo di scontrarci con altri tetramini mentre scendiamo
ceiling(R1, R) :- rows(R1), rows(R), R1 < R.
:- bestPos(R, C), ceiling(R1, R), busyCell(R1, C).
:- bestPos(R, C), ceiling(R1, R), busyCell(R1, C+1).
:- bestPos(R, C), ceiling(R1, R), busyCell(R1, C+2).

% Accertiamoci che effettivamente le celle siano libere dove mettiamo il nostro tetramino
:- bestPos(R, C), not freeCell(R, C).
:- bestPos(R, C), not freeCell(R, C+1).
:- bestPos(R, C), not freeCell(R, C+2).
:- bestPos(R, C), not freeCell(R+1, C).
:- bestPos(R, C), not freeCell(R+1, C+1).
:- bestPos(R, C), not freeCell(R+1, C+2).
:- bestPos(R, C), not freeCell(R+2, C).
:- bestPos(R, C), not freeCell(R+2, C+1).
