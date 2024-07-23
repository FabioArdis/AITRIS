
% ######################################################################################################################

% INTRODUCTION

% The program MUST receive in input:
% - at least a single upper row of busy cells to work, but to run optimally, it needs to receive two upper rows.
%   to take into consideration more than two upper rows is uselessly resource intensive.
% - a spawnedTetromino with a value (its type) ranging from 0 to 6

% The program searches for the 'best' (optimal) position for the current Tetromino.
% The BestPosition has three parameters: Y and X coords and the number of rotation steps needed.

% spawnedTetromino's value range and the associated tetromino shapes:
% 0 - I
% 1 - T
% 2 - L
% 3 - J
% 4 - Cube
% 5 - Z
% 6 - S

% Weak constraints' layers:
% Level 0            :- Associated with best-case rotations. Top priority, can impose over height priority.
% Level 1            :- Used in niche cases where rotation and height don't matter in the reasoning
% Level 2 or greater :- Associated with height, has the lowest priority

% Reasoning bias order:

% Best-case rotation (might have a worst height than other choices, but it's always a better choice overall) >
% Niche case where rotation and height don't matter >
% Proceeds as usual and takes the best height with the best rotation.

% ######################################################################################################################

% ASP PROGRAM START

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

% Define if ceiling isn't free
ceilingNotFree(X, Y) :- ceiling(Y1, Y), busyCell(X,Y1), Y<>Y1.

% The reasoning can choose exactly a single position.
:- #count{Y, X, R: bestPos(Y, X, R)} <> 1. %>

% Choose a position
bestPos(Y, X, R) | nbestPos(Y, X, R):- validPosition(X, Y, R).

% Choose the lowest possible position
:~ bestPos(Y, X, R), Y1=19-Y. [Y1@1, Y1, R]

% ######################################################################################################################
% ######################################################################################################################
% ######################################################################################################################

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
validPosition(X, Y, 1) :- checkCell(X, Y), checkCell(X, Y - 1), checkCell(X, Y - 2), checkCell(X, Y-3), not ceilingNotFree(X, Y), spawnedTetromino(0).

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

%90. Prefer the position closest to the border of the map
:~ bestPos(Y, X, R), spawnedTetromino(0), R=1, X<5. [X@0, Y, X]
:~ bestPos(Y, X, R), spawnedTetromino(0), R=1, X>=5. [9-X@0, Y, X]
% Why? We don't want the I-shaped tetromino to be put in the middle of a row. It's not optimal.

% ######################################################################################################################
% ######################################################################################################################
% ######################################################################################################################

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

%0
%Prefer the bestPos where the Tetromino takes up the most space next to it
:~ bestPos(Y, X, R), checkCellBusy(X, Y+1), checkCellBusy(X+2, Y+1), spawnedTetromino(1), R=0. [3@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+1), checkCellBusy(X+2, Y+1), spawnedTetromino(1), R=0. [9@3, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X ,Y+1), checkCell    (X+2, Y+1), spawnedTetromino(1), R=0. [10@3, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+1), checkCell    (X+2, Y+1), spawnedTetromino(1), R=0. [11@3, Y, X, R]

%90
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, R), checkCellBusy(X, Y+2), spawnedTetromino(1), R=1. [2@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), spawnedTetromino(1), R=1. [7@0, Y, X, R]

