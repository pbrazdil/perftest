module PerfTest
  class LogContent

    def initialize; end
    def to_s; @output; end

    def <<(value)
      @output ||= ''
      @output << "\n#{value}\n"
    end

  end
end