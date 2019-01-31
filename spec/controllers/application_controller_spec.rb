require 'rails_helper'

RSpec.describe ApplicationController do
  describe 'GET index' do
    subject { get :index }
    context 'guest created successfully' do
      it do
        expect(controller.current_guest).to be_a(Guest)
      end
    end
  end
end
