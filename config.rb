module PerfTest
  module Config

    URL = 'http://test-pbrazdil.rhcloud.com/'

    OPENSHIFT_APP_NAME = 'test'

    # unixtime - action name - custom comment
    LOG_DIR = 'results/%s-%s-%sc%sn%sd-%s'

    # server name
    LOG_FILE = '%s'

    SERVERS = %w{ puma passenger thin unicorn }

    DEFAULT_SERVER_NAME = 'passenger'
    DEFAULT_CONCURRENT_NUMBER = 1
    DEFAULT_NUMBER_OF_REQUESTS = 20
    DEFAULT_SLEEP_TIME = 5  # in seconds
  end
end