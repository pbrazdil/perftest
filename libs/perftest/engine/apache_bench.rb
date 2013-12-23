module PerfTest
  module Engine
    class ApacheBench
      COMMAND = 'ab -c %i -n %i -H "Accept-Encoding: gzip,deflate" %s'

      def initialize(concurrent_requests, number_of_requests, warmup_concurrent_requests, warmup_number_of_requests,  delay = 0, output = '')
        @output = output
        @command = COMMAND % [concurrent_requests, number_of_requests, PerfTest::Config::URL]
        @command_warm_up = COMMAND % [warmup_concurrent_requests, warmup_number_of_requests, PerfTest::Config::URL]
        @delay = delay.to_i

      end

      def run
        @output << "Sleeping for #{@delay} seconds..."
        sleep @delay

        @output << "Warm up '#{@command_warm_up}'"
        @output << run_test(@command_warm_up)

        @output << "Sleeping for #{@delay} seconds..."
        sleep @delay

        @output << "Test result '#{@command}'"
        @output << run_test(@command)

        @output << PerfTest::OpenShift.ps_aux_output
      end


      def on_complete(&block)
        yield block if block_given?
      end

      private
      def run_test(command)
        puts "Running: '#{command}'"
        %x[ #{command} ]
      end
    end
  end
end