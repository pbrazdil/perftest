module Engine

  class Ab
    COMMAND = 'ab -c %i -n %i %s'

    def initialize(concurrent_requests, number_of_requests, delay = 0, output = '')
      @output = output
      @command = COMMAND % [concurrent_requests, number_of_requests, PerfTest::Config::URL ]
      @command_warm_up = COMMAND % [concurrent_requests, number_of_requests.to_i * 2, PerfTest::Config::URL]
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

      @output << PerfTest::Openshift.ps_aux_output
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