from core.utils.JsonFileReader import JsonFileReader


class EnvironmentConfiguration(object):

    def __init__(self):
        self.config = JsonFileReader.read('config.json')

    def get_config_file(self):
        return self.config
