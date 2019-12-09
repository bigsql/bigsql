import os,json
import logging
from logging.handlers import RotatingFileHandler
from os.path import expanduser

SETTINGS_DIR = os.path.dirname(os.path.abspath(__file__))

PROJECT_SETTINGS_FILE = os.path.join(expanduser('~'),"conf","bigsql.json")

if not os.path.exists(PROJECT_SETTINGS_FILE):
    PROJECT_SETTINGS_FILE = os.path.join(SETTINGS_DIR, "conf", "bigsql_local.json")

JSON_SETTINGS_FILE = PROJECT_SETTINGS_FILE

JSON_SETTINGS = json.loads(open(JSON_SETTINGS_FILE).read())



def add_logging_config(app):
    LOG_FILENAME = '../error.log'

    formatter = logging.Formatter(
        "[%(asctime)s] {%(pathname)s:%(lineno)d} %(levelname)s - %(message)s")
    handler = RotatingFileHandler(LOG_FILENAME, maxBytes=10000000, backupCount=5)
    handler.setLevel(logging.INFO)
    handler.setFormatter(formatter)
    app.logger.addHandler(handler)
    return app