# frozen_string_literal: true

RSpec.describe Lognalistics::Processor do
  describe '#generate_statistics' do
    let(:log_repo_double) { instance_double('Lognalistics::LogRepository', save: true, all: [entry]) }
    let(:parser_double) { instance_double('Lognalistics::Parser') }
    let(:parser_class_double) { class_double('Lognalistics::Parser', new: parser_double) }
    let(:metric_calc_double) { instance_double('Lognalistics::MetricsCalculator') }

    let(:entry) { { path: 'foo', ip: 'bar' } }
    let(:type) { 'sample-type' }
    let(:stats_double) { double }
    before do
      allow(parser_double)
        .to receive(:each_line)
        .and_yield(entry)
    end

    subject do
      described_class.new(
        parser: parser_class_double,
        log_repo: log_repo_double,
        metric_calc: metric_calc_double
      ).generate_statistics('foobar', type)
    end

    it 'successfuly runs logs processing' do
      expect(parser_double)
        .to receive(:each_line).and_yield(entry)
      expect(log_repo_double)
        .to receive(:save)
        .with(path: entry[:path], ip: entry[:ip])
      expect(metric_calc_double)
        .to receive(:call)
        .with([entry], type)
        .and_return(stats_double)

      expect(subject).to eq :success
    end
  end
end
