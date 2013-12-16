module InputOptions
  require 'optparse'
  require 'optparse/time'
  require 'ostruct'

  module Parser
    def self.parse(args)
      options = OpenStruct.new
      options.server_name = PerfTest::Config::DEFAULT_SERVER_NAME
      options.delay = PerfTest::Config::DEFAULT_SLEEP_TIME
      options.concurrent = PerfTest::Config::DEFAULT_CONCURRENT_NUMBER
      options.requests = PerfTest::Config::DEFAULT_NUMBER_OF_REQUESTS
      options.custom_message = 'debug'
      options.verbose = false
      options.engine = 'ab'

      opts = OptionParser.new do |opts|
        opts.banner = 'Usage: ./perftest [options]'

        opts.separator ''
        opts.separator 'Options:'

        opts.on('-s', '--server [STRING]', 'Select webserver which will be running during performance testing.
              Allowed keywords are THIN, PASSENGER, PUMA, UNICORN and ALL for testing all servers.') do |server|
          options.server_name = server.downcase
        end

        opts.on('-c', '--concurrent [INT]', 'Number of concurrent requests.') do |concurrent_number|
          options.concurrent = concurrent_number
        end

        opts.on('-n', '--number [INT]', 'Number of requests.') do |requests|
          options.requests = requests
        end

        opts.on('-d', '--delay [INT]', 'Delay in seconds between warm up and testing.') do |delay|
          options.delay = delay
        end

        #opts.on('-e', '--engine [STRING]', 'Select whether you want to use AB or SIEGE for testing. Default is AB') do |engine|
        #  options.engine = engine
        #end

        opts.on('-m', '--message [STRING]', 'Custom message to distinguish tests in results folder.') do |message|
          options.custom_message = message.gsub(' ', '_')
        end

        opts.on('-v', '--[no-]verbose', 'Run verbosely') do |v|
          options.verbose = v
        end

        opts.on_tail('-h', '--help', 'Show this message') do
          puts opts
          exit
        end
      end

      opts.parse!(args)

      if args.size != 1
        puts opts
        exit
      end

      options.action = args.first.to_sym
      options
    end
  end
end