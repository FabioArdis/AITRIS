from languages.predicate import Predicate


class AiBestPos(Predicate):

    predicate_name = "bestPos"

    def __init__(self, row=None, col=None, rotation=None):
        Predicate.__init__(self, [("row"), ("col"), ("rotation")])
        self.row = row
        self.col = col
        self.rotation = rotation

    def get_row(self) -> int:
        if self.row is None:
            raise ValueError("row is not set")
        return int(self.row)

    def set_row(self, row):
        self.row = row

    def get_col(self) -> int:
        if self.col is None:
            raise ValueError("col is not set")
        return int(self.col)

    def set_col(self, col):
        self.col = col

    def get_rotation(self) -> int:
        if self.rotation is None:
            raise ValueError("rotation is not set")
        return int(self.rotation)

    def set_rotation(self, rotation):
        self.rotation = rotation
