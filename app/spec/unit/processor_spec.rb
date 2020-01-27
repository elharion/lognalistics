# frozen_string_literal: true

RSpec.describe Lognalistics::Processor do
  describe '#generate_statistics' do
    subject { }

    it "returns :success" do
      expect(described_class.new.generate_statistics).to eq :success
    end
  end
end
