from behave import *

from core.ui.utils.SchemaValidator import SchemaValidator


@step("Sets the following Path Params:")
def step_impl(context):
    """
    :type context: behave.runner.Context
    """


@step('Sets a PUT request to /boards/(BoardObject.id)')
def step_impl(context):
    """
    :type context: behave.runner.Context
    """


@step("Sets the following Path Params")
def step_impl(context):
    """
    :type context: behave.runner.Context
    """


@step('Sets a DELETE request to /boards/(BoardObject.id)')
def step_impl(context):
    """
    :type context: behave.runner.Context
    """


@when('Sets a PUT request to "{endpoint}"')
def step_impl(context, endpoint):
    context.endpoint_value = endpoint


@step('Sets a PUT request to /boards/"(BoardObject.id)"')
def step_impl(context):
    """
    :type context: behave.runner.Context
    """


@step('Sets a DELETE request to /boards/"(BoardObject.id)"')
def step_impl(context):
    """
    :type context: behave.runner.Context
    """
