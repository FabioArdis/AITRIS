from embasp.languages.predicate import Predicate


# Find Best Position (work in progress)
class ValidPosition(Predicate):

    predicate_name = "validPosition"

    def __init__(self, x=None, y=None, typeTetromino=None, rotation=None):
        Predicate.__init__(self, [("X"), ("Y"), ("typeTetromino"), ("rotation")])
        self.x = x
        self.y = y
        self.typeTetromino = typeTetromino
        self.rotation = rotation

    def get_x(self):
        return self.x

    def set_x(self, x):
        self.x = x

    def get_y(self):
        return self.y

    def set_y(self, y):
        self.y = y

    def get_typeTetromino(self):
        return self.typeTetromino

    def set_typeTetromino(self, typeTetromino):
        self.typeTetromino = typeTetromino

    def set_rotation(self, rotation):
        self.rotation = rotation

    def get_rotation(self):
        return self.rotation
