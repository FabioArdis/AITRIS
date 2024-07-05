
% Define Rows
rows(0..19).

% Define Cells
cell(0..9, 0..19).

% Check if a cell is busy
checkCellBusy(X, Y) :- cell(X, Y), busyCell(X, Y).

% Check if a cell is not busy
checkCell(X, Y) :- cell(X, Y), not busyCell(X, Y).

% Define ceiling
ceiling(R1, R) :- rows(R1), rows(R), R1 < R.
% an equal way (but slower) would be:
% ceiling(R1, R) :- cell(_, R1), cell(_, R), R1 < R.

% Define if ceiling isn''t free
ceilingNotFree(X, Y) :- ceiling(Y1, Y), busyCell(X,Y1), Y<>Y1.

% Can't be a location isn't chosen
:- #count{Y, X, R: bestPos(Y, X, R)} <> 1. %>

bestPos(Y, X, R) | nbestPos(Y, X, R):- validPosition(X, Y, R). %, spawnedTetromino(0).
:~ bestPos(Y, X, R), Y1=19-Y. [Y1@1, Y1, R] %, spawnedTetromino(0)

% ##########################################################################################################################################################
% ##########################################################################################################################################################
% ##########################################################################################################################################################

%          0°                    90°
%   ################            ####
%   ################            ####
%                       --->    ####
%                       --->    ####
%                               ####
%                               ####
%                               ####
%                               ####

%0
validPosition(X, Y, 0) :- checkCell(X, Y), checkCell(X + 1, Y), checkCell(X + 2, Y), checkCell(X + 3, Y), not ceilingNotFree(X, Y), not ceilingNotFree(X + 1, Y), not ceilingNotFree(X + 2, Y), not ceilingNotFree(X + 3, Y), spawnedTetromino(0).
%90
%validPosition(X, Y, 0, 1) :- checkCell(X, Y), checkCell(X, Y + 1), checkCell(X, Y + 2), checkCell(X, Y + 3), not ceilingNotFree(X, Y + 1), spawnedTetromino(0).
validPosition(X, Y, 1) :- checkCell(X, Y), checkCell(X, Y - 1), checkCell(X, Y - 2), checkCell(X, Y-3), not ceilingNotFree(X, Y), spawnedTetromino(0).

%maxRot0(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 0, 0)}, validPosition(X, Y, 0, 0).
%maxRot90(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 0, 1)}, validPosition(X, Y, 0, 1).
%
%bestPos(Y, X, 0) | notBestPos(Y, X, 0):- maxRot0(X, Y), maxRot90(X1, Y1), Y > Y1, spawnedTetromino(0).
%bestPos(Y, X, 1) | notBestPos(Y, X, 1):- maxRot0(X1, Y1), maxRot90(X, Y), Y >= Y1, spawnedTetromino(0).


%0
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, R), checkCellBusy(X, Y+1), checkCellBusy(X+1, Y+1), checkCellBusy(X+2, Y+1), checkCellBusy(X+3, Y+1), spawnedTetromino(0), R=0. [0@0, Y, X, R]

:~ bestPos(Y, X, R), checkCellBusy(X, Y+1), checkCellBusy(X+1, Y+1), checkCellBusy(X+2, Y+1), checkCell    (X+3, Y+1), spawnedTetromino(0), R=0. [1@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+1), checkCellBusy(X+1, Y+1), checkCellBusy(X+2, Y+1), checkCellBusy(X+3, Y+1), spawnedTetromino(0), R=0. [2@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X, Y+1), checkCellBusy(X+1, Y+1), checkCell    (X+2, Y+1), checkCellBusy(X+3, Y+1), spawnedTetromino(0), R=0. [3@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X, Y+1), checkCell    (X+1, Y+1), checkCellBusy(X+2, Y+1), checkCellBusy(X+3, Y+1), spawnedTetromino(0), R=0. [4@0, Y, X, R]

