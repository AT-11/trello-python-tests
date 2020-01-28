import requests


class RequestApi(object):

    def __init__(self):
        self.response = ""

    def post_request(self, input_url, input_name, input_key, input_token):
        querystring = {"name": input_name, "defaultLabels": "true", "defaultLists": "true",
                       "keepFromSource": "none",
                       "prefs_permissionLevel": "private", "prefs_voting": "disabled", "prefs_comments": "members",
                       "prefs_invitations": "members", "prefs_selfJoin": "true", "prefs_cardCovers": "true",
                       "prefs_background": "blue", "prefs_cardAging": "regular",
                       "key": input_key,
                       "token": input_token}

        method_type = "POST"
        self.response = requests.request(method_type, input_url, params=querystring)
        return self.response

    def delete_request(self, input_url, input_id, input_key, input_token):
        url = input_url + input_id

        querystring = {"key": input_key,
                       "token": input_token}

        method_type = "DELETE"
        self.response = self.send_request.method_request(method_type, url, querystring)
        return self.response