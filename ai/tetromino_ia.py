from languages.predicate import Predicate


# Questa classe l'ho scritta a casaccio in previsione futura, ora non è nemmeno utilizzata
class TetrominoIa(Predicate):

    predicate_name = "tetromino"

    def __init__(self, id=None, type=None):
        Predicate.__init__(self, [("id"), ("type")])
        self.id = id
        self.type = type

    def get_id(self):
        return self.id

    def set_id(self, id):
        self.id = id

    def get_type(self):
        return self.type

    def set_type(self, type):
        self.type = type
