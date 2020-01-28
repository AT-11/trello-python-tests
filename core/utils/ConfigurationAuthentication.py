import json


class ConfigurationAuthentication(object):
    config = ""
    READ = 'r'

    def __init__(self):
        with open('config.json', self.READ) as file:
            self.config = json.load(file)

    def get_config_file(self):
        return self.config
