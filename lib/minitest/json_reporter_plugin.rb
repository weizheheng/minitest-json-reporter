# frozen_string_literal: true

require "minitest"
require "json"

module Minitest
  def self.plugin_json_reporter_init(options)
    if options[:json]
      Minitest.reporter.reporters.clear
      Minitest.reporter << JsonReporter.new(options)
    end
  end

  def self.plugin_json_reporter_options(opts, options)
    opts.on("--json", "Json dump") { |_json| options[:json] = true }
  end

  class JsonReporter < AbstractReporter
    attr_accessor :io, :results, :assertions, :failures

    def initialize(options)
      @io = options[:io]
      @results = []
      @assertions = 0
      @failures = 0
    end

    def record(result)
      self.assertions += result.assertions
      self.failures += result.failures.size

      line = result.source_location[-1]
      failure = result.failures[0]

      if failure && !failure.is_a?(Minitest::UnexpectedError)
        # "/Users/marcusheng/projects/rails/sample_project/test/models/user_test.rb:11"
        line = failure.location.split("/")[-1].split(":")[-1]
      end

      results << {
        name: result.name,
        status: result.passed? ? "PASS" : "FAIL",
        failures: failure ? failure.error.to_s : "",
        line: line.to_i
      }.to_json
    end

    def report
      io.write(
        JSON.dump(
          {
            examples: results,
            statistics: {
              assertions: assertions,
              failures: failures
            }
          }
        )
      )
      # results.each { |result| io.write "\n#{result}" }
    end
  end
end