:~ bestPos(Y, X, R), checkCellBusy(X, Y+1), checkCellBusy(X+1, Y+1), checkCell    (X+2, Y+1), checkCell    (X+3, Y+1), spawnedTetromino(0), R=0. [5@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X, Y+1), checkCell    (X+1, Y+1), checkCell    (X+2, Y+1), checkCellBusy(X+3, Y+1), spawnedTetromino(0), R=0. [6@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+1), checkCell    (X+1, Y+1), checkCellBusy(X+2, Y+1), checkCellBusy(X+3, Y+1), spawnedTetromino(0), R=0. [7@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+1), checkCellBusy(X+1, Y+1), checkCellBusy(X+2, Y+1), checkCell    (X+3, Y+1), spawnedTetromino(0), R=0. [8@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+1), checkCellBusy(X+1, Y+1), checkCell    (X+2, Y+1), checkCellBusy(X+3, Y+1), spawnedTetromino(0), R=0. [9@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X, Y+1), checkCell    (X+1, Y+1), checkCellBusy(X+2, Y+1), checkCell    (X+3, Y+1), spawnedTetromino(0), R=0. [10@0, Y, X, R]

:~ bestPos(Y, X, R), checkCell    (X, Y+1), checkCell    (X+1, Y+1), checkCell    (X+2, Y+1), checkCellBusy(X+3, Y+1), spawnedTetromino(0), R=0. [11@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+1), checkCell    (X+1, Y+1), checkCellBusy(X+2, Y+1), checkCell    (X+3, Y+1), spawnedTetromino(0), R=0. [13@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+1), checkCellBusy(X+1, Y+1), checkCell    (X+2, Y+1), checkCell    (X+3, Y+1), spawnedTetromino(0), R=0. [14@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X, Y+1), checkCell    (X+1, Y+1), checkCell    (X+2, Y+1), checkCell    (X+3, Y+1), spawnedTetromino(0), R=0. [12@0, Y, X, R]

:~ bestPos(Y, X, R), checkCell    (X, Y+1), checkCell    (X+1, Y+1), checkCell    (X+2, Y+1), checkCell    (X+3, Y+1), spawnedTetromino(0), R=0. [13@0, Y, X, R]

%90
:~ bestPos(Y, X, R), spawnedTetromino(0), R=1. [0@0, Y, X]

% ##########################################################################################################################################################
% ##########################################################################################################################################################
% ##########################################################################################################################################################

%        0°                     90°                 180°                270°
%   ############                ####                ####                ####
%   ############                ####                ####                ####
%       ####        --->    ########    --->    ############    --->    ########
%       ####        --->    ########    --->    ############    --->    ########
%                               ####                                    ####
%                               ####                                    ####

%0
validPosition(X, Y, 0) :- checkCell(X, Y), checkCell(X + 1, Y), checkCell(X + 2, Y), checkCell(X + 1, Y + 1),         not ceilingNotFree(X, Y + 1),  not ceilingNotFree(X + 1, Y + 1), not ceilingNotFree(X + 2, Y + 1), spawnedTetromino(1).
%90
validPosition(X, Y, 1) :- checkCell(X + 1, Y), checkCell(X + 1, Y + 1), checkCell(X + 1, Y + 2), checkCell(X, Y + 1), not ceilingNotFree(X, Y + 2),  not ceilingNotFree(X + 1, Y + 2), spawnedTetromino(1).
%180
validPosition(X, Y, 2) :- checkCell(X, Y + 1), checkCell(X + 1, Y + 1), checkCell(X + 2, Y + 1), checkCell(X + 1, Y), not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), not ceilingNotFree(X + 2, Y + 1), spawnedTetromino(1).
%270
validPosition(X, Y, 3) :- checkCell(X, Y), checkCell(X, Y + 1), checkCell(X, Y + 2), checkCell(X + 1, Y + 1),         not ceilingNotFree(X, Y + 2), not ceilingNotFree(X + 1, Y + 2), spawnedTetromino(1).

