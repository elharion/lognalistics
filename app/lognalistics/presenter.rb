# frozen_string_literal: true

module Lognalistics
  class Presenter
    def initialize(presenters = nil)
      @presenters = presenters || {
        stdout: Presenters::Stdout
      }
    end

    def render(stats, output = :stdout, _presenters = nil)
      presenter = fetch_presenter(output)
      presenter.call(stats)
    end

    private

    attr_reader :presenters

    def fetch_presenter(output)
      presenters.fetch(output) { raise ArgumentError, 'Output format not supported' }
    end
  end
end
