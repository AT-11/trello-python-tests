import json
from os import path


class JsonFileReader(object):

    @staticmethod
    def read(file_path):
        READ = 'r'
        new_file_path = path.relpath(file_path)
        with open(new_file_path, READ) as file:
            data = file.read()
        return json.loads(data)
