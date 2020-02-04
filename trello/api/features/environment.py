from core.api.request_api.RequestApi import RequestApi
from core.api.features.steps.Common import *


def before_scenario(context, scenario):
    context.id_dictionary = {}
    context.request_api = RequestApi()


def after_scenario(context, scenario):
    """
    To do
    """
