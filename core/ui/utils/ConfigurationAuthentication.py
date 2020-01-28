import json


class ConfigurationAuthentication(object):
    config = ""

    def __init__(self):
        with open('config.json', 'r') as file:
            self.config = json.load(file)

    def get_config_file(self):
        return self.config