%maxRot0  (X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 1, 0)}, validPosition(X, Y, 1, 0).
%maxRot90 (X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 1, 1)}, validPosition(X, Y, 1, 1).
%maxRot180(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 1, 2)}, validPosition(X, Y, 1, 2).
%maxRot270(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 1, 3)}, validPosition(X, Y, 1, 3).
%
%bestPos(Y, X, 0) | notBestPos(Y, X, 0):- maxRot0(X, Y), maxRot90(X1, Y1), maxRot180(X2, Y2), maxRot270(X3, Y3), Y > Y1, Y > Y2, Y > Y3, spawnedTetromino(1).
%bestPos(Y, X, 1) | notBestPos(Y, X, 1):- maxRot0(X1, Y1), maxRot90(X, Y), maxRot180(X2, Y2), maxRot270(X3, Y3), Y >= Y1, Y >= Y2, Y >= Y3, spawnedTetromino(1).
%bestPos(Y, X, 2) | notBestPos(Y, X, 2):- maxRot0(X1, Y1), maxRot90(X2, Y2), maxRot180(X, Y), maxRot270(X3, Y3), Y >= Y1, Y > Y2, Y > Y3, spawnedTetromino(1).
%bestPos(Y, X, 3) | notBestPos(Y, X, 3):- maxRot0(X1, Y1), maxRot90(X2, Y2), maxRot180(X3, Y3), maxRot270(X, Y), Y >= Y1, Y > Y2, Y >= Y3, spawnedTetromino(1).

%bestPos(Y, X, R) | nbestPos(Y, X, R):- validPosition(X, Y, 1, R).
%:~ bestPos(Y, X, R), Y1=19-Y, spawnedTetromino(1). [Y1@1, Y1, R]

%0
%Prefer the bestPos where the Tetromino takes up the most space next to it
:~ bestPos(Y, X, R), checkCellBusy(X, Y+1), checkCellBusy(X+2, Y+1), spawnedTetromino(1), R=0. [3@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+1), checkCellBusy(X+2, Y+1), spawnedTetromino(1), R=0. [9@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X ,Y+1), checkCell    (X+2, Y+1), spawnedTetromino(1), R=0. [10@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+1), checkCell    (X+2, Y+1), spawnedTetromino(1), R=0. [11@0, Y, X, R]

%90
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, R), checkCellBusy(X, Y+2), spawnedTetromino(1), R=1. [2@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), spawnedTetromino(1), R=1. [7@0, Y, X, R]

