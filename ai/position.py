from languages.predicate import Predicate


class AiPosition(Predicate):

    predicate_name = "aiPosition"

    def __init__(self, x=None, y=None, shape=None):
        Predicate.__init__(self, [("x"), ("y"), ("shape")])
        self.x = x
        self.y = y
        self.shape = shape

    def get_x(self):
        return self.x

    def set_x(self, x):
        self.x = x

    def get_y(self):
        return self.y

    def set_y(self, y):
        self.y = y

    def get_shape(self):
        return self.shape

    def set_shape(self, shape):
        self.shape = shape
