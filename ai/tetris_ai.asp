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

% Define if ceiling ain''t free
ceilingNotFree(X, Y) :- ceiling(Y1, Y), busyCell(X,Y1), Y<>Y1.

% Can't be a location isn't chosen
:- #count{Y : bestPos(_, Y, _)} != 1.

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
validPosition(X, Y, 0, 0) :- checkCell(X, Y), checkCell(X + 1, Y), checkCell(X + 2, Y), checkCell(X + 3, Y), not ceilingNotFree(X, Y), not ceilingNotFree(X + 1, Y), not ceilingNotFree(X + 2, Y), not ceilingNotFree(X + 3, Y), spawnedTetromino(0, _, _, _, _).
%90
validPosition(X, Y, 0, 1) :- checkCell(X, Y), checkCell(X, Y + 1), checkCell(X, Y + 2), checkCell(X, Y + 3), not ceilingNotFree(X, Y + 1), spawnedTetromino(0, _, _, _, _).

maxRot0(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 0, 0)}, validPosition(X, Y, 0, 0).
maxRot90(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 0, 1)}, validPosition(X, Y, 0, 1).

bestPos(Y, X, 0) | notBestPos(Y, X, 0):- maxRot0(X, Y), maxRot90(X1, Y1), Y > Y1, spawnedTetromino(0, _, _, _, _).
bestPos(Y, X, 1) | notBestPos(Y, X, 1):- maxRot0(X1, Y1), maxRot90(X, Y), Y >= Y1, spawnedTetromino(0, _, _, _, _).

%0
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, 0), checkCellBusy(X, Y+1), checkCellBusy(X+1, Y+1), checkCellBusy(X+2, Y+1), checkCellBusy(X+3, Y+1), spawnedTetromino(0, _, _, _, _). [1@0, Y, X]

:~ bestPos(Y, X, 0), checkCellBusy(X, Y+1), checkCellBusy(X+1, Y+1), checkCellBusy(X+2, Y+1), checkCell(X+3, Y+1),     spawnedTetromino(0, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 0), checkCellBusy(X, Y+1), checkCellBusy(X+1, Y+1), checkCell(X+2, Y+1),     checkCellBusy(X+3, Y+1), spawnedTetromino(0, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 0), checkCellBusy(X, Y+1), checkCell(X+1, Y+1),     checkCellBusy(X+2, Y+1), checkCellBusy(X+3, Y+1), spawnedTetromino(0, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 0), checkCell(X, Y+1),     checkCellBusy(X+1, Y+1), checkCellBusy(X+2, Y+1), checkCellBusy(X+3, Y+1), spawnedTetromino(0, _, _, _, _). [1@1, Y, X]

:~ bestPos(Y, X, 0), checkCellBusy(X, Y+1), checkCellBusy(X+1, Y+1), checkCell(X+2, Y+1),     checkCell(X+3, Y+1),     spawnedTetromino(0, _, _, _, _). [1@2, Y, X]
:~ bestPos(Y, X, 0), checkCellBusy(X, Y+1), checkCell(X+1, Y+1),     checkCellBusy(X+2, Y+1), checkCell(X+3, Y+1),     spawnedTetromino(0, _, _, _, _). [1@2, Y, X]
:~ bestPos(Y, X, 0), checkCellBusy(X, Y+1), checkCell(X+1, Y+1),     checkCell(X+2, Y+1),     checkCellBusy(X+3, Y+1), spawnedTetromino(0, _, _, _, _). [1@2, Y, X]
:~ bestPos(Y, X, 0), checkCell(X, Y+1),     checkCellBusy(X+1, Y+1), checkCell(X+2, Y+1),     checkCellBusy(X+3, Y+1), spawnedTetromino(0, _, _, _, _). [1@2, Y, X]
:~ bestPos(Y, X, 0), checkCell(X, Y+1),     checkCell(X+1, Y+1),     checkCellBusy(X+2, Y+1), checkCellBusy(X+3, Y+1), spawnedTetromino(0, _, _, _, _). [1@2, Y, X]
:~ bestPos(Y, X, 0), checkCell(X, Y+1),     checkCellBusy(X+1, Y+1), checkCellBusy(X+2, Y+1), checkCell(X+3, Y+1),     spawnedTetromino(0, _, _, _, _). [1@2, Y, X]

