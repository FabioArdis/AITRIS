import random


class Tetromino:
    SHAPES = [
        #[[1, 1, 1, 1]],  # I
        [[1, 1, 1], [0, 1, 0]],  # T
        #[[1, 1, 1], [1, 0, 0]],  # L
        #[[1, 1, 1], [0, 0, 1]],  # J
        #[[1, 1], [1, 1]],  # Cubo
        [[1, 1, 0], [0, 1, 1]],  # Z
        [[0, 1, 1], [1, 1, 0]],  # S
    ]

    COLORS = [
        (255, 0, 0),  # Rosso
        (0, 255, 0),  # Verde
        (0, 0, 255),  # Blu
        (255, 255, 0),  # Giallo
        (255, 165, 0),  # Arancione
        (128, 0, 128),  # Viola
        (0, 255, 255)  # Azzurro
    ]

    def __init__(self):
        # Randomizziamo forma e colore, mentre la posizione è al centro.
        self.shape = random.choice(self.SHAPES)
        self.color = random.choice(self.COLORS)
        self.position = [0, 3]

    # Controlliamo SEMPRE la validità della prossima posizione e forma.
    def move_down(self, board):
        new_position = [self.position[0] + 1, self.position[1]]
        if board.is_valid_position(self.shape, new_position):
            self.position[0] += 1

    def move_up(self, board):
        new_position = [self.position[0] - 1, self.position[1]]
        if board.is_valid_position(self.shape, new_position):
            self.position[0] -= 1

    def move_left(self, board):
        new_position = [self.position[0], self.position[1] - 1]
        if board.is_valid_position(self.shape, new_position):
            if self.position[1] > 0:
                self.position[1] -= 1

    def move_right(self, board):
        new_position = [self.position[0], self.position[1] + 1]
        if board.is_valid_position(self.shape, new_position):
            if self.position[1] < 10 - len(self.shape[0]):
                self.position[1] += 1

    def rotate(self, board):
        new_shape = [list(row) for row in zip(*self.shape[::-1])]
        if board.is_valid_position(new_shape, self.position):
            self.shape = [list(row) for row in zip(*self.shape[::-1])]

    def get_shape(self):
        return self.shape

    def get_position(self):
        return self.position

    def get_color(self):
        return self.color
