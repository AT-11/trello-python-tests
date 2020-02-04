import json

from core.utils.EnvironmentConfiguration import EnvironmentConfiguration
from core.utils.JsonFileReader import JsonFileReader


class BodyValidator(object):

    @staticmethod
    def validate(body_response, expected_body_path, data_table):
        result = False
        environment_conf = EnvironmentConfiguration()
        folder_json_path = environment_conf.get_config_file()['folder_json_path']
        expected_body_path = folder_json_path + expected_body_path
        expected_body = JsonFileReader.read(expected_body_path)

        expected_body = BodyValidator.update_expected_body(data_table, expected_body)
        body_response = body_response.json()
        for row in expected_body:
            result = expected_body[row] == body_response[row]
            if not result:
                return False
        return result

    @staticmethod
    def update_expected_body(data_table, expected_body):
        for row_data_table in data_table:
            key = row_data_table['key']
            expected_body[key] = BodyValidator.replacer(expected_body, row_data_table)
        return expected_body

    @staticmethod
    def replacer(expected_body, row_data_table):
        row_key = row_data_table['key']
        if row_key in expected_body:
            return row_data_table['value']
