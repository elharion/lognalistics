# frozen_string_literal: true

RSpec.describe Lognalistics::Processor do
  describe '#generate_statistics' do
    let(:log_repo_double) { instance_double('Lognalistics::LogRepository', save: true) }
    let(:parser_double) { instance_double('Lognalistics::Parser')}
    let(:parser_class_double) { class_double('Lognalistics::Parser', new: parser_double) }

    let(:entry) { { path: 'foo', ip: 'bar' } }

    before do
      allow(parser_double)
        .to receive(:each_line)
        .and_yield(entry)
    end

    subject do
      described_class.new(
        parser: parser_class_double,
        log_repo: log_repo_double
      ).generate_statistics("foobar")
    end

    it "returns :success" do
      expect(log_repo_double)
        .to receive(:save)
        .with(path: entry[:path], ip: entry[:ip])

      expect(subject).to eq :success
    end
  end
end
