# frozen_string_literal: true

RSpec.describe Lognalistics::Presenter do
  describe '#render' do
    context 'when format is :stdout' do
      let(:output_format) { :stdout }
      let(:formatter_double) { double }
      subject { described_class.new.render(output_format, data) }
      let(:data) { { some: :data } }

      it 'selects and triggers format presenter' do
        expect(Lognalistics::Presenter::PRESENTERS)
          .to receive(:fetch)
          .with(output_format)
          .and_return(formatter_double)

        expect(formatter_double)
          .to receive(:present)
          .with(data)

        subject
      end
    end
  end
end
