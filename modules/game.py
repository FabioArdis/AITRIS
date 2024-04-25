class Game:
    def __init__(self):
        self.score = 0
        self.level = 0

    def increase_score(self, lines_cleared):
        # Un punto per ogni riga completata
        self.score += lines_cleared * self.level

        # Ogni 20 (- livello attuale) punti aumenta la difficoltà
        if self.score >= 10 * self.level - self.level:
            self.level += 1

    def check_game_over(self, board):
        if any(board.grid[0]):
            return True
        return False

    def reset(self):
        self.score = 0
        self.level = 0