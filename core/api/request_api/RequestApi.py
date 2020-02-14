import json
import requests
from dictor import dictor

from core.utils.RequestApiUtils import RequestApiUtils
from logs.Logger import logger
from logs.Logger import verify_logger


class RequestApi(object):

    def __init__(self):
        self.response = ""
        self.params_credentials = {}
        self.url = ""

    def do_request(self, http_type, input_endpoint, data_table, id_dictionary):
        logger.info("METHOD: " + http_type)
        logger.info("ENDPOINT: " + input_endpoint)
        logger.info("DATATABLE: %s", data_table)
        logger.info("DICTIONARY: %s", id_dictionary)
        data = RequestApiUtils.generate_data(data_table, id_dictionary)

        body_content = json.dumps(data)
        logger.debug("BODY: %s", body_content)
        url_value = self.url + RequestApiUtils.replace_variables(input_endpoint, id_dictionary)
        HEADERS = {'content-type': 'application/json'}

        logger.debug("HEADERS: %s", HEADERS)
        if http_type == 'GET' or http_type == 'DELETE':
            self.response = requests.request(http_type, url_value, params=self.params_credentials)
            verify_logger(self.response)
        else:
            self.response = requests.request(http_type, url_value, data=body_content, headers=HEADERS,
                                             params=self.params_credentials)
            verify_logger(self.response)
        return self.response

    def delete_object(self, cleaner_list):
        status_code_list = []
        for item in cleaner_list:
            value = self.url + item
            self.response = requests.request('DELETE', value, params=self.params_credentials)
            status_code_list.append(self.response.status_code)
        return status_code_list

    def upload_credentials_url(self, api_config_dict, user_type):
        user_key = '{}{}'.format(user_type, '.key')
        user_token = '{}{}'.format(user_type, '.token')
        self.url = dictor(api_config_dict, 'base_uri')
        self.params_credentials['key'] = dictor(api_config_dict, user_key)
        self.params_credentials['token'] = dictor(api_config_dict, user_token)
