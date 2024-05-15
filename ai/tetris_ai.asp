% INPUT
% spawnedTetromino([...],[...])
% busyCell(
%          [...]
%          [...]
%          [...]
%           ...)


% OUTPUT
%

rows(0..20).
cols(0..10).
cell(R,C) :- rows(R), cols(C).

tetromino([1, 1, 1, 1]).         % I
tetromino([1, 1, 1], [0, 1, 0]). % T
tetromino([1, 1, 1], [1, 0, 0]). % L
tetromino([1, 1, 1], [0, 0, 1]). % J
tetromino([1, 1], [1, 1]).       % Cube
tetromino([1, 1, 0], [0, 1, 1]). % Z
tetromino([0, 1, 1], [1, 1, 0]). % S

%aiPosition(18,6) :- position(_,3).
aiPosition(R1,C1) :- position(R,C), tetromino([_,_,_], [_,1,_]), spawnedTetromino([[_,_,_], [_,1,_]]), R1=R+10, C1=C+4.
aiPosition(R,C) :- cell(R,C), R<5, C<10-3. % il '-3' l'ho messo perche' la forma più larga che ho lasicato e' 3
:- aiPosition(R,C), busyCell(cell(R,C)).
:~ aiPosition(R,C), aiPosition(R1,C), R<R1, R = #min{R2:aiPosition(R2,_)}. [R@1]

%freeCell(R,C) | notFreeCell(R,C) :- cell(R,C).
%:- freeCell(R,C), busyCell(cell(R,C)).