%180
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, R), checkCellBusy(X, Y+2), checkCellBusy(X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(1), R=2. [0@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCellBusy(X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(1), R=2. [4@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X ,Y+2), checkCell    (X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(1), R=2. [5@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X ,Y+2), checkCellBusy(X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(1), R=2. [6@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X, Y+2), checkCell    (X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(1), R=2. [12@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCellBusy(X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(1), R=2. [13@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCell    (X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(1), R=2. [14@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCell    (X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(1), R=2. [15@0, Y, X, R]

%270
%Prefer the bestPos where the Tetromino takes up the most space next to it
:~ bestPos(Y, X, R), checkCellBusy(X+1, Y+2), spawnedTetromino(1), R=3. [1@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X+1, Y+2), spawnedTetromino(1), R=3. [8@0, Y, X, R]

% ##########################################################################################################################################################
% ##########################################################################################################################################################
% ##########################################################################################################################################################

%        0°                     90°                 180°                270°
%   ############            ########                    ####            ####
%   ############            ########                    ####            ####
%   ####            --->        ####    --->    ############    --->    ####
%   ####            --->        ####    --->    ############    --->    ####
%                               ####                                    ########
%                               ####                                    ########

%0
validPosition(X, Y, 0) :- checkCell(X, Y), checkCell(X + 1, Y), checkCell(X + 2, Y), checkCell(X, Y + 1),             not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), not ceilingNotFree(X + 2, Y + 1), spawnedTetromino(2).
%90
validPosition(X, Y, 1) :- checkCell(X, Y), checkCell(X + 1, Y), checkCell(X + 1, Y + 1), checkCell(X + 1, Y + 2),     not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 2), spawnedTetromino(2).
%180
validPosition(X, Y, 2) :- checkCell(X, Y + 1), checkCell(X + 1, Y + 1), checkCell(X + 2, Y + 1), checkCell(X + 2, Y), not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), not ceilingNotFree(X + 2, Y + 1), spawnedTetromino(2).
%270
validPosition(X, Y, 3) :- checkCell(X, Y), checkCell(X, Y + 1), checkCell(X, Y + 2), checkCell(X + 1, Y + 2),         not ceilingNotFree(X, Y + 2), not ceilingNotFree(X + 1, Y + 2), spawnedTetromino(2).

%maxRot0(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 2, 0)}, validPosition(X, Y, 2, 0).
%maxRot90(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 2, 1)}, validPosition(X, Y, 2, 1).
%maxRot180(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 2, 2)}, validPosition(X, Y, 2, 2).
%maxRot270(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 2, 3)}, validPosition(X, Y, 2, 3).
%
%bestPos(Y, X, 0) | notBestPos(Y, X, 0):- maxRot0(X, Y), maxRot90(X1, Y1), maxRot180(X2, Y2), maxRot270(X3, Y3), Y > Y1, Y >= Y2, Y > Y3, spawnedTetromino(2).
%bestPos(Y, X, 1) | notBestPos(Y, X, 1):- maxRot0(X1, Y1), maxRot90(X, Y), maxRot180(X2, Y2), maxRot270(X3, Y3), Y >= Y1, Y > Y2, Y > Y3, spawnedTetromino(2).
%bestPos(Y, X, 2) | notBestPos(Y, X, 2):- maxRot0(X1, Y1), maxRot90(X2, Y2), maxRot180(X, Y), maxRot270(X3, Y3), Y >= Y1, Y >= Y2, Y > Y3, spawnedTetromino(2).
%bestPos(Y, X, 3) | notBestPos(Y, X, 3):- maxRot0(X1, Y1), maxRot90(X2, Y2), maxRot180(X3, Y3), maxRot270(X, Y), Y >= Y1, Y >= Y2, Y >= Y3, spawnedTetromino(2).

%bestPos(Y, X, R) | nbestPos(Y, X, R):- validPosition(X, Y, 2, R).
%:~ bestPos(Y, X, R), Y1=19-Y, spawnedTetromino(2). [Y1@1, Y1, R]

%0
%Prefer the bestPos where the Tetromino takes up the most space next to it
:~ bestPos(Y, X, R), checkCellBusy(X+1, Y+1), checkCellBusy(X+2, Y+1), spawnedTetromino(2), R=0. [13@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X+1, Y+1), checkCellBusy(X+2, Y+1), spawnedTetromino(2), R=0. [14@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X+1 ,Y+1), checkCell    (X+2, Y+1), spawnedTetromino(2), R=0. [15@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X+1, Y+1), checkCell    (X+2, Y+1), spawnedTetromino(2), R=0. [16@0, Y, X, R]

%90
%Prefer the bestPos where the Tetromino takes up the most space next to it
:~ bestPos(Y, X, R), checkCellBusy(X, Y+1), checkCellBusy(X, Y+2), spawnedTetromino(2), R=1. [2@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X, Y+1), checkCell    (X, Y+2), spawnedTetromino(2), R=1. [3@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+1), checkCellBusy(X, Y+2), spawnedTetromino(2), R=1. [4@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+1), checkCell    (X, Y+2), spawnedTetromino(2), R=1. [12@0, Y, X, R]

%180
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, R), checkCellBusy(X, Y+2), checkCellBusy(X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(2), R=2. [0@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCellBusy(X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(2), R=2. [5@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X ,Y+2), checkCellBusy(X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(2), R=2. [6@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X ,Y+2), checkCell    (X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(2), R=2. [7@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X, Y+2), checkCell    (X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(2), R=2. [17@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCellBusy(X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(2), R=2. [18@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCell    (X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(2), R=2. [19@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCell    (X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(2), R=2. [8@0, Y, X, R]

%270
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, R), checkCellBusy(X, Y+3), checkCellBusy(X+1, Y+3), spawnedTetromino(2), R=3. [1@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X, Y+3), checkCell    (X+1, Y+3), spawnedTetromino(2), R=3. [9@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+3), checkCellBusy(X+1, Y+3), spawnedTetromino(2), R=3. [10@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+3), checkCell    (X+1, Y+3), spawnedTetromino(2), R=3. [11@0, Y, X, R]

% ##########################################################################################################################################################
% ##########################################################################################################################################################
% ##########################################################################################################################################################

%        0°                     90°                 180°                270°
%   ############                ####            ####                    ########
%   ############                ####            ####                    ########
%           ####    --->        ####    --->    ############    --->    ####
%           ####    --->        ####    --->    ############    --->    ####
%                           ########                                    ####
%                           ########                                    ####

%0
validPosition(X, Y, 0) :- checkCell(X, Y), checkCell(X + 1, Y), checkCell(X + 2, Y), checkCell(X + 2, Y + 1),         not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), not ceilingNotFree(X + 2, Y + 1), spawnedTetromino(3).
%90
validPosition(X, Y, 1) :- checkCell(X + 1, Y), checkCell(X + 1, Y + 1), checkCell(X + 1, Y + 2), checkCell(X, Y + 2), not ceilingNotFree(X, Y + 2), not ceilingNotFree(X + 1, Y + 2),  spawnedTetromino(3).
%180
validPosition(X, Y, 2) :- checkCell(X, Y), checkCell(X, Y + 1), checkCell(X + 1, Y + 1), checkCell(X + 2, Y + 1),     not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), not ceilingNotFree(X + 2, Y + 1), spawnedTetromino(3).
%270
validPosition(X, Y, 3) :- checkCell(X, Y), checkCell(X + 1, Y), checkCell(X, Y + 1), checkCell(X, Y + 2),             not ceilingNotFree(X, Y + 2), not ceilingNotFree(X + 1, Y + 1), spawnedTetromino(3).

%maxRot0(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 3, 0)}, validPosition(X, Y, 3, 0).
%maxRot90(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 3, 1)}, validPosition(X, Y, 3, 1).
%maxRot180(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 3, 2)}, validPosition(X, Y, 3, 2).
%maxRot270(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 3, 3)}, validPosition(X, Y, 3, 3).
%
%bestPos(Y, X, 0)  | notBestPos(Y, X, 0):- maxRot0(X, Y), maxRot90(X1, Y1), maxRot180(X2, Y2), maxRot270(X3, Y3), Y > Y1, Y > Y2, Y > Y3, spawnedTetromino(3).
%bestPos(Y, X, 1)  | notBestPos(Y, X, 1):- maxRot0(X1, Y1), maxRot90(X, Y), maxRot180(X2, Y2), maxRot270(X3, Y3), Y >= Y1, Y > Y2, Y >= Y3, spawnedTetromino(3).
%bestPos(Y, X, 2)  | notBestPos(Y, X, 2):- maxRot0(X1, Y1), maxRot90(X2, Y2), maxRot180(X, Y), maxRot270(X3, Y3), Y >= Y1, Y >= Y2, Y >= Y3, spawnedTetromino(3).
%bestPos(Y, X, 3)  | notBestPos(Y, X, 3):- maxRot0(X1, Y1), maxRot90(X2, Y2), maxRot180(X3, Y3), maxRot270(X, Y), Y >= Y1, Y > Y2, Y > Y3, spawnedTetromino(3).

%bestPos(Y, X, R) | nbestPos(Y, X, R):- validPosition(X, Y, 3, R).
%:~ bestPos(Y, X, R), Y1=19-Y, spawnedTetromino(3). [Y1@1, Y1, R]

%0
%Prefer the bestPos where the Tetromino takes up the most space next to it
:~ bestPos(Y, X, R), checkCellBusy(X, Y+1), checkCellBusy(X+1, Y+1), spawnedTetromino(3), R=0. [3@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+1), checkCellBusy(X+1, Y+1), spawnedTetromino(3), R=0. [13@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X ,Y+1), checkCell    (X+1, Y+1), spawnedTetromino(3), R=0. [14@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+1), checkCell    (X+1, Y+1), spawnedTetromino(3), R=0. [15@0, Y, X, R]

%90
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, R), checkCellBusy(X, Y+3), checkCellBusy(X+1, Y+3), spawnedTetromino(3), R=1. [1@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X, Y+3), checkCell    (X+1, Y+3), spawnedTetromino(3), R=1. [4@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+3), checkCellBusy(X+1, Y+3), spawnedTetromino(3), R=1. [5@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+3), checkCell    (X+1, Y+3), spawnedTetromino(3), R=1. [11@0, Y, X, R]

%180
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, R), checkCellBusy(X, Y+2), checkCellBusy(X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(3), R=2. [0@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCellBusy(X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(3), R=2. [8@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X ,Y+2), checkCell    (X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(3), R=2. [9@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X ,Y+2), checkCellBusy(X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(3), R=2. [10@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X, Y+2), checkCell    (X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(3), R=2. [16@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCellBusy(X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(3), R=2. [17@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCell    (X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(3), R=2. [18@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCell    (X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(3), R=2. [19@0, Y, X, R]

%270
%Prefer the bestPos where the Tetromino takes up the most space next to it
:~ bestPos(Y, X, R), checkCellBusy(X+1, Y+1), checkCellBusy(X+1, Y+2), spawnedTetromino(3), R=3. [2@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X+1, Y+1), checkCell    (X+1, Y+2), spawnedTetromino(3), R=3. [6@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X+1, Y+1), checkCellBusy(X+1, Y+2), spawnedTetromino(3), R=3. [7@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X+1, Y+1), checkCell    (X+1, Y+2), spawnedTetromino(3), R=3. [12@0, Y, X, R]

% ##########################################################################################################################################################
% ##########################################################################################################################################################
% ##########################################################################################################################################################

%      0°
%   ########
%   ########
%   ########
%   ########

%0
validPosition(X, Y, 0) :- checkCell(X, Y), checkCell(X + 1, Y), checkCell(X, Y + 1), checkCell(X + 1, Y + 1), not ceilingNotFree(X, Y+1), not ceilingNotFree(X+1, Y+1), spawnedTetromino(4).

%bestPos(Y, X, 0) | notBestPos(Y, X, 0) :- Y = #max{ Y1 : validPosition(_, Y1, 4, 0)}, validPosition(X, Y, 4, 0), spawnedTetromino(4).

%bestPos(Y, X, R) | nbestPos(Y, X, R):- validPosition(X, Y, 4, R).
%:~ bestPos(Y, X, R), Y1=19-Y, spawnedTetromino(4). [Y1@1, Y1, R]

%0
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, 0), checkCellBusy(X, Y+2), checkCellBusy(X+1, Y+2), spawnedTetromino(4). [0@0, Y, X]
:~ bestPos(Y, X, 0), checkCell    (X, Y+2), checkCellBusy(X+1, Y+2), spawnedTetromino(4). [1@0, Y, X]
:~ bestPos(Y, X, 0), checkCellBusy(X, Y+2), checkCell    (X+1, Y+2), spawnedTetromino(4). [2@0, Y, X]
:~ bestPos(Y, X, 0), checkCell    (X, Y+2), checkCell    (X+1, Y+2), spawnedTetromino(4). [3@0, Y, X]

% ##########################################################################################################################################################
% ##########################################################################################################################################################
% ##########################################################################################################################################################

%          0°                 90°
%   ########                    ####
%   ########                    ####
%       ########    --->    ########
%       ########    --->    ########
%                           ####
%                           ####


%0
validPosition(X, Y, 0) :- checkCell(X, Y), checkCell(X + 1, Y), checkCell(X + 1, Y + 1), checkCell(X + 2, Y + 1), not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), not ceilingNotFree(X + 2, Y + 1), spawnedTetromino(5).
%90
validPosition(X, Y, 1) :- checkCell(X + 1, Y), checkCell(X, Y + 1), checkCell(X + 1, Y + 1), checkCell(X, Y + 2), not ceilingNotFree(X, Y + 2), not ceilingNotFree(X + 1, Y + 2), spawnedTetromino(5).

%maxRot0(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 5, 0)}, validPosition(X, Y, 5, 0).
%maxRot90(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 5, 1)}, validPosition(X, Y, 5, 1).
%
%bestPos(Y, X, 0) | notBestPos(Y, X, 0):- maxRot0(X, Y), maxRot90(X1, Y1), Y > Y1, spawnedTetromino(5).
%bestPos(Y, X, 1) | notBestPos(Y, X, 1):- maxRot0(X1, Y1), maxRot90(X, Y), Y >= Y1, spawnedTetromino(5).

%bestPos(Y, X, R) | nbestPos(Y, X, R):- validPosition(X, Y, 5, R).
%:~ bestPos(Y, X, R), Y1=19-Y, spawnedTetromino(5). [Y1@1, Y1, R]

%0
%Prefer the bestPos where the Tetromino takes up the most space next to it
:~ bestPos(Y, X, R), checkCellBusy(X, Y+1), spawnedTetromino(5), R=0. [2@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+1), spawnedTetromino(5), R=0. [3@0, Y, X, R]

%90
%Prefer the bestPos where the Tetromino takes up the most space next to it
:~ bestPos(Y, X, R), checkCellBusy(X+1, Y+2), spawnedTetromino(5), R=1. [0@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X+1, Y+2), spawnedTetromino(5), R=1. [1@0, Y, X, R]

% ##########################################################################################################################################################
% ##########################################################################################################################################################
% ##########################################################################################################################################################

%          0°                 90°
%       ########            ####
%       ########            ####
%   ########        --->    ########
%   ########        --->    ########
%                               ####
%                               ####


%0
validPosition(X, Y, 0) :- checkCell(X + 1, Y), checkCell(X + 2, Y), checkCell(X, Y + 1)    , checkCell(X + 1, Y + 1), not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), not ceilingNotFree(X + 2, Y + 1), spawnedTetromino(6).
%90
validPosition(X, Y, 1) :- checkCell(X, Y)    , checkCell(X, Y + 1), checkCell(X + 1, Y + 1), checkCell(X + 1, Y + 2), not ceilingNotFree(X, Y + 2), not ceilingNotFree(X + 1, Y + 2), spawnedTetromino(6).

%maxRot0(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 6, 0)}, validPosition(X, Y, 6, 0).
%maxRot90(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 6, 1)}, validPosition(X, Y, 6, 1).
%
%bestPos(Y, X, 0) | notBestPos(Y, X, 0):- maxRot0(X, Y), maxRot90(X1, Y1), Y > Y1, spawnedTetromino(6).
%bestPos(Y, X, 1) | notBestPos(Y, X, 1):- maxRot0(X1, Y1), maxRot90(X, Y), Y >= Y1, spawnedTetromino(6).

%bestPos(Y, X, R) | nbestPos(Y, X, R):- validPosition(X, Y, 6, R).
%
%%:~ bestPos(Y, X, R), R1=1-R. [R1@0, Y, X, R]
%:~ bestPos(Y, X, R), Y1=19-Y, spawnedTetromino(6). [Y1@1, Y1, R]
%%:~ bestPos(Y, X, R), bestPos(Y, X, R1), Y1=19-Y, R>R1. [Y1-R1@1, Y1, X, R, R1]

%0
%Prefer the bestPos where the Tetromino takes up the most space next to it
:~ bestPos(Y, X, R), checkCellBusy(X+2, Y+1), spawnedTetromino(6), R=0. [2@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X+2, Y+1), spawnedTetromino(6), R=0. [3@0, Y, X, R]

%90
%Prefer the bestPos where the Tetromino takes up the most space next to it
:~ bestPos(Y, X, R), checkCellBusy(X, Y+2), spawnedTetromino(6), R=1. [0@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), spawnedTetromino(6), R=1. [1@0, Y, X, R]

% default cost for all tetromino
%:~ bestPos(Y, X, R). [1@10, Y, X, R]
