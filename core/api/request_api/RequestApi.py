import json

import requests


class RequestApi(object):

    def __init__(self):
        self.response = ""

    def do_request(self, input_endpoint, map_object):
        values = {}
        for row in map_object:
            key_value = row['key']
            value_value = row['value']
            values[key_value] = value_value

        values["key"] = ""
        values["token"] = ""

        querystring = json.dumps(values)
        url = "https://api.trello.com/1" + input_endpoint
        HEADERS = {'content-type': 'application/json'}
        method_type = "POST"
        self.response = requests.request(method_type, url, data=querystring, headers=HEADERS)
        return self.response

