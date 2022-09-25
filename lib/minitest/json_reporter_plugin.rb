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
    attr_accessor :io, :results

    def initialize(options)
      @io = options[:io]
      @results = []
    end

    def record(result)
      line = result.source_location[-1]
      failure = result.failures[0]

      if failure
        # "/Users/marcusheng/projects/rails/budgetyourtime/test/models/user_test.rb:11"
        line = failure.location.split("/")[-1].split(":")[-1]
      end

      results << {
        name: result.name,
        status: result.passed? ? "PASS" : "FAIL",
        failures: failure.error.to_s,
        line: line.to_i
      }.to_json
    end

    def report
      results.each { |result| io.puts result }
    end
  end
end
