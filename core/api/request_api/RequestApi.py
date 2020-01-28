import json

import requests


class RequestApi(object):

    def __init__(self):
        self.response = ""

    def post_request(self, input_url, map_object):
        values = {}
        for row in map_object:
            values.update({row['key']: row['value']})
        values.update({"key": ""})
        values.update({"token": ""})
        querystring = json.dumps(values)
        url = "https://api.trello.com/1" + input_url

        method_type = "POST"
        self.response = requests.request(method_type, url, params=querystring)
        return self.response

    def delete_request(self, input_url, input_id):
        url = input_url + input_id

        querystring = {"key": "",
                       "token": ""}

        method_type = "DELETE"
        self.response = self.send_request.method_request(method_type, url, querystring)
        return self.response
