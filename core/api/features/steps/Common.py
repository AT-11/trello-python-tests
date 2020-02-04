from behave import step
from core.utils.SchemaValidator import SchemaValidator


@step('Sets a "{method}" request to "{endpoint}"')
def step_impl(context, method, endpoint):
    context.endpoint_value = endpoint
    context.data_table = context.table
    context.method = method


@step("Sends request")
def step_impl(context):
    context.json_response = context.request_api.do_request(context.method, context.endpoint_value,
                                                           context.data_table, context.id_dictionary)


@step('Should return status code {number:d}')
def step_impl(context, number):
    assert context.json_response.status_code is number


@step('Saves response as "{name_object}"')
def step_impl(context, name_object):
    context.id_dictionary[name_object] = context.json_response.json()['id']


@step('Validates schema with "{schema}"')
def step_impl(context, schema):
    expected = SchemaValidator.validate(context.json_response.json(), schema)
    assert True is expected


@step("Validates response body")
def step_impl(context):
    """
    :type context: behave.runner.Context
    """
    