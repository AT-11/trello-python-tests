from behave import given, when, then, step
from core.ui.utils.SchemaValidator import SchemaValidator


@given('Sets base URI "{url}"')
def step_impl(context, url):
    context.url_value = url


@step('Sets KEY "{key}"')
def step_impl(context, key):
    context.key_value = key


@step('Sets TOKEN "{token}"')
def step_impl(context, token):
    context.token_value = token


@given('Sets a POST request to "{api}"')
def step_impl(context, api):
    context.api_value = api
    for row_name in context.table:
        print(row_name['key'])
    context.name_value = row_name
    context.validator = SchemaValidator()


@step("Sends request")
def step_impl(context):
    context.json_response = context.list.post_board(context.url_value + context.api_value, context.name_value,
                                                    context.key_value, context.token_value)
    context.id_value = context.json_response.json()['id']


@step('Should return status code "{status_code}"')
def step_impl(context, status_code):
    assert context.json_response.status_code is int(status_code)


@step('Saves response as "{response_object}"')
def step_impl(context, name_object):
    context.name_object = context.json_response


@when('Sets a POST request to "{api}"')
def step_impl(context, api):
    context.api_value = api
    for row in context.table:
        print(row['key'])
    context.name_value = row


@then('Should return status code "{status_code}"')
def step_impl(context, status_code):
    assert context.json_response.status_code is int(status_code)


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


@step('Sets a DELETE request to "{api}"')
def step_impl(context, api):
    context.api = api
    context.board.delete_board(context.url_value + context.api, context.id_value, context.key_value,
                               context.token_value)
