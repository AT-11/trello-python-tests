import json
import re

import requests

from core.utils.EnvironmentConfiguration import EnvironmentConfiguration


class RequestApi(object):

    def __init__(self):
        self.response = ""
        self.config = EnvironmentConfiguration()

    def verify_value(self, row_key, row_value, response_param):
        result_value = ""
        if re.search("[.]", row_value):
            key = row_value[1:row_value.index(".")]
            row_value = response_param.get(key, None)
        elif re.search("[(|)]", row_value):
            row_value = self.config.get_config_file()[row_key]
        result_value = row_value
        return result_value

    def generate_data(self, data_table, response_param):
        data_dictionary = {}
        for row in data_table:
            row_key = row['key']
            row_value = row['value']
            row_value = self.verify_value(row_key, row_value, response_param)
            data_dictionary[row_key] = row_value
        data_dictionary["key"] = self.config.get_config_file()['key']
        data_dictionary["token"] = self.config.get_config_file()['token']
        return data_dictionary

    def do_request(self, http_type, input_endpoint, data_table, response_param):
        values = {}

        data = self.generate_data(data_table, response_param)

        body_content = json.dumps(data)
        url = self.config.get_config_file()['url_trello'] + input_endpoint
        HEADERS = {'content-type': 'application/json'}
        if http_type == "POST":
            self.response = requests.request(http_type, url, data=body_content, headers=HEADERS)
        else:
            values["key"] = self.config.get_config_file()['key']
            values["token"] = self.config.get_config_file()['token']
            url += self.generate_data_delete(data_table, response_param)
            self.response = requests.request(http_type, url, params=values)
        return self.response

    def generate_data_delete(self, data_table, response_param):
        row_value = self.verify_value_delete(response_param)
        return row_value

    def verify_value_delete(self, response_param):
        key = 'BoardObject'
        row_value = response_param.get(key, None)
        return row_value
