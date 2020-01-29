from behave import given, when, then, step

from core.api.request_api.RequestApi import RequestApi
from core.utils.SchemaValidator import SchemaValidator


@given('Sets a "{http_type}" request to "{endpoint}"')
def step_impl(context, http_type, endpoint):
    context.endpoint_value = endpoint
    context.table_object = context.table
    context.http_value = http_type
    context.id_value = "."
    context.request_api = RequestApi()


@step("Sends request")
def step_impl(context):
    context.json_response = context.request_api.do_request(context.http_value, context.endpoint_value,
                                                           context.table_object, context.id_value)


@step('Should return status code {number:d}')
def step_impl(context, number):
    context.validator = SchemaValidator()
    assert context.json_response.status_code is number


@step('Saves response as "{name_object}"')
def step_impl(context, name_object):
    context.name_object = context.json_response.json()


@when('Sets a "{method}" request to "{endpoint}"')
def step_impl(context, method, endpoint):
    context.endpoint_value = endpoint
    context.table_object = context.table
    context.http_value = method
    context.id_value = context.name_object['id']


@step("Validates schema")
def step_impl(context):
    """
    expected = context.validator_schema.validate_schema(context.json_response.text)
    assert True is expected
    """


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
