require 'rails_helper'

RSpec.describe Host::EventsController do
  let(:host) { create :host }
  let(:event0) { create :event, host: host}


  before do
    sign_in host
  end

  describe 'POST #create' do
    subject { post :create, params: event_params}

    context 'not enough arguments, event not created' do
      let(:event_params) { {event: {title: 'abcd'}} }

      it do
        expect(subject.status).to eq(200)
      end

      #it do
      #  expect(subject).to render_template(Event.new)
      #end

      context 'event created successfully' do
        let(:event_params) { {event: {title: 'abcd',
                                      content: 'kek',
                                      amount: 2,
                                      date: Faker::Date.forward(2),
                                      category: 'Metal',
                                      price: 20 }} }

        it do
          expect(subject.status).to eq(302)
        end

        it do
          subject
          expect(controller.flash[:notice]).to eq('Event was successfully created.')
        end

        it do
          expect(subject).to redirect_to(host_panel_root_path)
        end
      end
    end
  end
=begin
  describe 'PUT #update' do
    subject { put :update, params: event_params}

    let(:event_params) { {event: {title: 'abcd',
                                       content: 'kek',
                                       amount: 2,
                                       date: Faker::Date.forward(2),
                                       category: 'Pop',
                                       price: 20 }} }
    it do
      expect(subject.status).to eq(302)
    end

    it do
      subject
      expect(controller.flash[:notice]).to eq('Event was successfully updated.')
    end

    it do
      expect(subject).to redirect_to(host_panel_root_path)
    end
  end
=end



end
