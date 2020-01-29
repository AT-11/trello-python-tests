from behave import given, when, then, step

from core.api.request_api.RequestApi import RequestApi
from core.utils.SchemaValidator import SchemaValidator


@given('Sets a POST request to "{endpoint}"')
def step_impl(context, endpoint):
    context.endpoint_value = endpoint
    context.map_object = context.table
    context.request_api = RequestApi()
    for row_name in context.table:
        print(row_name['key'])
    context.name_value = row_name


@step("Sends request")
def step_impl(context):
    context.json_response = context.request_api.do_request(context.endpoint_value, context.map_object)
    context.id_value = context.json_response.json()['id']


@step('Should return status code {number:d}')
def step_impl(context, number):
    context.validator = SchemaValidator()
    assert context.json_response.status_code is number


@step('Saves response as "{response_object}"')
def step_impl(context, name_object):
    """
    to do
    """


@when('Sets a POST request to "{endpoint}"')
def step_impl(context, endpoint):
    """
    to do
    """


@step("Validates schema")
def step_impl(context):
    """
    expected = context.validator_schema.validate_schema(context.json_response.text)
    assert True is expected
    """


@step('Sets a DELETE request to "{endpoint}"')
def step_impl(context, endpoint):
    """
    context.endpoint_value = endpoint
    context.board.delete_board(context.url_value + context.endpoint_value, context.id_value, context.key_value,
                               context.token_value)
    """
