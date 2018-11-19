require 'rails_helper'

RSpec.describe Event do
  describe '#search_by_name' do
    subject { Event.search('')}

    context 'when there are no events' do
      it {is_expected.to be_empty}
    end


    context 'when there is one event' do
      let!(:event1) { FactoryBot.create :event }

      subject { Event.search(event1.title)}

      it {is_expected.to eq([event1])}

      context 'when search name does not match' do
        subject { Event.search('kek')}

        it {is_expected.to be_empty}

        context 'when there more events' do
          let!(:event2) { FactoryBot.create :event }

          subject { Event.search(nil)}

          it {is_expected.to eq([event1, event2])}

        end

      end
    end



  end

end