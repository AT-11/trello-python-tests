import json


class BodyValidator(object):

    @staticmethod
    def validate(body_response, expected_body, data_table):
        expected_body = BodyValidator.update_expected_body(data_table, expected_body)
        body_response = json.loads(body_response)
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
