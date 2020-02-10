import json
import re
import requests

from core.utils.EnvironmentConfiguration import EnvironmentConfiguration
from logs.Logger import logger
from logs.Logger import verify_logger


class RequestApi(object):

    def __init__(self):
        self.response = ""
        self.config = EnvironmentConfiguration()

    def get_id_value(self, row_key, row_value, id_dictionary):
        result_value = ""
        if re.search("[.]", row_value):
            key = row_value[1:row_value.index(".")]
            row_value = id_dictionary.get(key, None)
        elif re.search("[(|)]", row_value):
            row_value = row_value[1:-1]
            row_value = self.config.get_variables_file()[row_value]
        result_value = row_value
        return result_value

    def generate_data(self, data_table, id_dictionary):
        data_dictionary = {}
        if data_table is not None:
            for row in data_table:
                row_key = row['key']
                row_value = row['value']
                row_value = self.get_id_value(row_key, row_value, id_dictionary)
                data_dictionary[row_key] = row_value
        return data_dictionary

    def do_request(self, http_type, input_endpoint, data_table, id_dictionary):
        logger.info("METHOD: " + http_type)
        logger.info("ENDPOINT: " + input_endpoint)
        logger.info("DATATABLE: %s", data_table)
        logger.info("DICTIONARY: %s", id_dictionary)
        data = self.generate_data(data_table, id_dictionary)
        params_credentials = {"key": self.config.get_config_file()['key'], "token": self.config
            .get_config_file()['token']}

        body_content = json.dumps(data)
        logger.debug("BODY: %s", body_content)
        url = self.config.get_config_file()['base_uri'] + self.replace_variables(input_endpoint, id_dictionary)
        HEADERS = {'content-type': 'application/json'}

        logger.debug("HEADERS: %s", HEADERS)

        if http_type == 'GET' or http_type == 'DELETE':
            self.response = requests.request(http_type, url, params=params_credentials)
            verify_logger(self.response)
        else:
            self.response = requests.request(http_type, url, data=body_content, headers=HEADERS,
                                             params=params_credentials)
            verify_logger(self.response)
        return self.response

    def replace_variables(self, input_endpoint, id_dictionary):
        NOT_FOUND = -1
        for key in id_dictionary:
            if input_endpoint.find(key) > NOT_FOUND:
                input_endpoint = input_endpoint.replace(key, id_dictionary[key]).replace(".id", "")
        return input_endpoint
