from behave import given, when, then, step

id_value = ""
url_value = ""
name_value = ""
json_response = ""
key_value = ""
token_value = ""
desc_value = ""


@given('Sets board URL "{url}"')
def step_impl(context, url):
    global url_value
    url_value = url


@step('Sets board KEY "{key}"')
def step_impl(context, key):
    global key_value
    key_value = key


@step('Sets board TOKEN "{token}"')
def step_impl(context, token):
    global token_value
    token_value = token


@given("Sets value to POST request")
def step_impl(context):
    global name_value
    for row in context.table:
        print(row['name'])
    name_value = row


@when("Sends board POST request")
def step_impl(context):
    global json_response
    global id_value
    json_response = context.CrudBoard.post_board(url_value, name_value, key_value, token_value)
    id_value = json_response.json()['id']


@step('Should return board status code "{status_code}" OK')
def step_impl(context, status_code):
    assert json_response.status_code is int(status_code)
    expected = context.validate.validate_schema(json_response.text)
    assert True is expected


@step('Saves response as "{response_object}"')
def step_impl(context, name_object):
    context.name_object = json_response


@step("Sets value to POST request")
def step_impl(context):
    global name_value
    for row in context.table:
        print(row['name'])
    name_value = row


@step("Sends list POST request")
def step_impl(context):
    global json_response  # update
    global id_value
    json_response = context.CrudBoard.post_board(url_value, name_value, key_value, token_value)
    id_value = json_response.json()['id']


@step("Sends board DELETE request")
def step_impl(context):
    context.CrudBoard.delete_board(url_value, id_value, key_value, token_value)


@step("Sends board GET request")
def step_impl(context):
    context.CrudBoard.get_board(url_value, id_value, key_value, token_value)


@step('Should return board "{message}"')
def step_impl(context, message):
    json_result = context.CrudBoard.return_message()
    assert json_result.text == message