:~ bestPos(Y, X, 0), checkCell(X, Y+1),     checkCell(X+1, Y+1),     checkCell(X+2, Y+1),     checkCellBusy(X+3, Y+1), spawnedTetromino(0, _, _, _, _). [1@3, Y, X]
:~ bestPos(Y, X, 0), checkCell(X, Y+1),     checkCell(X+1, Y+1),     checkCellBusy(X+2, Y+1), checkCell(X+3, Y+1),     spawnedTetromino(0, _, _, _, _). [1@3, Y, X]
:~ bestPos(Y, X, 0), checkCell(X, Y+1),     checkCellBusy(X+1, Y+1), checkCell(X+2, Y+1),     checkCell(X+3, Y+1),     spawnedTetromino(0, _, _, _, _). [1@3, Y, X]
:~ bestPos(Y, X, 0), checkCellBusy(X, Y+1), checkCell(X+1, Y+1),     checkCell(X+2, Y+1),     checkCell(X+3, Y+1),     spawnedTetromino(0, _, _, _, _). [1@3, Y, X]

:~ bestPos(Y, X, 0), checkCell(X, Y+1), checkCell(X+1, Y+1), checkCell(X+2, Y+1), checkCell(X+3, Y+1), spawnedTetromino(0, _, _, _, _). [1@4, Y, X]

:~ bestPos(Y, X, 1), spawnedTetromino(0, _, _, _, _). [1@0, Y, X]

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
validPosition(X, Y, 1, 0) :- checkCell(X, Y), checkCell(X + 1, Y), checkCell(X + 2, Y), checkCell(X + 1, Y + 1),         not ceilingNotFree(X, Y + 1),  not ceilingNotFree(X + 1, Y + 1), not ceilingNotFree(X + 2, Y + 1), spawnedTetromino(1, _, _, _,  _, _, _).
%90
validPosition(X, Y, 1, 1) :- checkCell(X + 1, Y), checkCell(X + 1, Y + 1), checkCell(X + 1, Y + 2), checkCell(X, Y + 1), not ceilingNotFree(X, Y + 2),  not ceilingNotFree(X + 1, Y + 2), spawnedTetromino(1, _, _, _,  _, _, _).
%180
validPosition(X, Y, 1, 2) :- checkCell(X, Y + 1), checkCell(X + 1, Y + 1), checkCell(X + 2, Y + 1), checkCell(X + 1, Y), not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), not ceilingNotFree(X + 2, Y + 1), spawnedTetromino(1, _, _, _,  _, _, _).
%270
validPosition(X, Y, 1, 3) :- checkCell(X, Y), checkCell(X, Y + 1), checkCell(X, Y + 2), checkCell(X + 1, Y + 1),         not ceilingNotFree(X, Y + 2), not ceilingNotFree(X + 1, Y + 2), spawnedTetromino(1, _, _, _,  _, _, _).

maxRot0(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 1, 0)}, validPosition(X, Y, 1, 0).
maxRot90(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 1, 1)}, validPosition(X, Y, 1, 1).
maxRot180(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 1, 2)}, validPosition(X, Y, 1, 2).
maxRot270(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 1, 3)}, validPosition(X, Y, 1, 3).

