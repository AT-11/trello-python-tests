import json

import requests

from core.utils.ConfigurationAuthentication import ConfigurationAuthentication


class RequestApi(object):

    def __init__(self):
        self.response = ""
        self.config = ConfigurationAuthentication()

    def do_request(self, method_type, input_endpoint, map_object):
        values = {}
        for row in map_object:
            key_value = row['key']
            value_value = row['value']
            values[key_value] = value_value

        values["key"] = self.config.get_config_file()['key']
        values["token"] = self.config.get_config_file()['token']

        querystring = json.dumps(values)
        url = self.config.get_config_file()['url_trello'] + input_endpoint
        HEADERS = {'content-type': 'application/json'}

        self.response = requests.request(method_type, url, data=querystring, headers=HEADERS)
        return self.response
