from core.api.request_api.RequestApi import RequestApi
from core.api.features.steps.Common import *
from logs.Logger import logger


def before_feature(context, feature):

    # os.chdir("C:/Users/Admin/Documents/Python/trello-python-tests")
    logger.info("START: %s", feature)


def before_scenario(context, scenario):
    context.id_dictionary = {}
    context.request_api = RequestApi()
    logger.info("START: %s", scenario)


def after_scenario(context, scenario):
    logger.info("END: %s", scenario)


def after_feature(context, feature):
    logger.info("END: %s", feature)
