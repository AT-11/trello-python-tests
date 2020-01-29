from behave import given, when, then, step

from core.api.request_api.RequestApi import RequestApi
from core.utils.SchemaValidator import SchemaValidator


@given('Sets a "{http_type}" request to "{endpoint}"')
def step_impl(context, http_type, endpoint):
    context.endpoint_value = endpoint
    context.map_object = context.table
    context.request_api = RequestApi()


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


@when('Sets a "{http_type}" request to "{endpoint}"')
def step_impl(context, http_type, endpoint):
    """
    to do
    """


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
    raise NotImplementedError(u'STEP: And Validates response body')