bestPos(Y, X, 0) | notBestPos(Y, X, 0):- maxRot0(X, Y), maxRot90(X1, Y1), maxRot180(X2, Y2), maxRot270(X3, Y3), Y > Y1, Y > Y2, Y > Y3, spawnedTetromino(1, _, _, _,  _, _, _).
bestPos(Y, X, 1) | notBestPos(Y, X, 1):- maxRot0(X1, Y1), maxRot90(X, Y), maxRot180(X2, Y2), maxRot270(X3, Y3), Y >= Y1, Y >= Y2, Y >= Y3, spawnedTetromino(1, _, _, _,  _, _, _).
bestPos(Y, X, 2) | notBestPos(Y, X, 2):- maxRot0(X1, Y1), maxRot90(X2, Y2), maxRot180(X, Y), maxRot270(X3, Y3), Y >= Y1, Y > Y2, Y > Y3, spawnedTetromino(1, _, _, _,  _, _, _).
bestPos(Y, X, 3) | notBestPos(Y, X, 3):- maxRot0(X1, Y1), maxRot90(X2, Y2), maxRot180(X3, Y3), maxRot270(X, Y), Y >= Y1, Y > Y2, Y >= Y3, spawnedTetromino(1, _, _, _,  _, _, _).

%0
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, 0), checkCellBusy(X, Y+1), checkCellBusy(X+2, Y+1), spawnedTetromino(1, _, _, _, _, _, _). [1@0, Y, X]
:~ bestPos(Y, X, 0), checkCell(X, Y+1)    , checkCellBusy(X+2, Y+1), spawnedTetromino(1, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 0), checkCellBusy(X ,Y+1), checkCell(X+2, Y+1)    , spawnedTetromino(1, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 0), checkCell(X, Y+1)    , checkCell(X+2, Y+1)    , spawnedTetromino(1, _, _, _, _, _, _). [1@2, Y, X]

%90
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, 1), checkCellBusy(X, Y+2), checkCell(X+1, Y+2), spawnedTetromino(1, _, _, _, _, _, _). [1@0, Y, X]
:~ bestPos(Y, X, 1), checkCell(X, Y+2)    , checkCell(X+1, Y+2), spawnedTetromino(1, _, _, _, _, _, _). [1@1, Y, X]

%180
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, 2), checkCellBusy(X, Y+2), checkCellBusy(X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(1, _, _, _, _, _, _). [1@0, Y, X]
:~ bestPos(Y, X, 2), checkCell(X, Y+2)    , checkCellBusy(X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(1, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 2), checkCellBusy(X ,Y+2), checkCell(X+1, Y+2),     checkCellBusy(X+2, Y+2), spawnedTetromino(1, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 2), checkCellBusy(X ,Y+2), checkCellBusy(X+1, Y+2), checkCell(X+2, Y+2)    , spawnedTetromino(1, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 2), checkCell(X, Y+2)    , checkCell(X+1, Y+2),     checkCell(X+2, Y+2)    , spawnedTetromino(1, _, _, _, _, _, _). [1@2, Y, X]

%270
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, 3), checkCell(X, Y+2),     checkCellBusy(X+1, Y+2), spawnedTetromino(1, _, _, _, _, _, _). [1@0, Y, X]
:~ bestPos(Y, X, 3), checkCell(X, Y+2)    , checkCell(X+1, Y+2)    , spawnedTetromino(1, _, _, _, _, _, _). [1@1, Y, X]

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
validPosition(X, Y, 2, 0) :- checkCell(X, Y), checkCell(X + 1, Y), checkCell(X + 2, Y), checkCell(X, Y + 1),             not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), not ceilingNotFree(X + 2, Y + 1), spawnedTetromino(2, _, _, _,  _, _, _).
%90
validPosition(X, Y, 2, 1) :- checkCell(X, Y), checkCell(X + 1, Y), checkCell(X + 1, Y + 1), checkCell(X + 1, Y + 2),     not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 2), spawnedTetromino(2, _, _, _,  _, _, _).
%180
validPosition(X, Y, 2, 2) :- checkCell(X, Y + 1), checkCell(X + 1, Y + 1), checkCell(X + 2, Y + 1), checkCell(X + 2, Y), not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), not ceilingNotFree(X + 2, Y + 1), spawnedTetromino(2, _, _, _,  _, _, _).
%270
validPosition(X, Y, 2, 3) :- checkCell(X, Y), checkCell(X, Y + 1), checkCell(X, Y + 2), checkCell(X + 1, Y + 2),         not ceilingNotFree(X, Y + 2), not ceilingNotFree(X + 1, Y + 2), spawnedTetromino(2, _, _, _,  _, _, _).

