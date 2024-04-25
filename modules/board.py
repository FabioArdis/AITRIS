class Board:
    def __init__(self, rows=20, cols=10):
        self.rows = rows
        self.cols = cols
        self.grid = [[0] * cols for _ in range(rows)]

    def is_valid_position(self, shape, position):
        # Check delle collisioni abbastanza rudimentale ma efficace
        for row in range(len(shape)):
            for col in range(len(shape[0])):
                if shape[row][col] != 0:
                    abs_row = position[0] + row
                    abs_col = position[1] + col
                    if abs_row < 0 or abs_row >= self.rows or \
                       abs_col < 0 or abs_col >= self.cols or \
                       self.grid[abs_row][abs_col] != 0:
                        return False
        return True

    def update(self, tetromino):
        # Aggiorniamo la griglia una volta inserito il nostro tetramino
        shape = tetromino.get_shape()
        position = tetromino.get_position()
        color = tetromino.get_color()

        for row in range(len(shape)):
            for col in range(len(shape[0])):
                if shape[row][col] != 0:
                    self.grid[position[0] + row][position[1] + col] = color

    def clear_lines(self):
        lines_cleared = 0
        new_grid = []

        for row in range(self.rows):
            if 0 not in self.grid[row]:
                lines_cleared += 1
            else:
                new_grid.append(self.grid[row])

        while len(new_grid) < self.rows:
            new_grid.insert(0, [0] * self.cols)

        self.grid = new_grid
        return lines_cleared
