# frozen_string_literal: true

module Lognalistics
  class Presenter
    PRESENTERS = {
      'stdout' => Presenters::Stdout,
      'json' => Presenters::Json
    }.freeze
    private_constant :PRESENTERS

    def initialize(presenters = nil)
      @presenters = presenters || PRESENTERS
    end

    def call(output = :stdout)
      presenter = fetch_presenter(output)
    end

    private

    attr_reader :presenters

    def fetch_presenter(output)
      presenters.fetch(output) { raise ArgumentError, SimpleLocale.t('errors.output_not_supported', output: output) }
    end
  end
end
