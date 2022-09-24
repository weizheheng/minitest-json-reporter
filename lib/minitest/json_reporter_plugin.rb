# frozen_string_literal: true

require "json"

module Minitest
  class JsonReporter < AbstractReporter
    def start
    end

    def record
    end

    def report
      super

      json_report = { test: "name of the test" }
      io.write(JSON.dump(json_report))
    end
  end
end
