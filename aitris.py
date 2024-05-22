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

preLogs = ["####### PRELOGS #######"]

# Inizializziamo PyGame
pygame.init()
preLogs.append("PyGame inizializzato.")

# Dimensioni finestra W x H
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

# Setup standard finestra
window = pygame.display.set_mode((0, 0), pygame.FULLSCREEN)
pygame.display.set_caption('AITRIS - Powered by EmbASP')
preLogs.append("Finestra inizializzata.")

# Istanziamo le classi del gioco
game = Game()
tetromino = Tetromino()
board = Board()
renderer = Renderer()

for message in preLogs:
    renderer.add_to_log(message, window)
renderer.add_to_log("####### INIZIO LOG #######", window)

input_handler = Input()

# Istanziamo la classe per la IA
ai_manager = AiManager("./executables/dlv2", "./ai/tetris_ai.asp")

# Contatori di sistema per il flow del gioco
fall_speed = 1
fall_counter = 0
is_paused = False
tetromino_counter = 1

# Loop principale
loop = True
renderer.add_to_log("Inizio gioco.", window)
while loop:
    # Controlla se abbiamo premuto un tasto o chiuso la finestra
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            loop = False
        elif event.type == pygame.KEYDOWN:
            if event.key == pygame.K_p:  # Premi 'P' per mettere in pausa
                is_paused = not is_paused
        elif event.type == pygame.MOUSEBUTTONDOWN:
            if event.button == 4:  # Rotella del mouse verso l'alto
                renderer.scroll_log('up', window)
            elif event.button == 5:  # Rotella del mouse verso il basso
                renderer.scroll_log('down', window)
        input_handler.handle_event(event, tetromino, board)

    if not is_paused:
        fall_counter += 1

    if fall_counter >= fall_speed:
        # Necessario manipolare direttamente la posizione. Non è molto elegante, ma meglio che scrivere un'altra
        # funzione quasi identica all'altra.
        tetromino.position[0] += 1
        fall_counter = 0

        # Se il tetromino NON incontra qualcosa nella sua discesa naturale
        if not board.is_valid_position(tetromino.get_shape(), tetromino.get_position()):
            renderer.add_to_log(f"Incontrato tetromino in pos {tetromino.get_position()}.", window)
            # Aggiustiamo la posizione e aggiorniamo la griglia.
            tetromino.move_up(board)
            board.update(tetromino)
            # Controlliamo se, nel frattempo, il giocatore è riuscito a completare una riga.
            lines_cleared = board.clear_lines()
            if lines_cleared > 0:
                renderer.add_to_log(f"Ripulite {tetromino.get_position()} righe.", window)
            game.increase_score(lines_cleared)
            # Oppure, se è game over.
            if game.check_game_over(board):
                loop = False
            # Infine, creiamo un altro tetromino.
            tetromino = Tetromino()
            tetromino_counter += 1
            renderer.add_to_log("Tetromino " + str(tetromino_counter) + " aggiunto.", window)

            ###
            # INIZIO CODICE AI
            ###
            renderer.add_to_log("Inizio AI", window)
            #ai_manager.add_position(tetromino.position[0], tetromino.position[1])

            print("get_shape is", tetromino.get_shape())
            ai_manager.add_tetromino(tetromino.get_shape())
            ai_manager.add_busy_cells(board.get_list_of_busy_cells())

            position = ai_manager.get_BEST_position()

            # controlliamo che position non sia vuota
            if len(position) != 0:
                renderer.add_to_log(f"Row decided by AI: {position[0]} --- Col decided by AI: {position[1]}", window)
                print("position[0] is: ", position[0])
                print("position[1] is: ", position[1])

                # Rotate the number of times calculated by .asp
                for a in range(int(ai_manager.get_times())):
                    tetromino.rotate(board)
                # QUESTO METODO NON VA BENE. Prova ad immaginare il caso in cui:
                # 1) la board NON si aggiorna in tempo,
                # 2) intanto il tetromino va molteplici volte a destra,
                # 3) a destra del tetromino (proprio dove sta andando) c'è una serie di blocchi già posti.
                # Risultato? Il tetromino "entra" dentro il blocco, in alcuni casi disegnando anche all'interno del blocco (occupando i buchi)
                # Possibile soluzione: fare il controllo _bene_ sulle collisioni in asp non dovrebbe rendere questo scenario possibile(?)
                tetromino.position[0] = int(position[0])
                tetromino.position[1] = int(position[1])
            ###
            # FINE CODICE AI
            ###
            renderer.add_to_log("Fine AI", window)

    # Fill nero
    window.fill((0, 0, 0))

    # Potrei unirlo in un'unica funzione render() che include tutte e tre
    renderer.render_log(window)
    renderer.render_board(window, board)
    renderer.render_game_info(window, game, tetromino_counter)
    renderer.render_tetromino(window, tetromino)

    if is_paused:
        renderer.render_pause(window)

    # Aggiorniamo finalmente il display
    pygame.display.update()

    # 60 frame al secondo perché non siamo su console
    pygame.time.Clock().tick(60)

# Graceful shut down perché ovviamente siamo eleganti solo quando ci è semplice esserlo
pygame.quit()
