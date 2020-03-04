# frozen_string_literal: true

RSpec.describe Lognalistics::Parser do
  describe '#each_line' do
    subject { described_class.new(file_path) }

    let(:file_path) { 'spec/fixtures/server.log' }
    let(:log_entries_count) { 12 }

    it 'parses entries' do
      entries = []
      subject.each_line { |line| entries.push(line) }

      expect(entries.count).to eq log_entries_count
      expect(entries).to all include(:path, :ip)
    end
  end
end
