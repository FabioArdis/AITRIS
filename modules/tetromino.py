import random


class Tetromino:
    SHAPES = [
        [[1, 1, 1, 1]],  # I - 0
        [[1, 1, 1], [0, 1, 0]],  # T - 1
        [[1, 1, 1], [1, 0, 0]],  # L - 2
        [[1, 1, 1], [0, 0, 1]],  # J - 3
        [[1, 1], [1, 1]],  # Cube - 4
        [[1, 1, 0], [0, 1, 1]],  # Z - 5
        [[0, 1, 1], [1, 1, 0]],  # S - 6
    ]

    COLORS = [
        (255, 0, 0),  # Red
        (0, 255, 0),  # Green
        (0, 0, 255),  # Blue
        (255, 255, 0),  # Yellow
        (255, 165, 0),  # Orange
        (128, 0, 128),  # Purple
        (0, 255, 255)  # Teal
    ]

    def __init__(self):
        # Randomize shape, color and type
        self.type = random.randint(3, 3)
        self.shape = self.SHAPES[self.type]
        self.color = random.choice(self.COLORS)
        self.position = [0, 0]

    # ALWAYS CHECK if the position and rotation are valid
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

    # Only getters, you shouldn't be able to change shape, color and type.
    def get_shape(self):
        return self.shape

    def get_position(self):
        return self.position

    def get_color(self):
        return self.color

    def get_type(self):
        return self.type
