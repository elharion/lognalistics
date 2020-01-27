# frozen_string_literal: true

RSpec.describe Lognalistics::MetricsCalculator do

  # /index - 2 total views, 2 unique views
  # /home - 3 total views, 2 unique views
  # /about - 2 total views, 1 unique view
  let(:sample_data) do
    [
      { path: '/index', ip: '1' },
      { path: '/home', ip: '1' },
      { path: '/about', ip: '1' },
      { path: '/index', ip: '2' },
      { path: '/home', ip: '3' },
      { path: '/home', ip: '3' },
      { path: '/about', ip: '1' }
    ]
  end

  subject { described_class.new.call(sample_data, type) }

  context 'when :total_views option is provided' do
    let(:type) { :total_views }

    it 'calculates total views for pages' do
    end
  end

  context 'when with :unique_views option is provided' do
    let(:type) { :unique_views }

    it 'calculates unique views for pages' do
    end
  end
end