maxRot0(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 2, 0)}, validPosition(X, Y, 2, 0).
maxRot90(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 2, 1)}, validPosition(X, Y, 2, 1).
maxRot180(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 2, 2)}, validPosition(X, Y, 2, 2).
maxRot270(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 2, 3)}, validPosition(X, Y, 2, 3).

bestPos(Y, X, 0) | notBestPos(Y, X, 0):- maxRot0(X, Y), maxRot90(X1, Y1), maxRot180(X2, Y2), maxRot270(X3, Y3), Y > Y1, Y >= Y2, Y > Y3, spawnedTetromino(2, _, _, _,  _, _, _).
bestPos(Y, X, 1) | notBestPos(Y, X, 1):- maxRot0(X1, Y1), maxRot90(X, Y), maxRot180(X2, Y2), maxRot270(X3, Y3), Y >= Y1, Y > Y2, Y > Y3, spawnedTetromino(2, _, _, _,  _, _, _).
bestPos(Y, X, 2) | notBestPos(Y, X, 2):- maxRot0(X1, Y1), maxRot90(X2, Y2), maxRot180(X, Y), maxRot270(X3, Y3), Y >= Y1, Y >= Y2, Y > Y3, spawnedTetromino(2, _, _, _,  _, _, _).
bestPos(Y, X, 3) | notBestPos(Y, X, 3):- maxRot0(X1, Y1), maxRot90(X2, Y2), maxRot180(X3, Y3), maxRot270(X, Y), Y >= Y1, Y >= Y2, Y >= Y3, spawnedTetromino(2, _, _, _,  _, _, _).

%0
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, 0), checkCellBusy(X+1, Y+1), checkCellBusy(X+2, Y+1), spawnedTetromino(2, _, _, _, _, _, _). [1@0, Y, X]
:~ bestPos(Y, X, 0), checkCell(X+1, Y+1)    , checkCellBusy(X+2, Y+1), spawnedTetromino(2, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 0), checkCellBusy(X+1 ,Y+1), checkCell(X+2, Y+1)    , spawnedTetromino(2, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 0), checkCell(X+1, Y+1)    , checkCell(X+2, Y+1)    , spawnedTetromino(2, _, _, _, _, _, _). [1@2, Y, X]

%90
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, 1), checkCellBusy(X, Y+1), checkCellBusy(X, Y+2), spawnedTetromino(2, _, _, _, _, _, _). [1@0, Y, X]
:~ bestPos(Y, X, 1), checkCellBusy(X, Y+1), checkCell(X, Y+2),     spawnedTetromino(2, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 1), checkCell(X, Y+1),     checkCellBusy(X, Y+2), spawnedTetromino(2, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 1), checkCell(X, Y+1),     checkCell(X, Y+2)    , spawnedTetromino(2, _, _, _, _, _, _). [1@2, Y, X]

