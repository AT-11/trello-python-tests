import json
import re

import requests

from core.utils.EnvironmentConfiguration import EnvironmentConfiguration


class RequestApi(object):

    def __init__(self):
        self.response = ""
        self.config = EnvironmentConfiguration()

    def generate_data(self, data_table, response_param):
        data_dictionary = {}
        for row in data_table:
            row_key = row['key']
            row_value = row['value']
            if re.search("[.]", row_value):
                key = row_value[1:row_value.index(".")]
                row_value = response_param.get(key, None)
            if re.search("[(|)]", row_value):
                row_value = self.config.get_config_file()[row_key]
            data_dictionary[row_key] = row_value
        data_dictionary["key"] = self.config.get_config_file()['key']
        data_dictionary["token"] = self.config.get_config_file()['token']
        return data_dictionary

    def do_request(self, http_type, input_endpoint, data_table, response_param):
        data = self.generate_data(data_table, response_param)

        body_content = json.dumps(data)
        url = self.config.get_config_file()['url_trello'] + input_endpoint
        HEADERS = {'content-type': 'application/json'}
        self.response = requests.request(http_type, url, data=body_content, headers=HEADERS)
        return self.response
