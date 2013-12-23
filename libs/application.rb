
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# require all gems
Bundler.require(:default)


module PerfTest
  require_relative '../config'
  require_relative 'perftest/input_options'
  require_relative 'perftest/openshift'
  require_relative 'perftest/engine/apache_bench'
  require_relative 'perftest/log_content'
  require_relative 'perftest/test_log'
  require_relative 'action_controller'


  class Application

    def initialize(argv)
      @options = InputOptions::Parser.parse(argv)
      @options.command = "perftest #{argv.join(' ')}"

      @test_engine = Engine::ApacheBench if @options.engine == 'ab'
      @controller = ActionController.new(@options, @test_engine)

      begin
        run_action
      rescue Interrupt
        puts 'Application is closing...'
        exit
      end
    end

    def run_action
      @controller.send(@options.action)
    end

    class << self
      def run(argv)
        Application.new(argv)
      end
    end
  end
end
