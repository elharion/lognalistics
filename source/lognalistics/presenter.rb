# frozen_string_literal: true

module Lognalistics
  class Presenter
    def initialize(presenters = nil)
      @presenters = presenters || {
        stdout: Presenters::Stdout,
        json: Presenters::Json
      }
    end

    def call(output = :stdout)
      presenter = fetch_presenter(output)
    end

    private

    attr_reader :presenters

    def fetch_presenter(output)
      presenters.fetch(output) { raise ArgumentError, 'Output format not supported' }
    end
  end
end
