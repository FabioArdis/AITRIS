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
import time

from modules.game import Game
from modules.tetromino import Tetromino
from modules.board import Board
from modules.renderer import Renderer
from modules.input import Input
from ai.ai_manager import AiManager

preLogs = ["####### PRELOGS #######"]

# Initialize PyGame
pygame.init()
preLogs.append("PyGame initialized.")

# Game window size W x H (actually unused)
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

# Set up the window
window = pygame.display.set_mode((0, 0), pygame.FULLSCREEN)
pygame.display.set_caption('AITRIS - Powered by EmbASP')
preLogs.append("Window initialized.")

# Instantiate the game's classes
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

quitting = False


def exec_ai():
    global position
    global vision

    print(f"Decided shape is {tetromino.get_shape()}")

    print(f"tetromino number {tetromino_counter}")

    start = time.time()

    ai_manager.add_tetromino(tetromino.get_type())
    ai_manager.add_busy_cells(board.get_list_of_busy_cells())

    position = ai_manager.get_Best_position()

    end = time.time()

    # Check if the chosen position is valid
    if len(position) != 0:
        renderer.add_to_log(f"Best Position[{position[0]}][{position[1]}], Best Rotation: {ai_manager.get_rotation()}", window)
        
        # Tremendous way to fix a niche problem 
        no = False

        # Tremendous way to fix a niche problem 
        # when tetromino L or T or J is decided with rotation 3 with position X=8 or more, the rotation will stuck to 1
        if tetromino.get_shape() == Tetromino.SHAPES[1] or tetromino.get_shape() == Tetromino.SHAPES[2] or tetromino.get_shape() == Tetromino.SHAPES[3] :
            if position[1] >= 7:
                tetromino.position[1] = position[1]-1
                no = True
            else:
                tetromino.position[1] = position[1]
        else:
            tetromino.position[1] = position[1]

        for n in range(ai_manager.get_rotation()):
            tetromino.rotate(board)

        # Tremendous way to fix a niche problem 
        if no:
            tetromino.position[1] = position[1]

    vision = [(position[i], position[i + 1]) for i in range(0, len(position), 2)]

    renderer.add_to_log(f"AI took {end - start}s", window)

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
            renderer.add_to_log(" ", window)
            # Fix the position and update the board.
            tetromino.move_up(board)
            board.update(tetromino)
            # In the meanwhile, check if the player cleared a line...
            lines_cleared = board.clear_lines()
            if lines_cleared > 0:
                renderer.add_to_log(f"Cleared a line.", window)
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

            exec_ai()

            #########################################
            # END EMBASP CODE                       #
            #########################################

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

    # 60 frames per second because we're not on console
    pygame.time.Clock().tick(240)


while not quitting:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            quitting = True
        elif event.type == pygame.KEYDOWN:
            if event.key == pygame.K_ESCAPE:
                quitting = True

    renderer.render_game_over(window)

    pygame.display.update()

    pygame.time.Clock().tick(60)


# Graceful shut down because we're elegant only when it's easy
pygame.quit()
