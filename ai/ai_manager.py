from specializations.dlv2.desktop.dlv2_desktop_service import DLV2DesktopService
from platforms.desktop.desktop_handler import DesktopHandler
from languages.asp.asp_mapper import ASPMapper
from languages.asp.asp_input_program import ASPInputProgram

from ai.bestPos import AiBestPos

from typing import List

def load_asp_program_from_file(asp_program_path, asp_input_program_from_file) -> None:

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

        ASPMapper.get_instance().register_class(AiBestPos)

        self.asp_input_program_from_file = ASPInputProgram()
        self.asp_input_program_from_python = ASPInputProgram()

        self.rotation = 0

        load_asp_program_from_file(asp_program_path, self.asp_input_program_from_file)
        self.handler.add_program(self.asp_input_program_from_file)

        # print(self.aspInputProgramFromFile.get_programs())

    def get_answer_set(self):

        answerSets = self.handler.start_sync()

        # Clear old previous ".add_program"
        self.asp_input_program_from_python.clear_all()

        return answerSets.get_optimal_answer_sets()
        # return answerSets.get_answer_sets()

    def get_Best_position(self) -> List:
        list_aiPosition = []

        answerSet = self.get_answer_set()

        if (answerSet):
            get_first_answer_set = answerSet[0]
            for object in get_first_answer_set.get_atoms():
                if isinstance(object, AiBestPos):
                    list_aiPosition.append(object.get_row())
                    list_aiPosition.append(object.get_col())

                    self.rotation = object.get_rotation()

            # print("list: ", list_aiPosition)

        return list_aiPosition

    def add_tetromino(self, type) -> None:
        spawnedTetromino_str = "spawnedTetromino(" + str(type) + ")."
        self.asp_input_program_from_python.add_program(spawnedTetromino_str)
        # print("get_programs is: " + self.asp_input_program_from_python.get_programs())
        self.handler.add_program(self.asp_input_program_from_python)

    def add_busy_cells(self, list_of_busy_cells: List) -> None:
        for coordinate in list_of_busy_cells:
            self.asp_input_program_from_python.add_program("busyCell(" + str(coordinate[1]) + ", " + str(coordinate[0]) + ").")
        self.handler.add_program(self.asp_input_program_from_python)

    def get_rotation(self) -> int:
        return self.rotation