%180
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, 2), checkCellBusy(X, Y+2), checkCellBusy(X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(2, _, _, _, _, _, _). [1@0, Y, X]
:~ bestPos(Y, X, 2), checkCell(X, Y+2)    , checkCellBusy(X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(2, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 2), checkCellBusy(X ,Y+2), checkCell(X+1, Y+2),     checkCellBusy(X+2, Y+2), spawnedTetromino(2, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 2), checkCellBusy(X ,Y+2), checkCellBusy(X+1, Y+2), checkCell(X+2, Y+2)    , spawnedTetromino(2, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 2), checkCell(X, Y+2)    , checkCell(X+1, Y+2),     checkCell(X+2, Y+2)    , spawnedTetromino(2, _, _, _, _, _, _). [1@2, Y, X]

%270
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, 3), checkCellBusy(X, Y+3), checkCellBusy(X+1, Y+3), spawnedTetromino(2, _, _, _, _, _, _). [1@0, Y, X]
:~ bestPos(Y, X, 3), checkCellBusy(X, Y+3), checkCell(X+1, Y+3),     spawnedTetromino(2, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 3), checkCell(X, Y+3),     checkCellBusy(X+1, Y+3), spawnedTetromino(2, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 3), checkCell(X, Y+3),     checkCell(X+1, Y+3)    , spawnedTetromino(2, _, _, _, _, _, _). [1@2, Y, X]

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
validPosition(X, Y, 3, 0) :- checkCell(X, Y), checkCell(X + 1, Y), checkCell(X + 2, Y), checkCell(X + 2, Y + 1),         not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), not ceilingNotFree(X + 2, Y + 1), spawnedTetromino(3, _, _, _,  _, _, _).
%90
validPosition(X, Y, 3, 1) :- checkCell(X + 1, Y), checkCell(X + 1, Y + 1), checkCell(X + 1, Y + 2), checkCell(X, Y + 2), not ceilingNotFree(X, Y + 2), not ceilingNotFree(X + 1, Y + 2),  spawnedTetromino(3, _, _, _,  _, _, _).
%180
validPosition(X, Y, 3, 2) :- checkCell(X, Y), checkCell(X, Y + 1), checkCell(X + 1, Y + 1), checkCell(X + 2, Y + 1),     not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), not ceilingNotFree(X + 2, Y + 1), spawnedTetromino(3, _, _, _,  _, _, _).
%270
validPosition(X, Y, 3, 3) :- checkCell(X, Y), checkCell(X + 1, Y), checkCell(X, Y + 1), checkCell(X, Y + 2),             not ceilingNotFree(X, Y + 2), not ceilingNotFree(X + 1, Y + 1), spawnedTetromino(3, _, _, _,  _, _, _).

maxRot0(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 3, 0)}, validPosition(X, Y, 3, 0).
maxRot90(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 3, 1)}, validPosition(X, Y, 3, 1).
maxRot180(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 3, 2)}, validPosition(X, Y, 3, 2).
maxRot270(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 3, 3)}, validPosition(X, Y, 3, 3).

bestPos(Y, X, 0)  | notBestPos(Y, X, 0):- maxRot0(X, Y), maxRot90(X1, Y1), maxRot180(X2, Y2), maxRot270(X3, Y3), Y > Y1, Y > Y2, Y > Y3, spawnedTetromino(3, _, _, _,  _, _, _).
bestPos(Y, X, 1)  | notBestPos(Y, X, 1):- maxRot0(X1, Y1), maxRot90(X, Y), maxRot180(X2, Y2), maxRot270(X3, Y3), Y >= Y1, Y > Y2, Y >= Y3, spawnedTetromino(3, _, _, _,  _, _, _).
bestPos(Y, X, 2)  | notBestPos(Y, X, 2):- maxRot0(X1, Y1), maxRot90(X2, Y2), maxRot180(X, Y), maxRot270(X3, Y3), Y >= Y1, Y >= Y2, Y >= Y3, spawnedTetromino(3, _, _, _,  _, _, _).
bestPos(Y, X, 3)  | notBestPos(Y, X, 3):- maxRot0(X1, Y1), maxRot90(X2, Y2), maxRot180(X3, Y3), maxRot270(X, Y), Y >= Y1, Y > Y2, Y > Y3, spawnedTetromino(3, _, _, _,  _, _, _).

