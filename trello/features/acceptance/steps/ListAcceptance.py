from behave import *

use_step_matcher("re")


@given("Sets POST request")
def step_impl(context):
    """
    :type context: behave.runner.Context
    """
    raise NotImplementedError(u'STEP: Given Sets POST request
                              | name |
                              | boardToTest | ')