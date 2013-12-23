module PerfTest
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
        options.warmup_concurrent = PerfTest::Config::DEFAULT_CONCURRENT_NUMBER
        options.warmup_requests = PerfTest::Config::DEFAULT_NUMBER_OF_REQUESTS
        options.custom_message = 'debug'
        options.verbose = false
        options.engine = 'ab'


        opts = OptionParser.new do |opts|
          opts.banner = 'Usage: ./perftest TASK_NAME [options]'
          #opts.banner = "\n TASK_NAME options:"

          opts.separator ''
          opts.separator 'Options:'

          opts.on('-s', '--server [STRING]', 'puma, thin, passenger, unicorn, all') do |server|
            options.server_name = server.downcase
          end

          opts.on('-c', '--concurrent [INT]', 'Number of concurrent requests.') do |concurrent_number|
            options.concurrent = concurrent_number
          end

          opts.on('-n', '--number [INT]', 'Number of requests.') do |requests|
            options.requests = requests
          end

          opts.on('--warmupconcurrent [INT]', 'Number of concurrent requests for warmup.') do |concurrent_number|
            options.warmup_concurrent = concurrent_number
          end

          opts.on('--warmupnumber [INT]', 'Number of requests for warmup.') do |requests|
            options.warmup_requests = requests
          end

          opts.on('-d', '--delay [INT]', 'Delay in seconds between warm up and testing.') do |delay|
            options.delay = delay
          end

          opts.on('-m', '--message [STRING]', 'Custom message to distinguish tests in results folder.') do |message|
            options.custom_message = message.gsub(' ', '_')
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
end