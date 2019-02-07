require 'rails_helper'

RSpec.describe Api::EventsController do
  describe 'GET #index' do
    subject { get :index, params: { search: search, cat: cat } }

    let(:cat) { [] }
    let!(:event1) { create :event, title: 'Top Kek' }
    let!(:event2) { create :event }
    let!(:event3) { create :event }

    context 'search is empty' do
      let(:search) { '' }
      it do
        expect(subject).to be_successful
        expect(JSON.parse(subject.body).length)
          .to eq(3)
      end
      context 'first word, second word, part of the word' do
        let(:search) { 'Top' }
        it do
          expect(subject).to be_successful
          expect(JSON.parse(subject.body)[0]['title'])
            .to eq('Top Kek')
        end

        let(:search) { 'Kek' }
        it do
          expect(subject).to be_successful
          expect(JSON.parse(subject.body)[0]['title'])
            .to eq('Top Kek')
        end

        let(:search) { 'op' }
        it do
          expect(subject).to be_successful
          expect(JSON.parse(subject.body)[0]['title'])
            .to eq('Top Kek')
        end
      end
    end
  end
end
