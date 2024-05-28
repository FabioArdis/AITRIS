cell(0..9, 0..19).

rows(0..19).

ceiling(R1, R) :- rows(R1), rows(R), R1 < R.
checkCell(X, Y) :- cell(X, Y), not busyCell(X, Y).
ceilingNotFree(X, Y) :- ceiling(Y1, Y), busyCell(X,Y1), Y<>Y1.

% type(0). % I - 0
% type(1). % T - 1
% type(2). % L - 2
% type(3). % J - 3
% type(4). %[] - 4
% type(5). % Z - 5
% type(6). % S - 6

% spawnedTetromino(Shape,  A, B, C,  D, E, F).

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

bestPos(Y, X, 0) :- maxRot0(X, Y), maxRot90(X1, Y1), Y > Y1, spawnedTetromino(0, _, _, _, _).
bestPos(Y, X, 1) :- maxRot0(X1, Y1), maxRot90(X, Y), Y >= Y1, spawnedTetromino(0, _, _, _, _).

maxRot0(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 0, 0)}, validPosition(X, Y, 0, 0).
maxRot90(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 0, 1)}, validPosition(X, Y, 0, 1).

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
validPosition(X, Y, 1, 1) :- checkCell(X + 1, Y), checkCell(X + 1, Y + 1), checkCell(X + 1, Y + 2), checkCell(X, Y + 1), not ceilingNotFree(X, Y + 1),  not ceilingNotFree(X + 1, Y + 1), spawnedTetromino(1, _, _, _,  _, _, _).
%180
validPosition(X, Y, 1, 2) :- checkCell(X, Y + 1), checkCell(X + 1, Y + 1), checkCell(X + 2, Y + 1), checkCell(X + 1, Y), not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), not ceilingNotFree(X + 2, Y + 1), spawnedTetromino(1, _, _, _,  _, _, _).
%270
validPosition(X, Y, 1, 3) :- checkCell(X, Y), checkCell(X, Y + 1), checkCell(X, Y + 2), checkCell(X + 1, Y + 1),         not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), spawnedTetromino(1, _, _, _,  _, _, _).

bestPos(Y, X, 0) :- maxRot0(X, Y), maxRot90(X1, Y1), maxRot180(X2, Y2), maxRot270(X3, Y3), Y > Y1, Y > Y2, Y > Y3, spawnedTetromino(1, _, _, _,  _, _, _).
bestPos(Y, X, 1) :- maxRot0(X1, Y1), maxRot90(X, Y), maxRot180(X3, Y3), maxRot270(X2, Y2), Y >= Y1, Y >= Y2, Y >= Y3, spawnedTetromino(1, _, _, _,  _, _, _).
bestPos(Y, X, 2) :- maxRot0(X1, Y1), maxRot90(X2, Y2), maxRot180(X, Y), maxRot270(X3, Y3), Y >= Y1, Y > Y2, Y > Y3, spawnedTetromino(1, _, _, _,  _, _, _).
bestPos(Y, X, 3) :- maxRot0(X1, Y1), maxRot90(X2, Y2), maxRot180(X3, Y3), maxRot270(X, Y), Y >= Y1, Y > Y2, Y >= Y3, spawnedTetromino(1, _, _, _,  _, _, _).

maxRot0(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 1, 0)}, validPosition(X, Y, 1, 0).
maxRot90(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 1, 1)}, validPosition(X, Y, 1, 1).
maxRot180(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 1, 2)}, validPosition(X, Y, 1, 2).
maxRot270(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 1, 3)}, validPosition(X, Y, 1, 3).

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
validPosition(X, Y, 2, 1) :- checkCell(X, Y), checkCell(X + 1, Y), checkCell(X + 1, Y + 1), checkCell(X + 1, Y + 2),     not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), spawnedTetromino(2, _, _, _,  _, _, _).
%180
validPosition(X, Y, 2, 2) :- checkCell(X, Y + 1), checkCell(X + 1, Y + 1), checkCell(X + 2, Y + 1), checkCell(X + 2, Y), not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), not ceilingNotFree(X + 2, Y + 1), spawnedTetromino(2, _, _, _,  _, _, _).
%270
validPosition(X, Y, 2, 3) :- checkCell(X, Y), checkCell(X, Y + 1), checkCell(X, Y + 2), checkCell(X + 1, Y + 2),         not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), spawnedTetromino(2, _, _, _,  _, _, _).

bestPos(Y, X, 0) :- maxRot0(X, Y), maxRot90(X1, Y1), maxRot180(X2, Y2), maxRot270(X3, Y3), Y > Y1, Y > Y2, Y > Y3, spawnedTetromino(2, _, _, _,  _, _, _).
bestPos(Y, X, 1) :- maxRot0(X1, Y1), maxRot90(X, Y), maxRot180(X3, Y3), maxRot270(X2, Y2), Y >= Y1, Y > Y2, Y > Y3, spawnedTetromino(2, _, _, _,  _, _, _).
bestPos(Y, X, 2) :- maxRot0(X1, Y1), maxRot90(X2, Y2), maxRot180(X, Y), maxRot270(X3, Y3), Y >= Y1, Y >= Y2, Y > Y3, spawnedTetromino(2, _, _, _,  _, _, _).
bestPos(Y, X, 3) :- maxRot0(X1, Y1), maxRot90(X2, Y2), maxRot180(X3, Y3), maxRot270(X, Y), Y >= Y1, Y >= Y2, Y >= Y3, spawnedTetromino(2, _, _, _,  _, _, _).

