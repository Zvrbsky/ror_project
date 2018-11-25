require 'rails_helper'

RSpec.describe HomePageViewModel do
  describe '#featured_events' do
    context 'when there are no events' do
      subject { described_class.new.featured_events }

      it 'should return empty' do
        is_expected.to be_empty
      end
    end

    context 'when events exist' do
      let!(:event1) { FactoryBot.create :event }
      let!(:event2) { FactoryBot.create :event }
      let!(:event3) { FactoryBot.create :event }
      let!(:event4) { FactoryBot.create :event }
      subject { described_class.new.featured_events }

      it 'should return last 3' do
        is_expected.to eq([event4, event3, event2])
      end
    end
  end

  describe '#closest_events' do
    context 'when there are no events' do
      subject { described_class.new.closest_events }

      it 'should return empty' do
        is_expected.to be_empty
      end
    end
    context 'when events exist' do
      let!(:event1) { FactoryBot.create :event, date: '2017-01-01' }
      let!(:event2) { FactoryBot.create :event, date: '2017-05-01' }
      let!(:event3) { FactoryBot.create :event, date: '2017-03-01' }
      let!(:event4) { FactoryBot.create :event, date: '2017-10-01' }
      subject { described_class.new.closest_events }

      it 'should return closest 3' do
        is_expected.to eq([event1, event3, event2])
      end
    end
  end
end
