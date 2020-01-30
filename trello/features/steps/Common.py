from behave import given, when, then, step

from core.api.request_api.RequestApi import RequestApi
from core.utils.SchemaValidator import SchemaValidator


@given('Sets a "{method}" request to "{endpoint}"')
def step_impl(context, method, endpoint):
    context.endpoint_value = endpoint
    context.data_table = context.table
    context.method = method
    context.response_param = {}
    context.request_api = RequestApi()


@step("Sends request")
def step_impl(context):
    context.json_response = context.request_api.do_request(context.method, context.endpoint_value,
                                                           context.data_table, context.response_param)


@step('Should return status code {number:d}')
def step_impl(context, number):
    context.validator_schema = SchemaValidator()
    assert context.json_response.status_code is number


@step('Saves response as "{name_object}"')
def step_impl(context, name_object):
    context.response_param[name_object] = context.json_response.json()['id']


@when('Sets a "{method}" request to "{endpoint}"')
def step_impl(context, method, endpoint):
    context.endpoint_value = endpoint
    context.data_table = context.table
    context.method = method


@then('Should return status code {number:d}')
def step_impl(context, number):
    context.validator_schema = SchemaValidator()
    assert context.json_response.status_code is number


@step("Validates schema")
def step_impl(context):
    """
    expected = context.validator_schema.validate_schema(context.json_response.text)
    assert True is expected
    """


@step('Sets a "{method}" request to "{endpoint}"')
def step_impl(context, method, endpoint):
    context.endpoint_value = endpoint
    context.method = method


@step("Validates response body")
def step_impl(context):
    """
    :type context: behave.runner.Context
    """
