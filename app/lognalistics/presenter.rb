# frozen_string_literal: true

module Lognalistics
  class Presenter
    PRESENTERS = {
      stdout: Presenters::Stdout
    }.freeze

    def render(stats, output = :stdout)
      formatter = fetch_formatter(output)
      formatter.present(stats)
    end

    private

    def fetch_formatter(output)
      PRESENTERS.fetch(output) { raise ArgumentError 'Output format not supported' }
    end
  end
end
