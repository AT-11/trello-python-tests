import json
from jsonschema import validate


class SchemaValidator(object):

    # Validates json schema
    def validate_schema(self, input_value):
        try:
            json_schema = {
                "type": "object",
                "properties": {
                    "id": {"type": "string", "pattern": "^[A-Za-z0-9]+$"},
                    "name": {"type": "string", "pattern": "^[A-Za-z0-9]+$"},
                    "desc": {"type": "string", "pattern": "^$|^[A-Za-z0-9]+$"},
                }
            }
            my_json = json.loads(input_value)
            validate(instance=my_json, schema=json_schema)
        except:
            return False
        return True
