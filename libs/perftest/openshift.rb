module PerfTest
  module OpenShift
    extend self

    def change_server(name)
      %x[ rhc env set OPENSHIFT_RUBY_SERVER=#{name} -a #{PerfTest::Config::OPENSHIFT_APP_NAME} ]
      restart_and_tidy_gear
    end

    def restart_and_tidy_gear
      %x[ rhc cartridge restart pbrazdil-advanced-ruby-1.9 -a #{PerfTest::Config::OPENSHIFT_APP_NAME} ]
      %x[ rhc cartridge tidy pbrazdil-advanced-ruby-1.9 -a #{PerfTest::Config::OPENSHIFT_APP_NAME} ]
      %x[ rhc cartridge restart mysql-5.1 -a #{PerfTest::Config::OPENSHIFT_APP_NAME} ]
    end

    def current_server
      response = %x[ rhc ssh #{PerfTest::Config::OPENSHIFT_APP_NAME} '~/advanced-ruby/bin/control server']
      response[/Application is using (.*) server/, 1]
    end

    def ps_aux_output
      %x[ rhc ssh #{PerfTest::Config::OPENSHIFT_APP_NAME} --gears 'ps aux']
    end
  end
end