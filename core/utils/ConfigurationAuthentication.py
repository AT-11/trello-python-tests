import json


class ConfigurationAuthentication(object):

    def __init__(self):
        with open('core/utils/config.json', 'r') as file:
            data = file.read()
            self.config = json.loads(file)

    def get_config_file(self):
        return self.config
