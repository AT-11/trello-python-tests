import os
import threading

from behave import step

from core.utils.BodyValidator import BodyValidator
from core.utils.SchemaValidator import SchemaValidator

from behave.__main__ import main as behave_main


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
    assert context.json_response.status_code == number


@step('Saves response as "{name_object}"')
def step_impl(context, name_object):
    context.id_dictionary[name_object] = context.json_response.json()['id']


@step('Validates schema with "{schema}"')
def step_impl(context, schema):
    result = SchemaValidator.validate(context.json_response.json(), schema)
    assert None is result


@step("Validates response body with")
def step_impl(context):
    INDEX_ONE = 0
    INDEX_TWO = 1
    result = BodyValidator.validate(context.json_response, context.table)
    assert True is result[INDEX_ONE], result[INDEX_TWO]


@step('Validates response message with message "{msg}"')
def step_impl(context, msg):
    assert context.json_response.text == msg


@step(u'run in parallel "{feature}" "{scenario}"')
def step_impl(context, feature, scenario):
    t = threading.Thread(
        name='run test parallel',
        target=parallel_executor,
        args=[context, feature, scenario])
    # args=[context, 'parallel_actions.feature', 'Make Cab-Cab communication'])
    t.start()


def parallel_executor(context, feature_name, scenario):
    os.chdir("trello\\api\\features\\negative\\")
    behave_main('-i "{}" -n "{}" --no-capture --no-skipped'.format(feature_name, scenario))
