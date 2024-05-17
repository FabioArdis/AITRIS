from specializations.dlv2.desktop.dlv2_desktop_service import DLV2DesktopService
from platforms.desktop.desktop_handler import DesktopHandler
from languages.asp.asp_mapper import ASPMapper
from languages.asp.asp_input_program import ASPInputProgram

from ai.position import AiPosition
from ai.bestPos import AiBestPos
#from ai.tetromino_ia import TetrominoIa


def load_asp_program_from_file(asp_program_path, asp_input_program_from_file):

    try:
        file = open(asp_program_path, "r")
    except Exception as e:
        raise Exception(str(e))

    for line in file:
        # Ignore comments and empty lines in the .asp file
        if line.startswith("%") or line.startswith("\n"):
            continue

        try:
            asp_input_program_from_file.add_program(line)
        except Exception as e:
            raise Exception(str(e))


class AiManager():

    # Default "executable" is for linux (btw) and default "asp program" is our tetris_ai.asp
    def __init__(self, executable_path="../executables/dlv2", asp_program_path="./tetris_ai.asp"):

        self.asp_program_path = asp_program_path

        self.handler = DesktopHandler(DLV2DesktopService(executable_path))
        ASPMapper.get_instance().register_class(AiPosition)
        # Find Best Position (work in progress)
        ASPMapper.get_instance().register_class(AiBestPos)
        self.asp_input_program_from_file = ASPInputProgram()
        self.asp_input_program_from_python = ASPInputProgram()

        load_asp_program_from_file(asp_program_path, self.asp_input_program_from_file)
        self.handler.add_program(self.asp_input_program_from_file)

        # print("Programs in \"AspInputProgramFromFile\" are:")
        # print(self.aspInputProgramFromFile.get_programs())

    def get_answer_set(self):

        answerSets = self.handler.start_sync()

        # clear old previous ".add_program" (non so se è la posizione SEMPRE corretta per fare il clear. Penso di si)
        # cioè, dopo che fai lo start_sync, il "program" è caricato definitivamente
        self.asp_input_program_from_python.clear_all()

        # Find Best Position (work in progress)
        #return answerSets.get_optimal_answer_sets()
        return answerSets.get_answer_sets()

    def add_position(self, x, y):
        self.asp_input_program_from_python.add_program("position(" + str(x) + "," + str(y) + ").")
        # print("get_programs is: " + self.asp_input_program_from_python.get_programs())
        self.handler.add_program(self.asp_input_program_from_python)

    def get_position(self):
        list_aiPosition = []
        answerSet = self.get_answer_set()
        if (answerSet):
            #print("answer set is: ", answerSet)
            get_first_answer_set = answerSet[0]
            for object in get_first_answer_set.get_atoms():
                if isinstance(object, AiPosition):
                    # print(object.get_x())
                    # print(object.get_y())
                    list_aiPosition.append(object.get_x())
                    list_aiPosition.append(object.get_y())

            print("list: " + str(list_aiPosition))
        return list_aiPosition

    # Find Best Position (work in progress)
    def get_BEST_position(self):
        list_aiPosition = []
        answerSet = self.get_answer_set()
        if (answerSet):
            #print("answer set is: ", answerSet)
            get_first_answer_set = answerSet[0]
            for object in get_first_answer_set.get_atoms():
                if isinstance(object, AiBestPos):
                    # print(object.get_x())
                    # print(object.get_y())
                    list_aiPosition.append(object.get_row())
                    list_aiPosition.append(object.get_col())

            print("list: " + str(list_aiPosition))
        return list_aiPosition

    def add_tetromino(self, shape):

        spawnedTetromino_str = "spawnedTetromino(" + str(shape).replace("[","").replace("]","") + ")."
        # print(spawnedTetromino_str)

        self.asp_input_program_from_python.add_program(spawnedTetromino_str) # "spawnedTetromino(" + str(shape) + ")."
        # print("get_programs is: " + self.asp_input_program_from_python.get_programs())

        self.handler.add_program(self.asp_input_program_from_python)

    def add_busy_cells(self, board):
        for row in range(len(board)):
            for col in range(len(board[0])):
                if (board[row][col] != 0):
                    #print("row and col are: ", row, col)
                    self.asp_input_program_from_python.add_program("busyCell(" + str(row) + ", " + str(col) + ").")
        #print("get_programs is: " + self.asp_input_program_from_python.get_programs())
        self.handler.add_program(self.asp_input_program_from_python)