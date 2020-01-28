# frozen_string_literal: true

RSpec.describe Lognalistics::Presenter do
  describe '#render' do
    subject { described_class.new(presenters).render(data, output_format) }

    let(:data) { 'dummy' }

    context 'when existing presenter is used' do
      let(:output_format) { :stdout }
      let(:presenter_double) { double(call: true) }
      let(:presenters) do
        { output_format => presenter_double }
      end

      it 'selects and triggers format presenter' do
        expect(presenter_double)
          .to receive(:call)
          .with(data)

        subject
      end
    end

    context 'when not existing presenter is used' do
      let(:presenter_double) { double }
      let(:output_format) { :html }
      let(:presenters) do
        { json: presenter_double }
      end

      it 'selects and triggers format presenter' do
        expect { subject }.to raise_error(ArgumentError, 'Output format not supported')
      end
    end
  end
end
