from behave import given, when, then, step

from core.api.request_api.RequestApi import RequestApi
from core.utils.BodyValidator import BodyValidator
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
    assert context.json_response.status_code is number


@then('Should return status code {number:d}')
def step_impl(context, number):
    assert context.json_response.status_code is number


@step('Saves response as "{name_object}"')
def step_impl(context, name_object):
    context.response_param[name_object] = context.json_response.json()['id']


@when('Sets a "{method}" request to "{endpoint}"')
def step_impl(context, method, endpoint):
    context.endpoint_value = endpoint
    context.data_table = context.table
    context.method = method


@step('Validates schema with "{schema}"')
def step_impl(context, schema):
    result = SchemaValidator.validate(context.json_response.json(), schema)
    assert True is result


@step('Sets a "{method}" request to "{endpoint}"')
def step_impl(context, method, endpoint):
    context.endpoint_value = endpoint
    context.method = method


@step('Validates response body with "{expected_body}"')
def step_impl(context, expected_body):
    body_validator = BodyValidator()
    result = body_validator.validate(context.json_response, expected_body, context.data_table)
    assert True is result
