import json

import requests


class RequestApi(object):

    def __init__(self):
        self.response = ""

    def do_request(self, endpoint, map_object, method_type, id_value):
        print(id_value)
        values = {}
        for row in map_object:
            key_value = row['key']
            if key_value == "idBoard":
                value_value = id_value
            else:
                value_value = row['value']
            values[key_value] = value_value

        values["key"] = "4178a940f6bdaed61804b6ff90d6d20e"
        values["token"] = "e90ca503e4f0357e22543ff44250c74a98640c14d9e62e509b9171b5a4e8ecc6"

        querystring = json.dumps(values)
        url = "https://api.trello.com/1" + endpoint
        HEADERS = {'content-type': 'application/json'}
        # method_type = "POST"
        self.response = requests.request(method_type, url, data=querystring, headers=HEADERS)
        return self.response

