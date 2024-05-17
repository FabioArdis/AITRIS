from languages.predicate import Predicate


# Find Best Position (work in progress)
class AiBestPos(Predicate):

    predicate_name = "bestPos"

    def __init__(self, row=None, col=None):
        Predicate.__init__(self, [("row"), ("col")])
        self.row = row
        self.col = col

    def get_row(self):
        return self.row

    def set_row(self, row):
        self.row = row

    def get_col(self):
        return self.col

    def set_col(self, col):
        self.col = col
