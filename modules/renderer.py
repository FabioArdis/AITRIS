import pygame


class Renderer:
    def __init__(self):
        self.BLACK = (0, 0, 0)
        self.WHITE = (255, 255, 255)
        self.LIGHT_GRAY = (160, 160, 160)
        self.GRAY = (128, 128, 128)
        self.DARK_GRAY = (64, 64, 64)
        self.RED = (255, 0, 0)
        self.GREEN = (0, 255, 0)
        self.BLUE = (0, 0, 255)

        self.font = pygame.font.Font(None, 36)

        # LOG
        self.log_font = pygame.font.Font(None, 24)
        self.log_messages = []

        self.log_width = 500
        self.log_height = 430
        self.log_x = 400
        self.log_y = 170

    def render_board(self, window, board):
        block_size = 30

        for row in range(board.rows):
            for col in range(board.cols):
                if board.grid[row][col] != 0:
                    pygame.draw.rect(window, self.WHITE, (col * block_size, row * block_size, block_size, block_size))
                else:
                    pygame.draw.rect(window, self.GREEN, (col * block_size, row * block_size, block_size, block_size), 1)

    def render_game_info(self, window, game, tetrominoCounter):
        text_surface = self.font.render(f"Score: {game.score} Level: {game.level}", True, self.WHITE)
        window.blit(text_surface, (400, 30))
        text_surface = self.font.render(f"Current tetromino N°{tetrominoCounter}", True, self.WHITE)
        window.blit(text_surface, (400, 60))

    def render_tetromino(self, window, tetromino):
        block_size = 30
        shape = tetromino.get_shape()
        position = tetromino.get_position()
        color = tetromino.get_color()
        for row in range(len(shape)):
            for col in range(len(shape[0])):
                if shape[row][col] != 0:
                    pygame.draw.rect(window, color, ((position[1] + col) * block_size, (position[0] + row) * block_size, block_size, block_size))

    def render_log(self, window):
        # Log background
        pygame.draw.rect(window, self.GRAY, (self.log_x, self.log_y, self.log_width, self.log_height))

        # Base text offset
        x = self.log_x + 10
        y = self.log_y + 10

        # Max log lines
        max_log_lines = self.log_height // 20  # Teoricamente questo dovrebbe riuscire a rendere le cose adaptive...?

        # Render the log messages
        for message in self.log_messages[self.log_offset:self.log_offset + max_log_lines]:
            text_surface = self.log_font.render(message, True, self.WHITE)
            window.blit(text_surface, (x, y))
            y += 20  # Offset for the next message

        self.render_scrollbar(window)

    def add_to_log(self, message, window):
        self.log_messages.append(message)
        # Update the offset in order to show the last message
        self.log_offset = max(0, len(self.log_messages) - self.log_height // 20)
        self.render_log(window)

    def scroll_log(self, direction, window):
        if direction == 'up' and self.log_offset > 0:
            self.log_offset -= 1
        elif direction == 'down' and self.log_offset < len(self.log_messages) - self.log_height // 20:
            self.log_offset += 1
        self.render_log(window)

    def render_scrollbar(self, window):
        # Scrollbar size
        scrollbar_width = 20
        scrollbar_height = self.log_height

        # Calculate the thumb size
        total_log_lines = len(self.log_messages)
        max_log_lines = self.log_height // 20
        min_thumb_height = 20  # Thumb min size

        if total_log_lines > max_log_lines:
            thumb_height = max(min_thumb_height, scrollbar_height * max_log_lines / total_log_lines)
        else:
            thumb_height = scrollbar_height

        # Calculate the thumb position
        if total_log_lines > max_log_lines:
            thumb_y = self.log_y + (scrollbar_height - thumb_height) * self.log_offset / (total_log_lines - max_log_lines)
        else:
            thumb_y = self.log_y

        # Render the scollbar's track
        pygame.draw.rect(window, self.DARK_GRAY, (self.log_x + self.log_width - scrollbar_width, self.log_y, scrollbar_width, scrollbar_height))

        # Render the scrollbar's thumb
        pygame.draw.rect(window, self.LIGHT_GRAY, (self.log_x + self.log_width - scrollbar_width, thumb_y, scrollbar_width, thumb_height))

    def render_pause(self, window):
        text_surface = self.font.render("PAUSE", True, self.RED)
        window.blit(text_surface, (400, 100))

    def render_vision(self, window, vision):
        # New addition, shows all the possible positions that could've been chosen by the AI
        block_size = 30
        color = (139, 29, 38)

        for index, coord in enumerate(vision):
            x = int(coord[0])
            y = int(coord[1])
            pygame.draw.rect(window, color, (y * block_size, x * block_size, block_size, block_size))
