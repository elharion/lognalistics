# frozen_string_literal: true

RSpec.describe Lognalistics do
  subject { described_class.call(log_file, options) }

  let(:log_file) { File.open('spec/fixtures/server.log') }

  context 'when checked for most views statistics' do
    let(:options) { :views }

    it 'displays most viewed pages' do
      expect(subject).to eq(
        [
          ['/home', 6],
          ['/index', 4],
          ['/help_page', 2]
        ]
      )
    end
  end

  context 'displays unique views' do
    let(:options) { :unique_views }

    it 'returns unique site entries' do
      expect(subject).to eq(
        [
          ['/index', 3],
          ['/help_page', 2],
          ['/home', 2]
        ]
      )
    end
  end
end