%180
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, R), checkCellBusy(X, Y+2), checkCellBusy(X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(1), R=2. [0@3, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCellBusy(X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(1), R=2. [4@3, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X ,Y+2), checkCell    (X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(1), R=2. [5@3, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X ,Y+2), checkCellBusy(X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(1), R=2. [6@3, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X, Y+2), checkCell    (X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(1), R=2. [12@3, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCellBusy(X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(1), R=2. [13@3, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCell    (X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(1), R=2. [14@3, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCell    (X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(1), R=2. [15@3, Y, X, R]

%270
%Prefer the bestPos where the Tetromino takes up the most space next to it
:~ bestPos(Y, X, R), checkCellBusy(X+1, Y+2), spawnedTetromino(1), R=3. [1@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X+1, Y+2), spawnedTetromino(1), R=3. [8@0, Y, X, R]

% ######################################################################################################################
% ######################################################################################################################
% ######################################################################################################################

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

%0
%Prefer the bestPos where the Tetromino takes up the most space next to it
:~ bestPos(Y, X, R), checkCellBusy(X+1, Y+1), checkCellBusy(X+2, Y+1), spawnedTetromino(2), R=0. [13@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X+1, Y+1), checkCellBusy(X+2, Y+1), spawnedTetromino(2), R=0. [14@3, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X+1 ,Y+1), checkCell    (X+2, Y+1), spawnedTetromino(2), R=0. [15@3, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X+1, Y+1), checkCell    (X+2, Y+1), spawnedTetromino(2), R=0. [16@3, Y, X, R]

%90
%Prefer the bestPos where the Tetromino takes up the most space next to it
:~ bestPos(Y, X, R), checkCellBusy(X, Y+1), checkCellBusy(X, Y+2), spawnedTetromino(2), R=1. [2@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X, Y+1), checkCell    (X, Y+2), spawnedTetromino(2), R=1. [3@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+1), checkCellBusy(X, Y+2), spawnedTetromino(2), R=1. [4@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+1), checkCell    (X, Y+2), spawnedTetromino(2), R=1. [12@0, Y, X, R]

%180
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, R), checkCellBusy(X, Y+2), checkCellBusy(X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(2), R=2. [0@3, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCellBusy(X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(2), R=2. [5@3, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X ,Y+2), checkCellBusy(X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(2), R=2. [6@3, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X ,Y+2), checkCell    (X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(2), R=2. [7@3, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X, Y+2), checkCell    (X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(2), R=2. [17@3, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCellBusy(X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(2), R=2. [18@3, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCell    (X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(2), R=2. [19@3, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCell    (X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(2), R=2. [8@3, Y, X, R]

%270
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, R), checkCellBusy(X, Y+3), checkCellBusy(X+1, Y+3), spawnedTetromino(2), R=3. [1@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X, Y+3), checkCell    (X+1, Y+3), spawnedTetromino(2), R=3. [9@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+3), checkCellBusy(X+1, Y+3), spawnedTetromino(2), R=3. [10@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+3), checkCell    (X+1, Y+3), spawnedTetromino(2), R=3. [11@0, Y, X, R]

% ######################################################################################################################
% ######################################################################################################################
% ######################################################################################################################

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

%0
%Prefer the bestPos where the Tetromino takes up the most space next to it
:~ bestPos(Y, X, R), checkCellBusy(X, Y+1), checkCellBusy(X+1, Y+1), spawnedTetromino(3), R=0. [3@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+1), checkCellBusy(X+1, Y+1), spawnedTetromino(3), R=0. [13@3, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X ,Y+1), checkCell    (X+1, Y+1), spawnedTetromino(3), R=0. [14@3, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+1), checkCell    (X+1, Y+1), spawnedTetromino(3), R=0. [15@3, Y, X, R]

%90
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, R), checkCellBusy(X, Y+3), checkCellBusy(X+1, Y+3), spawnedTetromino(3), R=1. [1@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X, Y+3), checkCell    (X+1, Y+3), spawnedTetromino(3), R=1. [4@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+3), checkCellBusy(X+1, Y+3), spawnedTetromino(3), R=1. [5@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+3), checkCell    (X+1, Y+3), spawnedTetromino(3), R=1. [11@0, Y, X, R]

%180
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, R), checkCellBusy(X, Y+2), checkCellBusy(X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(3), R=2. [0@3, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCellBusy(X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(3), R=2. [8@3, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X ,Y+2), checkCell    (X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(3), R=2. [9@3, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X ,Y+2), checkCellBusy(X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(3), R=2. [10@3, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X, Y+2), checkCell    (X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(3), R=2. [16@3, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCellBusy(X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(3), R=2. [17@3, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCell    (X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(3), R=2. [18@3, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCell    (X+1, Y+2), checkCell    (X+2, Y+2), spawnedTetromino(3), R=2. [19@3, Y, X, R]

%270
%Prefer the bestPos where the Tetromino takes up the most space next to it
:~ bestPos(Y, X, R), checkCellBusy(X+1, Y+1), checkCellBusy(X+1, Y+2), spawnedTetromino(3), R=3. [2@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X+1, Y+1), checkCell    (X+1, Y+2), spawnedTetromino(3), R=3. [6@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X+1, Y+1), checkCellBusy(X+1, Y+2), spawnedTetromino(3), R=3. [7@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X+1, Y+1), checkCell    (X+1, Y+2), spawnedTetromino(3), R=3. [12@0, Y, X, R]

% ######################################################################################################################
% ######################################################################################################################
% ######################################################################################################################

%      0°
%   ########
%   ########
%   ########
%   ########

%0
validPosition(X, Y, 0) :- checkCell(X, Y), checkCell(X + 1, Y), checkCell(X, Y + 1), checkCell(X + 1, Y + 1), not ceilingNotFree(X, Y+1), not ceilingNotFree(X+1, Y+1), spawnedTetromino(4).

%0
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, 0), checkCellBusy(X, Y+2), checkCellBusy(X+1, Y+2), spawnedTetromino(4). [0@0, Y, X]
:~ bestPos(Y, X, 0), checkCell    (X, Y+2), checkCellBusy(X+1, Y+2), spawnedTetromino(4). [2@1, Y, X]
:~ bestPos(Y, X, 0), checkCellBusy(X, Y+2), checkCell    (X+1, Y+2), spawnedTetromino(4). [3@1, Y, X]
:~ bestPos(Y, X, 0), checkCell    (X, Y+2), checkCell    (X+1, Y+2), spawnedTetromino(4). [4@1, Y, X]

% ######################################################################################################################
% ######################################################################################################################
% ######################################################################################################################

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

%0
%Prefer the bestPos where the Tetromino takes up the most space next to it
:~ bestPos(Y, X, R), checkCellBusy(X, Y+1), spawnedTetromino(5), R=0. [1@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+1), spawnedTetromino(5), R=0. [2@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X+1, Y+2), checkCell   (X+2, Y+2), spawnedTetromino(5), R=0. [2@3, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), spawnedTetromino(5), R=0. [3@3, Y, X, R]

%90
%Prefer the bestPos where the Tetromino takes up the most space next to it
:~ bestPos(Y, X, R), checkCellBusy(X+1, Y+2), spawnedTetromino(5), R=1. [0@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X+1, Y+2), spawnedTetromino(5), R=1. [3@0, Y, X, R]
:~ bestPos(Y, X, R), checkCellBusy(X, Y+3), spawnedTetromino(5), R=1. [0@3, Y, X, R]

% ######################################################################################################################
% ######################################################################################################################
% ######################################################################################################################

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

%0
%Prefer the bestPos where the Tetromino takes up the most space next to it
:~ bestPos(Y, X, R), checkCellBusy(X+2, Y+1), spawnedTetromino(6), R=0. [1@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X+2, Y+1), spawnedTetromino(6), R=0. [2@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), checkCell   (X+1, Y+2), spawnedTetromino(6), R=0. [2@3, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), spawnedTetromino(6), R=0. [3@3, Y, X, R]

%90
%Prefer the bestPos where the Tetromino takes up the most space next to it
:~ bestPos(Y, X, R), checkCellBusy(X, Y+2), spawnedTetromino(6), R=1. [0@0, Y, X, R]
:~ bestPos(Y, X, R), checkCell    (X, Y+2), spawnedTetromino(6), R=1. [3@0, Y, X, R]

% ASP PROGRAM END

% ######################################################################################################################