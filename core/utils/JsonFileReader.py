import json


class JsonFileReader(object):

    @staticmethod
    def read(file_path):
        with open(file_path, 'r') as file:
            data = file.read()
        return json.loads(data)
