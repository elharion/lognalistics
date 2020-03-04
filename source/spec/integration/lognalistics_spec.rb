# frozen_string_literal: true

RSpec.describe 'calculates pages statistics' do
  after do
    # Since this is in memory
    # needs to be cleaned up between cases
    # would usually put it in spec_integration_helper.rb
    RuntimeMemoryStore.clear
  end

  let(:processor) { Lognalistics::Processor.new }

  let(:type) { :total_views }
  let(:output_type) { :stdout }
  let(:file_path) { 'spec/fixtures/server.log' }

  subject { processor.generate_statistics(file_path, type, output_type) }

  context 'when with total views option' do
    let(:type) { :total_views }

    context 'when STDOUT output is set' do
      let(:type) { :total_views }
      let(:output_type) { :stdout }

      it 'prints statistics to STDOUT in deescending order' do
        expect { subject }.to output(
          "/home - visits: 6\n"\
          "/index - visits: 4\n"\
          "/help_page - visits: 2\n"
        ).to_stdout
      end
    end

    context 'when JSON output is set' do
      let(:output_type) { :json }

      it 'returns statistics as JSON  in deescending order' do
        expect(subject).to eq({
          'result' => [
            '/home - visits: 6',
            '/index - visits: 4',
            '/help_page - visits: 2'
          ]
        }.to_json)
      end
    end
  end

  context 'when with unique views option' do
    let(:type) { :unique_views }

    context 'when STDOUT output is set' do
      let(:output_type) { :stdout }

      it 'prints statistics to STDOUT in deescending order' do
        expect { subject }.to output(
          "/index - unique views: 3\n"\
          "/help_page - unique views: 2\n"\
          "/home - unique views: 2\n"
        ).to_stdout
      end
    end

    context 'when JSON output is set' do
      let(:output_type) { :json }

      it 'returns statistics as JSON in deescending order' do
        expect(subject).to eq({
          'result' => [
            '/index - unique views: 3',
            '/help_page - unique views: 2',
            '/home - unique views: 2'
          ]
        }.to_json)
      end
    end
  end
end
