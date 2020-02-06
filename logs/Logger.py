import logging
from core.utils.EnvironmentConfiguration import EnvironmentConfiguration

config = EnvironmentConfiguration()


#
# def singleton(cls):
#     instances = {}
#
#     def get_instance():
#         if cls not in instances:
#             instances[cls] = cls()
#         return instances[cls]
#
#     return get_instance()
#
#
# @singleton
# class LoggerC:
def get_logger():
    logger = logging.getLogger(__name__)
    logger.setLevel(logging.DEBUG)
    file_handler = logging.FileHandler(config.get_config_file()['log_path'])
    formatter = logging.Formatter("%(asctime)s - %(process)d - %(name)s - %(levelname)s - %(message)s")
    file_handler.setFormatter(formatter)
    logger.addHandler(file_handler)
    return logger
