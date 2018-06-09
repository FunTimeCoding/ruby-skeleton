if ENV['COVERAGE'] == 'on'
  require 'simplecov'
  require 'simplecov-rcov'
  class SimpleCov
    class Formatter
      class MergedFormatter
        def format(result)
          SimpleCov::Formatter::HTMLFormatter.new.format(result)
          SimpleCov::Formatter::RcovFormatter.new.format(result)
        end
      end
    end
  end
  SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter
  SimpleCov.start do
    coverage_dir 'build/simplecov'
    add_filter '/vendor/'
  end
end
