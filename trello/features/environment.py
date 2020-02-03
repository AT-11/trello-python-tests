from core.api.request_api.RequestApi import RequestApi


def before_scenario(context, scenario):
    context.id_dictionary = {}
    context.request_api = RequestApi()


def after_scenario(context, scenario):
    """
    print('Finished running a scenario')
    """