%0
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, 0), checkCellBusy(X, Y+1), checkCellBusy(X+1, Y+1), spawnedTetromino(3, _, _, _, _, _, _). [1@0, Y, X]
:~ bestPos(Y, X, 0), checkCell(X, Y+1)    , checkCellBusy(X+1, Y+1), spawnedTetromino(3, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 0), checkCellBusy(X ,Y+1), checkCell(X+1, Y+1)    , spawnedTetromino(3, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 0), checkCell(X, Y+1)    , checkCell(X+1, Y+1)    , spawnedTetromino(3, _, _, _, _, _, _). [1@2, Y, X]

%90
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, 1), checkCellBusy(X, Y+3), checkCellBusy(X+1, Y+3), spawnedTetromino(3, _, _, _, _, _, _). [1@0, Y, X]
:~ bestPos(Y, X, 1), checkCellBusy(X, Y+3), checkCell(X+1, Y+3),     spawnedTetromino(3, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 1), checkCell(X, Y+3),     checkCellBusy(X+1, Y+3), spawnedTetromino(3, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 1), checkCell(X, Y+3),     checkCell(X+1, Y+3)    , spawnedTetromino(3, _, _, _, _, _, _). [1@2, Y, X]

%180
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, 2), checkCellBusy(X, Y+2), checkCellBusy(X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(3, _, _, _, _, _, _). [1@0, Y, X]
:~ bestPos(Y, X, 2), checkCell(X, Y+2)    , checkCellBusy(X+1, Y+2), checkCellBusy(X+2, Y+2), spawnedTetromino(3, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 2), checkCellBusy(X ,Y+2), checkCell(X+1, Y+2),     checkCellBusy(X+2, Y+2), spawnedTetromino(3, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 2), checkCellBusy(X ,Y+2), checkCellBusy(X+1, Y+2), checkCell(X+2, Y+2)    , spawnedTetromino(3, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 2), checkCell(X, Y+2)    , checkCell(X+1, Y+2),     checkCell(X+2, Y+2)    , spawnedTetromino(3, _, _, _, _, _, _). [1@2, Y, X]

%270
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, 3), checkCellBusy(X+1, Y+1), checkCellBusy(X+1, Y+2), spawnedTetromino(3, _, _, _, _, _, _). [1@0, Y, X]
:~ bestPos(Y, X, 3), checkCellBusy(X+1, Y+1), checkCell(X+1, Y+2),     spawnedTetromino(3, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 3), checkCell(X+1, Y+1),     checkCellBusy(X+1, Y+2), spawnedTetromino(3, _, _, _, _, _, _). [1@1, Y, X]
:~ bestPos(Y, X, 3), checkCell(X+1, Y+1),     checkCell(X+1, Y+2)    , spawnedTetromino(3, _, _, _, _, _, _). [1@2, Y, X]

% ##########################################################################################################################################################
% ##########################################################################################################################################################
% ##########################################################################################################################################################

%      0°
%   ########
%   ########
%   ########
%   ########

%0
validPosition(X, Y, 4, 0) :- checkCell(X, Y), checkCell(X + 1, Y), checkCell(X, Y + 1), checkCell(X + 1, Y + 1), not ceilingNotFree(X, Y+1), not ceilingNotFree(X+1, Y+1), spawnedTetromino(4, _, _, _, _).

bestPos(Y, X, 0) | notBestPos(Y, X, 0) :- Y = #max{ Y1 : validPosition(_, Y1, 4, 0)}, validPosition(X, Y, 4, 0), spawnedTetromino(4, _, _, _, _).

