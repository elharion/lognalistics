RSpec.describe Lognalistics::LogRepository do
  let(:repository) { described_class.new(store: store_double) }
  let(:store_double) { double(push: entry) }

  describe '#save' do
    subject { repository.save(entry) }
    let(:entry) { { path: '/home', ip: '192.168.1.1' } }

    it 'persists entry in memory' do
      expect(store_double)
        .to receive(:push)
        .with(entry)
        .and_return(entry)

      subject
    end
  end
end
