# frozen_string_literal: true

RSpec.describe Lognalistics::Presenters::Stdout do
  let(:sample_data) do
    {
      '/app' => { total_views: 15 },
      '/help' => { unique_views: 10 }
    }
  end

  let(:subject) { described_class.call(sample_data) }

  describe '#call' do
    it "prints output" do
      expect { subject }.to output(
        "/app - visits: 15\n/help - unique views: 10\n"
      ).to_stdout
    end
  end
end
