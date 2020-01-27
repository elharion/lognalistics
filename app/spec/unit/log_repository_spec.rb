# frozen_string_literal: true

RSpec.describe Lognalistics::LogRepository do
  let(:repository) { described_class.new(store: store) }
  let(:store) { double('Array', push: true) }

  describe '#save' do
    subject { repository.save(path: entry[:path], ip: entry[:ip]) }
    let(:entry) { { path: '/home', ip: '192.168.1.1' } }

    it 'persists entry' do
      expect(store)
        .to receive(:push)
        .with(entry)
        .and_return(true)

      expect(subject).to eq(entry)
    end
  end
end
