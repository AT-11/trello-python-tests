from dictor import dictor


class BodyValidator(object):

    @staticmethod
    def validate(body_response, data_table):
        dict_expected = BodyValidator.load_expected_dict(data_table)
        body_response = body_response.json()
        for value in dict_expected:
            value_body_response = dictor(body_response, value)
            result = str(value_body_response) == dict_expected[value]
            if not result:
                return False
        return True

    @staticmethod
    def load_expected_dict(data_table):
        dict_expected = {}
        for row_data_table in data_table:
            key = row_data_table['key']
            dict_expected[key] = row_data_table['value']
        return dict_expected
