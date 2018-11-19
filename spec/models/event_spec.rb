require 'rails_helper'

RSpec.describe Event do
  describe '#search_by_name' do
    subject { Event.search('') }

    context 'when there are no events' do
      it 'should return empty' do
        is_expected.to be_empty
      end
    end

    context 'when there is one event' do
      let!(:event1) { FactoryBot.create :event }
      subject { Event.search(event1.title) }

      it "with event's name should return event" do
        is_expected.to eq([event1])
      end
    end

    context 'when there is one event' do
      subject { Event.search('kek') }

      it "not with event's name should return empty" do
        is_expected.to be_empty
      end
    end

    context 'when there more events' do
      let!(:event1) { FactoryBot.create :event }
      let!(:event2) { FactoryBot.create :event }
      subject { Event.search(nil) }

      it 'without argument should return all events' do
        is_expected.to eq([event1, event2])
      end
    end
  end

  describe '#filter_by_category' do
    subject { Event.filter('') }

    context 'when there are no events' do
      it 'should return empty' do
        is_expected.to be_empty
      end
    end

    context 'when there is one event' do
      let!(:event1) { FactoryBot.create :event }

      subject { Event.filter(event1.category) }

      it "with event's category should return event" do
        is_expected.to eq([event1])
      end
    end

    context 'when there more events' do
      let!(:event1) { FactoryBot.create :event }
      let!(:event2) { FactoryBot.create :event }

      subject { Event.filter('All') }

      it 'with all category should return all events' do
        is_expected.to eq([event1, event2])
      end
    end
  end
end
