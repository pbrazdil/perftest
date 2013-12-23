module PerfTest
  class TestLog

    def initialize(opts)
      @options = opts
      @dir = FileUtils.mkdir_p(Config::LOG_DIR % [Time.now.strftime('%Y%m%d_%H%M'), @options.action, @options.concurrent, @options.requests, @options.delay, @options.custom_message]).first

      save_options
    end

    def save_options
      file = new_log_file('options')
      file << @options
      file.close
    end

    def new_log_file(name)
      File.new("#{@dir}/#{PerfTest::Config::LOG_FILE % [name]}", 'w+')
    end


    def add_server_log(server_name)
      raise 'block needs to be given!' unless block_given?

      log_content = LogContent.new
      yield log_content

      log = new_log_file(server_name)
      log << log_content
      log.close
    end

  end
end