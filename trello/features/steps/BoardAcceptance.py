from behave import *



@step('Sets a PUT request to /boards/(BoardObject.id)')
def step_impl(context):
    """
    :type context: behave.runner.Context
    """


@step('Sets a DELETE request to /boards/(BoardObject.id)')
def step_impl(context):
    """
    :type context: behave.runner.Context
    """


@when('Sets a PUT request to "/boards/id/members"')
def step_impl(context):
    """
    :type context: behave.runner.Context
    """


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
