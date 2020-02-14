from core.utils.JsonFileReader import JsonFileReader


class EnvironmentConfiguration:

    @staticmethod
    def get_config_file():
        return JsonFileReader.read('config.json')

    @staticmethod
    def get_variables_file():
        return JsonFileReader.read('input_variables.json')
