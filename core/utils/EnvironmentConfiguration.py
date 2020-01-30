import json


class EnvironmentConfiguration(object):

    def __init__(self):
        with open('config.json', 'r') as file:
            data = file.read()
            self.config = json.loads(data)

    def get_config_file(self):
        return self.config
