import json
from jsonschema import validate

from core.utils.JsonFileReader import JsonFileReader


class SchemaValidator(object):

    # Validates json schema
    def validate(self, body_response, json_schema):
        json_path = 'trello/jsonfiles/' + json_schema
        try:
            json_schema = JsonFileReader.read(json_path)
            body_json = json.loads(body_response)
            validate(instance=body_json, schema=json_schema)
        except:
            return False
        return True
