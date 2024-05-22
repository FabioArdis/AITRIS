from embasp.languages.predicate import Predicate


class AiTimesToRotate(Predicate):
    predicate_name = "rotatedTetromino"

    def __init__(self, times=None, A=None, B=None, C=None, D=None, E=None, F=None):
        Predicate.__init__(self, [("times"), ("A"), ("B"), ("C"), ("D"), ("E"), ("F")])
        self.times = int(times) if times is not None else None
        self.A = A
        self.B = B
        self.C = C
        self.D = D
        self.E = E
        self.F = F

    def get_times(self):
        return self.times

    def set_times(self, times):
        self.times = times

    def get_A(self):
        return self.A

    def set_A(self, A):
        self.A = A

    def get_B(self):
        return self.B

    def set_B(self, B):
        self.B = B

    def get_C(self):
        return self.C

    def set_C(self, C):
        self.C = C

    def get_D(self):
        return self.D

    def set_D(self, D):
        self.D = D

    def get_E(self):
        return self.E

    def set_E(self, E):
        self.E = E

    def get_F(self):
        return self.F

    def set_F(self, F):
        self.F = F