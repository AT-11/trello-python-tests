from behave import given, when, then, step
from core.utils.SchemaValidator import SchemaValidator


@given('Sets a POST request to "{endpoint}"')
def step_impl(context, endpoint):
    context.endpoint_value = endpoint
    for row_name in context.table:
        print(row_name['key'])
    context.name_value = row_name
    context.validator = SchemaValidator()


@step('Saves response as "{response_object}"')
def step_impl(context, name_object):
    context.name_object = context.json_response


@when('Sets a POST request to "{endpoint}"')
def step_impl(context, endpoint):
    context.api_value = endpoint
    for row in context.table:
        print(row['key'])
    context.name_value = row









