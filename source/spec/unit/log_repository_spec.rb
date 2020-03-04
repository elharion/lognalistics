# frozen_string_literal: true

RSpec.describe Lognalistics::LogRepository do
  let(:repository) { described_class.new(store: store) }
  let(:store) { [] }

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

  describe '#all' do
    subject { repository.all }

    let(:sample) { { foo: :bar } }

    before { store.push(sample) }

    it 'returns everything from store' do
      expect(subject).to contain_exactly(sample)
    end
  end
end
