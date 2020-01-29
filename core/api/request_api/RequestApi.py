import json

import requests

from core.utils.ConfigurationAuthentication import ConfigurationAuthentication


class RequestApi(object):

    def __init__(self):
        self.response = ""
        self.config = ConfigurationAuthentication()

    def do_request(self, http_type, input_endpoint, table_object, id_value):
        values = {}
        for row in table_object:
            key_value = row['key']
            if key_value == "idBoard":
                value_value = id_value
            else:
                value_value = row['value']
            values[key_value] = value_value

        values["key"] = self.config.get_config_file()['key']
        values["token"] = self.config.get_config_file()['token']

        body_content = json.dumps(values)
        url = self.config.get_config_file()['url_trello'] + input_endpoint
        HEADERS = {'content-type': 'application/json'}
        self.response = requests.request(http_type, url, data=body_content, headers=HEADERS)
        return self.response
