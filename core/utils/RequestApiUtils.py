import re
from core.utils import EnvironmentConfiguration


class RequestApiUtils:

    @staticmethod
    def get_id_value(row_value, id_dictionary):
        result_value = ""
        if re.search("[.]", row_value):
            key = row_value[1:row_value.index(".")]
            row_value = id_dictionary.get(key, None)
        elif re.search("[(|)]", row_value):
            row_value = row_value[1:-1]
            row_value = EnvironmentConfiguration.EnvironmentConfiguration.get_variables_file()[row_value]
        result_value = row_value
        return result_value

    @staticmethod
    def generate_data(data_table, id_dictionary):
        data_dictionary = {}
        if data_table is not None:
            for row in data_table:
                row_key = row['key']
                row_value = row['value']
                row_value = RequestApiUtils.get_id_value(row_value, id_dictionary)
                data_dictionary[row_key] = row_value
        return data_dictionary

    @staticmethod
    def replace_variables(input_endpoint, id_dictionary):
        NOT_FOUND = -1
        for key in id_dictionary:
            if input_endpoint.find(key) > NOT_FOUND:
                input_endpoint = input_endpoint.replace(key, str(id_dictionary[key])).replace(".id", "")
        return input_endpoint

