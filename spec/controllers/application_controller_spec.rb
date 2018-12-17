require 'rails_helper'

RSpec.describe ApplicationController do
  describe 'POST #current_guest' do
    subject { post :current_guest, params[guest_id: 1] }
    context 'guest does not exist' do
    end
  end
end
