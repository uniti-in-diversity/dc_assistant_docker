command = '/usr/bin/gunicorn'
pythonpath = '/app/dc_assistant/dc_assistant'
bind = '0.0.0.0:8001'
workers = 3
errorlog = '-'
accesslog = '-'
capture_output = False
loglevel = 'debug'