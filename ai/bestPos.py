from languages.predicate import Predicate


class AiBestPos(Predicate):

    predicate_name = "bestPos"

    def __init__(self, row=None, col=None, rotation=None):
        Predicate.__init__(self, [("row"), ("col"), ("rotation")])
        self.row = row
        self.col = col
        self.rotation = rotation

    def get_row(self):
        return self.row

    def set_row(self, row):
        self.row = row

    def get_col(self):
        return self.col

    def set_col(self, col):
        self.col = col

    def set_rotation(self, rotation):
        self.rotation = rotation

    def get_rotation(self):
        return self.rotation
