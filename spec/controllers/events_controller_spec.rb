require 'rails_helper'

RSpec.describe EventsController do

  let(:event)  { create :event }

  describe 'GET #add_to_cart' do
    subject { get :add_to_cart, params: { id: event.id } }

    before do
      allow(AddToCart).to receive(:run).and_return(outcome)
    end

    context 'when guest can add item to cart' do
      let(:outcome) { instance_double(AddToCart, valid?: true) }

      it do
        subject
        expect(controller.flash[:notice]).to eq('Added to cart')
      end

      it do
        expect(subject).to redirect_to(event_path)
      end
    end

    context 'when guest can not add item to cart' do
      let(:outcome) { instance_double(AddToCart, valid?: false, errors: errors) }
      let(:errors) { Struct.new(:full_messages).new('Item is not available') }

      it do
        subject
        expect(controller.flash[:notice]).to eq('Item is not available')
      end

      it do
        expect(subject).to redirect_to(event_path)
      end
    end
  end
end