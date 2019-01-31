require 'rails_helper'

RSpec.describe CartsController do
  describe 'GET #index' do
    subject { get :index }

    context 'cart assigned' do
      it do
        expect(subject.status).to eq(200)
      end
    end
  end

  describe 'POST #confirm' do
    let(:order) { create :order, owner_id: controller.current_guest.id, owner_type: 'Guest', status: 'cart' }

    subject { post :confirm, params: { id: order.id } }

    it do
      expect { subject }.to change { order.reload.status }.from(Order::CART_STATUS).to(Order::PENDING_STATUS)

      expect(subject).to redirect_to(user_panel_order_path(order))
    end
  end
end
