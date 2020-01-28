from behave import given, when, then, step

from core.api.request_api.RequestApi import RequestApi
from core.utils.SchemaValidator import SchemaValidator


@given('Sets a POST request to "{endpoint}"')
def step_impl(context, endpoint):
    context.endpoint_value = endpoint
    context.map_object = context.table
    context.request_api = RequestApi()


@step("Sends request")
def step_impl(context):
    context.json_response = context.request_api.post_request(context.endpoint_value, context.map_object)
    context.id_value = context.json_response.json()['id']


@step('Should return status code {number:d}')
def step_impl(context, number):
    context.validator = SchemaValidator()
    assert context.json_response.status_code is number


@step('Saves response as "{response_object}"')
def step_impl(context, name_object):
    context.name_object = context.json_response


@when('Sets a POST request to "{endpoint}"')
def step_impl(context, endpoint):
    context.api_value = endpoint
    for row in context.table:
        print(row['key'])
    context.name_value = row


@then('Should return status code {number:d}')
def step_impl(context, number):
    assert context.json_response.status_code is number


@step("Validates response body")
def step_impl(context):
    """
    :param context:
    :return:
    """


@step("Validates schema")
def step_impl(context):
    expected = context.validator.validate_schema(context.json_response.text)
    assert True is expected


@step('Sets a DELETE request to "{endpoint}"')
def step_impl(context, endpoint):
    context.endpoint_value = endpoint
    context.board.delete_board(context.url_value + context.endpoint_value, context.id_value, context.key_value,
                               context.token_value)
