from behave import given, when, then, step

from core.api.request_api.RequestApi import RequestApi
from core.utils.SchemaValidator import SchemaValidator


@given('Sets a "{http_type}" request to "{endpoint}"')
def step_impl(context, http_type, endpoint):
    context.endpoint_value = endpoint
    context.table_object = context.table
    context.http_value = http_type
    context.response_param = ""
    context.request_api = RequestApi()


@step("Sends request")
def step_impl(context):
    context.json_response = context.request_api.do_request(context.http_value, context.endpoint_value,
                                                           context.table_object, context.response_param)


@step('Should return status code {number:d}')
def step_impl(context, number):
    assert context.json_response.status_code is number


@then('Should return status code {number:d}')
def step_impl(context, number):
    assert context.json_response.status_code is number


@step('Saves response as "{name_object}"')
def step_impl(context, name_object):
    context.response_param = context.json_response.json()


@when('Sets a "{method}" request to "{endpoint}"')
def step_impl(context, method, endpoint):
    context.endpoint_value = endpoint
    context.table_object = context.table
    context.http_value = method


@step('Validates schema with "{schema}"')
def step_impl(context, schema):
    expected = SchemaValidator.validate(context.json_response.text, schema)
    assert True is expected


@step('Sets a "{http_type}" request to "{endpoint}"')
def step_impl(context, http_type, endpoint):
    """
    context.endpoint_value = endpoint
    context.board.delete_board(context.url_value + context.endpoint_value, context.id_value, context.key_value,
                               context.token_value)
    """


@step("Validates response body")
def step_impl(context):
    """
    :type context: behave.runner.Context
    """
