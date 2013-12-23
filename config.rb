module PerfTest
  module Config
    OPENSHIFT_APP_NAME = 'test'
    OPENSHIFT_DOMAIN = 'pbrazdil'
    OPENSHIFT_SERVER = 'rhcloud.com' # OpenShift Online

    URL = "http://#{OPENSHIFT_APP_NAME}-#{OPENSHIFT_DOMAIN}.#{OPENSHIFT_SERVER}/"

    # FORMAT: unixtime - action name - settings - custom comment
    LOG_DIR = 'results/%s-%s-%sc%sn%sd-%s'

    # FORMAT: server name
    LOG_FILE = '%s'

    SERVERS = %w{ puma passenger thin unicorn }

    DEFAULT_SERVER_NAME = 'passenger'
    DEFAULT_CONCURRENT_NUMBER = 1
    DEFAULT_NUMBER_OF_REQUESTS = 20
    DEFAULT_SLEEP_TIME = 5  # in seconds
  end
end