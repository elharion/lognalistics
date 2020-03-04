# frozen_string_literal: true

RSpec.describe Lognalistics::Presenters::Json do
  let(:sample_data) do
    {
      '/app' => { total_views: 15 },
      '/help' => { unique_views: 10 }
    }
  end

  let(:subject) { described_class.call(sample_data) }

  describe '#call' do
    it 'returns output' do
      expect(subject).to eq(
        { result: ['/app - visits: 15', '/help - unique views: 10'] }.to_json
      )
    end
  end
end
