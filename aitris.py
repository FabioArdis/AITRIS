"""
######################################################################################
##  Nome:           AITRIS                                                          ##
##  Descrizione:    Gioco sui tetramini, adotta EmbASP.                             ##
##  Autore/i:       Fabio Ardis, Francesco Dattilo                                  ##
##  Data creazione: 25/04/2024                                                      ##
##  Note:           Se trovate qualcosa di non commentato, vuol dire che è          ##
##                  autoesplicativo. In caso di problemi o domande, chiedete pure.  ##
######################################################################################
"""

import pygame

from modules.game import Game
from modules.tetromino import Tetromino
from modules.board import Board
from modules.renderer import Renderer
from modules.input import Input
from ai.ai_manager import AiManager

# Inizializziamo PyGame
pygame.init()

# Dimensioni finestra W x H
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

# Setup standard finestra
window = pygame.display.set_mode((WINDOW_WIDTH, WINDOW_HEIGHT))
pygame.display.set_caption('AITRIS - Powered by EmbASP')

# Istanziamo le classi del gioco
game = Game()
tetromino = Tetromino()
board = Board()
renderer = Renderer()
input_handler = Input()

# Istanziamo la classe per la IA
ai_manager = AiManager("./executables/dlv2", "./ai/tetris_ai.asp")

# Contatori di sistema per il flow del gioco
fall_speed = 10
fall_counter = 0

# Loop principale
loop = True
while loop:
    # Controlla se abbiamo premuto un tasto o chiuso la finestra
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            loop = False
        input_handler.handle_event(event, tetromino, board)

    fall_counter += 1

    if fall_counter >= fall_speed:
        # Necessario manipolare direttamente la posizione. Non è molto elegante, ma meglio che scrivere un'altra
        # funzione quasi identica all'altra.
        tetromino.position[0] += 1
        fall_counter = 0

        ai_manager.add_position(tetromino.position[0], tetromino.position[1])
        x_position = ai_manager.get_position()
        # controlliamo che x_position non sia vuota
        if len(x_position) != 0:
            print(x_position[0])
            wanted_distance_difference = int(x_position[0]) - tetromino.position[1]
            for pressed_x in range(wanted_distance_difference):
                # QUESTO METODO NON VA BENE. Prova ad immaginare il caso in cui:
                # 1) la board NON si aggiorna in tempo,
                # 2) intanto il tetromino va molteplici volte a destra,
                # 3) a destra del tetromino (proprio dove sta andando) c'è una serie di blocchi già posti.
                # Risultato? Il tetromino "entra" dentro il blocco, in alcuni casi disegnando anche all'interno del blocco (occupando i buchi)
                # Possibile soluzione: fare il controllo _bene_ sulle collisioni in asp non dovrebbe rendere questo scenario possibile(?)
                tetromino.position[1] += 1
                # Più che fare +1 o -1 (o comunque fare moltiplicazioni per -1), sarebbe più corretto fargli premere un tasto, proprio, appunto, come se stesse giocando

        # Se il tetromino NON incontra qualcosa nella sua discesa naturale
        if not board.is_valid_position(tetromino.get_shape(), tetromino.get_position()):
            # Aggiustiamo la posizione e aggiorniamo la griglia.
            tetromino.move_up(board)
            board.update(tetromino)
            # Controlliamo se, nel frattempo, il giocatore è riuscito a completare una riga.
            lines_cleared = board.clear_lines()
            game.increase_score(lines_cleared)
            # Oppure, se è game over.
            if game.check_game_over(board):
                loop = False
            # Infine, creiamo un altro tetromino.
            tetromino = Tetromino()

    # Fill nero
    window.fill((0, 0, 0))

    # Potrei unirlo in un'unica funzione render() che include tutte e tre
    renderer.render_board(window, board)
    renderer.render_game_info(window, game)
    renderer.render_tetromino(window, tetromino)

    # Aggiorniamo finalmente il display
    pygame.display.update()

    # 60 frame al secondo perché non siamo su console
    pygame.time.Clock().tick(60)

# Graceful shut down perché ovviamente siamo eleganti solo quando ci è semplice esserlo
pygame.quit()
