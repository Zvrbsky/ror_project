require 'rails_helper'

RSpec.describe Host::EventsController do
  let(:host) { create :host }
  let(:event) {create :event }

  before do
    sign_in host
  end

  describe 'POST #create' do
    subject { post :create, params: event_params.merge(id: event.id)}

    let(:event_params) { event }

    it do
      expect(subject.status).to eq(200)
    end
  end

end