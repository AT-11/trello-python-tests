import json
import re

import requests

from core.utils.EnvironmentConfiguration import EnvironmentConfiguration


class RequestApi(object):

    def __init__(self):
        self.response = ""
        self.config = EnvironmentConfiguration()

    def check_id(self, value, response_param):
        key = value[1:value.index(".")]
        return response_param.get(key, None)

    def do_request(self, http_type, input_endpoint, table_object, response_param):
        values = {}
        for row in table_object:
            key_value = row['key']
            value_value = row['value']
            if re.search("[.]", value_value):
                response_value = self.check_id(value_value, response_param)
                value_value = response_value
            if re.search("[(|)]", value_value):
                value_value = self.config.get_config_file()[key_value]
            values[key_value] = value_value

        values["key"] = self.config.get_config_file()['key']
        values["token"] = self.config.get_config_file()['token']

        body_content = json.dumps(values)
        url = self.config.get_config_file()['url_trello'] + input_endpoint
        HEADERS = {'content-type': 'application/json'}
        self.response = requests.request(http_type, url, data=body_content, headers=HEADERS)
        return self.response
