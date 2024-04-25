import pygame

# Inizializziamo PyGame
pygame.init()

# Dimensioni finestra W x H
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

# Setup standard finestra
window = pygame.display.set_mode((WINDOW_WIDTH, WINDOW_HEIGHT))
pygame.display.set_caption('AITRIS - Powered by EmbASP')

# Loop principale
loop = True
while loop:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            loop = False