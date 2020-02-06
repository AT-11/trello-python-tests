from core.api.request_api.RequestApi import RequestApi
from core.api.features.steps.Common import *
from logs.Logger import get_logger

logger = get_logger()


def before_feature(context, feature):
    print("START: %s", feature)


def before_scenario(context, scenario):
    context.id_dictionary = {}
    context.request_api = RequestApi()
    print("START: %s", scenario)

    logger.info("START: %s", scenario)


def after_scenario(context, scenario):
    print("END: %s", scenario)


def after_feature(context, feature):
    print("END: %s", feature)