maxRot0(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 2, 0)}, validPosition(X, Y, 2, 0).
maxRot90(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 2, 1)}, validPosition(X, Y, 2, 1).
maxRot180(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 2, 2)}, validPosition(X, Y, 2, 2).
maxRot270(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 2, 3)}, validPosition(X, Y, 2, 3).

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
validPosition(X, Y, 3, 1) :- checkCell(X + 1, Y), checkCell(X + 1, Y + 1), checkCell(X + 1, Y + 2), checkCell(X, Y + 2), not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1),  spawnedTetromino(3, _, _, _,  _, _, _).
%180
validPosition(X, Y, 3, 2) :- checkCell(X, Y), checkCell(X, Y + 1), checkCell(X + 1, Y + 1), checkCell(X + 2, Y + 1),     not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), not ceilingNotFree(X + 2, Y + 1), spawnedTetromino(3, _, _, _,  _, _, _).
%270
validPosition(X, Y, 3, 3) :- checkCell(X, Y), checkCell(X + 1, Y), checkCell(X, Y + 1), checkCell(X, Y + 2),             not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), spawnedTetromino(3, _, _, _,  _, _, _).

bestPos(Y, X, 0)  :- maxRot0(X, Y), maxRot90(X1, Y1), maxRot180(X2, Y2), maxRot270(X3, Y3), Y > Y1, Y > Y2, Y > Y3, spawnedTetromino(3, _, _, _,  _, _, _).
bestPos(Y, X, 1)  :- maxRot0(X1, Y1), maxRot90(X, Y), maxRot180(X3, Y3), maxRot270(X2, Y2), Y >= Y1, Y >= Y2, Y > Y3, spawnedTetromino(3, _, _, _,  _, _, _).
bestPos(Y, X, 2)  :- maxRot0(X1, Y1), maxRot90(X2, Y2), maxRot180(X, Y), maxRot270(X3, Y3), Y >= Y1, Y >= Y2, Y >= Y3, spawnedTetromino(3, _, _, _,  _, _, _).
bestPos(Y, X, 3)  :- maxRot0(X1, Y1), maxRot90(X2, Y2), maxRot180(X3, Y3), maxRot270(X, Y), Y >= Y1, Y > Y2, Y > Y3, spawnedTetromino(3, _, _, _,  _, _, _).

maxRot0(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 3, 0)}, validPosition(X, Y, 3, 0).
maxRot90(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 3, 1)}, validPosition(X, Y, 3, 1).
maxRot180(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 3, 2)}, validPosition(X, Y, 3, 2).
maxRot270(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 3, 3)}, validPosition(X, Y, 3, 3).

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

bestPos(Y, X, 0) :- Y = #max{ Y1 : validPosition(_, Y1, 4, 0)}, validPosition(X, Y, 4, 0), spawnedTetromino(4, _, _, _, _).

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
validPosition(X, Y, 5, 1) :- checkCell(X + 1, Y), checkCell(X, Y + 1), checkCell(X + 1, Y + 1), checkCell(X, Y + 2), not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), spawnedTetromino(5, _, _, _,  _, _, _).

bestPos(Y, X, 0) :- maxRot0(X, Y), maxRot90(X1, Y1), Y >= Y1, spawnedTetromino(5, _, _, _,  _, _, _).
bestPos(Y, X, 1) :- maxRot0(X1, Y1), maxRot90(X, Y), Y > Y1, spawnedTetromino(5, _, _, _,  _, _, _).

maxRot0(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 5, 0)}, validPosition(X, Y, 5, 0).
maxRot90(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 5, 1)}, validPosition(X, Y, 5, 1).

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
validPosition(X, Y, 6, 1) :- checkCell(X, Y), checkCell(X, Y + 1), checkCell(X + 1, Y + 1), checkCell(X + 1, Y + 2), not ceilingNotFree(X, Y + 1), not ceilingNotFree(X + 1, Y + 1), spawnedTetromino(6, _, _, _,  _, _, _).

bestPos(Y, X, 0) :- maxRot0(X, Y), maxRot90(X1, Y1), Y >= Y1, spawnedTetromino(6, _, _, _,  _, _, _).
bestPos(Y, X, 1) :- maxRot0(X1, Y1), maxRot90(X, Y), Y > Y1, spawnedTetromino(6, _, _, _,  _, _, _).

maxRot0(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 6, 0)}, validPosition(X, Y, 6, 0).
maxRot90(X, Y) :- Y = #max{ Y1 : validPosition(_, Y1, 6, 1)}, validPosition(X, Y, 6, 1).
