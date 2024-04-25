import pygame


class Renderer:
    def __init__(self):
        self.BLACK = (0, 0, 0)
        self.WHITE = (255, 255, 255)
        self.GRAY = (128, 128, 128)
        self.RED = (255, 0, 0)
        self.GREEN = (0, 255, 0)
        self.BLUE = (0, 0, 255)

        self.font = pygame.font.Font(None, 36)

    def render_board(self, window, board):
        block_size = 30

        for row in range(board.rows):
            for col in range(board.cols):
                if board.grid[row][col] != 0:
                    pygame.draw.rect(window, self.WHITE, (col * block_size, row * block_size, block_size, block_size))
                else:
                    pygame.draw.rect(window, self.GREEN, (col * block_size, row * block_size, block_size, block_size), 1)

    def render_game_info(self, window, game):
        text_surface = self.font.render(f"Score: {game.score} Level: {game.level}", True, self.WHITE)
        window.blit(text_surface, (400, 10))

    def render_tetromino(self, window, tetromino):
        block_size = 30
        shape = tetromino.get_shape()
        position = tetromino.get_position()
        color = tetromino.get_color()
        for row in range(len(shape)):
            for col in range(len(shape[0])):
                if shape[row][col] != 0:
                    pygame.draw.rect(window, color, ((position[1] + col) * block_size, (position[0] + row) * block_size, block_size, block_size))
