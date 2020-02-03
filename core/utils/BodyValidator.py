import json

from core.utils.EnvironmentConfiguration import EnvironmentConfiguration
from core.utils.JsonFileReader import JsonFileReader


class BodyValidator(object):

    @staticmethod
    def validate(body_response, expected_body_path, data_table):
        environment_conf = EnvironmentConfiguration()
        folder_json_path = environment_conf.get_config_file()['folder_json_path']
        expected_body_path = folder_json_path + expected_body_path
        expected_body = JsonFileReader.read(expected_body_path)
        expected_body = BodyValidator.update_expected_body(data_table, expected_body.text)
        # body_response = json.loads(body_response)
        for row in expected_body:
            if row['value'] in body_response:
                return True
            else:
                return False

    @staticmethod
    def update_expected_body(data_table, expected_body):
        expected_body_dictionary = json.loads(expected_body)
        for row in expected_body_dictionary:
            expected_body[row['key']] = BodyValidator.replacer(row['value'], data_table)
        return expected_body_dictionary

    @staticmethod
    def replacer(expected_body_key, data_table):
        if expected_body_key in data_table:
            return data_table['value']
