module PerfTest
  class ActionController

    def initialize(options ,engine)
      @test_engine = engine
      @options = options
      @restart_cartridge_before_tests = true
      @logger = TestLog.new(options)
    end

    # test each server performance
    def run_all
      servers = PerfTest::Config::SERVERS

      servers.shuffle.each do |server_name|
        start_test(server_name)
      end
    end

    # get current server name
    def server
      puts OpenShift.current_server
    end

    # run test normally with cartridge restart
    def run_test
      start_test
    end


    # run test on current web server without restarting cartridges
    def run_now
      @restart_cartridge_before_tests = false
      start_test OpenShift.current_server
    end



    private

    def start_test(server_name = nil)
      server_name = @options.server_name unless server_name

      if @restart_cartridge_before_tests
        puts "Restarting cartridge and setting web server to #{server_name}..."
        OpenShift.change_server(server_name)
      end

      puts "Testing #{server_name} performance..."
      @logger.add_server_log(server_name) do |output|
        @test_engine.new(@options.concurrent, @options.requests, @options.warmup_concurrent, @options.warmup_requests, @options.delay, output).run
      end
      puts "End of testing #{server_name} server."
    end
  end
end