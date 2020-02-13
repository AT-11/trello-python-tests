from jsonschema import validate

from core.utils.EnvironmentConfiguration import EnvironmentConfiguration
from core.utils.JsonFileReader import JsonFileReader


class SchemaValidator(object):

    @staticmethod
    def validate(body_response, json_schema, config_file):
        folder_json_path = config_file['folder_json_path']
        json_path = '{}{}'.format(folder_json_path, json_schema)
        json_schema = JsonFileReader.read(json_path)
        try:
            return validate(instance=body_response, schema=json_schema)
        except ValueError as error:
            raise RuntimeError('Body response is wrong') from error