%0
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, 0), checkCellBusy(X, Y+2), checkCellBusy(X+1, Y+2), spawnedTetromino(4, _, _, _, _). [1@0, Y, X]
:~ bestPos(Y, X, 0), checkCell(X, Y+2),     checkCellBusy(X+1, Y+2), spawnedTetromino(4, _, _, _, _). [1@2, Y, X]
:~ bestPos(Y, X, 0), checkCellBusy(X, Y+2), checkCell(X+1, Y+2),     spawnedTetromino(4, _, _, _, _). [1@2, Y, X]
:~ bestPos(Y, X, 0), checkCell(X, Y+2),     checkCell(X+1, Y+2),     spawnedTetromino(4, _, _, _, _). [1@1, Y, X]

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
validPosition(X, Y, 5, 0) :- checkCell(X, Y), checkCell(X + 1, Y), checkCell(X + 1, Y + 1), checkCell(X + 2, Y + 1), not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), not ceilingNotFree(X + 2, Y + 1), spawnedTetromino(5, _, _, _,  _, _, _).
%90
validPosition(X, Y, 5, 1) :- checkCell(X + 1, Y), checkCell(X, Y + 1), checkCell(X + 1, Y + 1), checkCell(X, Y + 2), not ceilingNotFree(X, Y + 2), not ceilingNotFree(X + 1, Y + 2), spawnedTetromino(5, _, _, _,  _, _, _).

maxRot0(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 5, 0)}, validPosition(X, Y, 5, 0).
maxRot90(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 5, 1)}, validPosition(X, Y, 5, 1).

bestPos(Y, X, 0) | notBestPos(Y, X, 0):- maxRot0(X, Y), maxRot90(X1, Y1), Y > Y1, spawnedTetromino(5, _, _, _,  _, _, _).
bestPos(Y, X, 1) | notBestPos(Y, X, 1):- maxRot0(X1, Y1), maxRot90(X, Y), Y >= Y1, spawnedTetromino(5, _, _, _,  _, _, _).

%0
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, 0), checkCellBusy(X, Y+1), spawnedTetromino(5, _, _, _, _, _, _). [1@0, Y, X]
:~ bestPos(Y, X, 0), checkCell(X, Y+1)    , spawnedTetromino(5, _, _, _, _, _, _). [1@1, Y, X]

%90
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, 1), checkCellBusy(X+1, Y+2), spawnedTetromino(5, _, _, _, _, _, _). [1@0, Y, X]
:~ bestPos(Y, X, 1), checkCell(X+1, Y+2)    , spawnedTetromino(5, _, _, _, _, _, _). [1@1, Y, X]

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
validPosition(X, Y, 6, 0) :- checkCell(X + 1, Y), checkCell(X + 2, Y), checkCell(X, Y + 1), checkCell(X + 1, Y + 1), not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), not ceilingNotFree(X + 2, Y + 1), spawnedTetromino(6, _, _, _,  _, _, _).
%90
validPosition(X, Y, 6, 1) :- checkCell(X, Y), checkCell(X, Y + 1), checkCell(X + 1, Y + 1), checkCell(X + 1, Y + 2), not ceilingNotFree(X, Y + 2), not ceilingNotFree(X + 1, Y + 2), spawnedTetromino(6, _, _, _,  _, _, _).

maxRot0(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 6, 0)}, validPosition(X, Y, 6, 0).
maxRot90(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 6, 1)}, validPosition(X, Y, 6, 1).

bestPos(Y, X, 0) | notBestPos(Y, X, 0):- maxRot0(X, Y), maxRot90(X1, Y1), Y > Y1, spawnedTetromino(6, _, _, _,  _, _, _).
bestPos(Y, X, 1) | notBestPos(Y, X, 1):- maxRot0(X1, Y1), maxRot90(X, Y), Y >= Y1, spawnedTetromino(6, _, _, _,  _, _, _).

%0
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, 0), checkCellBusy(X+2, Y+1), spawnedTetromino(6, _, _, _, _, _, _). [1@0, Y, X]
:~ bestPos(Y, X, 0), checkCell(X+2, Y+1)    , spawnedTetromino(6, _, _, _, _, _, _). [1@1, Y, X]

%90
%Prefer the bestPos where the Tetromino occupies the least space underneath
:~ bestPos(Y, X, 1), checkCellBusy(X, Y+2), spawnedTetromino(6, _, _, _, _, _, _). [1@0, Y, X]
:~ bestPos(Y, X, 1), checkCell(X, Y+2)    , spawnedTetromino(6, _, _, _, _, _, _). [1@1, Y, X]
