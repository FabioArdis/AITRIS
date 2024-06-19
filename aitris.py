"""
######################################################################################
##  Name:           AITRIS                                                          ##
##  Description:    Tetromino-based puzzle video game powered by the EmbASP tech.   ##
##  Authors:        Fabio Ardis, Francesco Dattilo                                  ##
##  Creation date:  25/04/2024                                                      ##
##  Notes:          The code is mostly self documented, but if you got any          ##
##                  questions, feel free to contact the authors.                    ##
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

# Initialiaze PyGame
pygame.init()
preLogs.append("PyGame initialized.")

# Game window size W x H
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

# Setup standard finestra
window = pygame.display.set_mode((0, 0), pygame.FULLSCREEN)
pygame.display.set_caption('AITRIS - Powered by EmbASP')
preLogs.append("Window initialized.")

# Istanziamo le classi del gioco
game = Game()
tetromino = Tetromino()
board = Board()
renderer = Renderer()

for message in preLogs:
    renderer.add_to_log(message, window)
renderer.add_to_log("####### LOG START #######", window)

input_handler = Input()

# Instantiating the AI class
ai_manager = AiManager("./executables/dlv2", "./ai/tetris_ai.asp")

# Gameplay flow variables
fall_speed = 1
fall_counter = 0
is_paused = False
tetromino_counter = 1

position = []
vision = []

def exec_ai():

    global position
    global vision

    ai_manager.add_tetromino(tetromino.get_type())
    ai_manager.add_busy_cells(board.get_list_of_busy_cells())

    position = ai_manager.get_Best_position()

    # controlliamo che position non sia vuota
    if len(position) != 0:
        renderer.add_to_log(f"Riga decisa dalla AI: {position[0]} --- Colonna decisa dalla AI: {position[1]}", window)

        tetromino.position[1] = int(position[1])

        for n in range(int(ai_manager.get_rotation())):
            tetromino.rotate(board)
            print("Rotation! (caricato su git per temporaneo debug)")

    vision = [(position[i], position[i + 1]) for i in range(0, len(position), 2)]

# Execute the AI for the first Tetromino
exec_ai()

# Main Loop
loop = True
renderer.add_to_log("Start game.", window)
while loop:
    # Check if you pressed a button or closed the window
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            loop = False
        elif event.type == pygame.KEYDOWN:
            if event.key == pygame.K_p:  # Press 'P' to pause the game
                is_paused = not is_paused
        elif event.type == pygame.MOUSEBUTTONDOWN:
            if event.button == 4:  # Scroll mouse wheel up, for log
                renderer.scroll_log('up', window)
            elif event.button == 5:  # Scroll mouse wheel down, for log
                renderer.scroll_log('down', window)
        input_handler.handle_event(event, tetromino, board)

    if not is_paused:
        fall_counter += 1

    if fall_counter >= fall_speed:
        # Not an elegant solution but it's simple enough and it works.
        tetromino.position[0] += 1
        fall_counter = 0

        # If the tetromino DOES NOT collide with anything while falling down
        if not board.is_valid_position(tetromino.get_shape(), tetromino.get_position()):
            renderer.add_to_log(f"Collided with a tetromino: pos {tetromino.get_position()}.", window)
            # Fix the position and update the board.
            tetromino.move_up(board)
            board.update(tetromino)
            # In the meanwhile, check if the player cleared a line...
            lines_cleared = board.clear_lines()
            if lines_cleared > 0:
                renderer.add_to_log(f"Cleared {tetromino.get_position()} lines.", window)
            game.increase_score(lines_cleared)
            # ... or if it's game over.
            if game.check_game_over(board):
                loop = False
            # Finally, create the next new tetromino.
            tetromino = Tetromino()
            tetromino_counter += 1
            renderer.add_to_log("Tetromino " + str(tetromino_counter) + " added.", window)

            #########################################
            # BEGIN EMBASP CODE                     #
            #########################################
            renderer.add_to_log("Start AI", window)

            exec_ai()

            #########################################
            # END EMBASP CODE                       #
            #########################################
            renderer.add_to_log("End AI", window)

    # Black background
    window.fill((0, 0, 0))

    # Not very elegant, might switch to a more general Render() in the future
    renderer.render_log(window)
    renderer.render_board(window, board)
    renderer.render_game_info(window, game, tetromino_counter)
    # print("Ai Vision: ", vision)
    renderer.render_vision(window, vision)
    renderer.render_tetromino(window, tetromino)

    if is_paused:
        renderer.render_pause(window)

    # Finally update the display
    pygame.display.update()

    # 240 frames per second because we're not on console
    pygame.time.Clock().tick(240)


# Graceful shut down because we're elegant only when it's easy
pygame.quit()
