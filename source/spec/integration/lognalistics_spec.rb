# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'calculates log metrics' do
  after do
    # Since this is in memory
    # needs to be cleaned up between cases
    # would usually put it in spec_integration_helper.rb
    RuntimeMemoryStore.clear
  end

  let(:processor) { Lognalistics::Processor.new }
  let(:file_path) { 'spec/fixtures/server.log' }
  let(:output_type) { :stdout }

  subject { processor.call(file_path, types, output_type) }

  context 'when one metric type is provided' do
    let(:types) { [:total_views] }

    context 'when with total views option' do
      let(:types) { [:total_views] }

      context 'and when STDOUT output is set' do
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
          expect(subject).to eq([{
            'result' => [
              '/home - visits: 6',
              '/index - visits: 4',
              '/help_page - visits: 2'
            ]
          }.to_json])
        end
      end
    end

    context 'when with unique views option' do
      let(:types) { [:unique_views] }

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
          expect(subject).to eq([{
            'result' => [
              '/index - unique views: 3',
              '/help_page - unique views: 2',
              '/home - unique views: 2'
            ]
          }.to_json])
        end
      end
    end

    context 'when all views statistics are equal' do
      let(:file_path) { 'spec/fixtures/equal_views_server.log' }

      it 'returns all statistics sorted alphabeticaly by path' do
        expect { subject }.to output(
          "/aaa - visits: 2\n"\
          "/bbb - visits: 2\n"\
          "/ccc - visits: 2\n"
        ).to_stdout
      end
    end
  end

  context 'when multiple metric types are provided' do
    let(:types) { %i[total_views unique_views] }

    it 'returns statistics for all types' do
      expect { subject }.to output(
        "/home - visits: 6\n"\
        "/index - visits: 4\n"\
        "/help_page - visits: 2\n"\
        "/index - unique views: 3\n"\
        "/help_page - unique views: 2\n"\
        "/home - unique views: 2\n"
      ).to_stdout
    end
  end
end
