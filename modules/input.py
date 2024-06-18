import pygame


class Input:
    def __init__(self):
        self.actions = {
            pygame.K_LEFT: "move_left",
            pygame.K_RIGHT: "move_right",
            pygame.K_UP: "rotate",
            pygame.K_DOWN: "move_down",
            pygame.K_a: "move_left",
            pygame.K_d: "move_right",
            pygame.K_w: "rotate",
            pygame.K_s: "move_down",
        }

    def handle_event(self, event, tetromino, board):
        if event.type == pygame.KEYDOWN:
            if event.key in self.actions:
                action = self.actions[event.key]
                getattr(tetromino, action)(board)
