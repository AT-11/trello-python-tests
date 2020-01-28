from behave import given, when, then, step


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


@step("Sends request")
def step_impl(context):
    context.json_response = context.list.post_board(context.url_value + context.api_value, context.name_value,
                                                    context.key_value, context.token_value)
    context.id_value = json_response.json()['id']


@step('Should return status code "{status_code}"')
def step_impl(context, status_code):
    assert json_response.status_code is int(status_code)
    expected = context.validate.validate_schema(json_response.text)
    assert True is expected


@step('Saves response as "{response_object}"')
def step_impl(context, name_object):
    context.name_object = json_response


@when('Sets a POST request to "{api}"')
def step_impl(context, api):
    context.api_value = api
    for row in context.table:
        print(row['key'])
    context.name_value = row


@step("Sends list POST request")
def step_impl(context):
    global json_response  # update
    global id_value
    json_response = context.CrudBoard.post_board(url_value, name_value, key_value, token_value)
    id_value = json_response.json()['id']


@step("Sends board DELETE request")
def step_impl(context):
    context.CrudBoard.delete_board(url_value, id_value, key_value, token_value)