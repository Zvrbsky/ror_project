require 'rails_helper'

RSpec.describe UserPanel::OrdersController do
  let(:guest) { create :guest }

  let(:user) { create :user }

  let!(:event_user_t) { create :event }
  let!(:order_user_t) { create :order, owner_id: user.id, owner_type: 'User', status: 'pending' }
  let!(:order_user_item_t) { create :order_item, order_id: order_user_t.id, event_id: event_user_t.id }

  let!(:event_guest_t) { create :event }
  let!(:order_guest_t) { create :order, owner_id: guest.id, owner_type: 'Guest', status: 'pending' }
  let!(:order_item_t) { create :order_item, order_id: order_guest_t.id, event_id: event_guest_t.id }

  let!(:event_guest_nt) { create :event, amount: 0 }
  let!(:order_guest_nt) { create :order, owner_id: guest.id, owner_type: 'Guest', status: 'pending' }
  let!(:order_item_nt) { create :order_item, order_id: order_guest_nt.id, event_id: event_guest_nt.id }

  before do
    cookies.signed[:guest_id] = { value: guest.id, expires: 1.month.from_now }
    sign_in user
  end

  describe 'GET #show' do
    context 'order is not attached' do
      context 'no tickets available' do
        subject { get :show, params: { id: order_guest_nt.id } }

        it do
          subject
          expect(controller.flash[:notice]).to eq('No tickets available')
        end

        it do
          expect(subject).to redirect_to(user_panel_orders_path(user))
        end
      end

      context 'tickets available' do
        subject { get :show, params: { id: order_guest_t.id } }

        it do
          expect { subject }.to change { order_guest_t.reload.owner_id }.from(guest.id).to(user.id)
        end
      end
    end

    context 'order is attached' do
      subject { get :show, params: { id: order_user_t.id } }

      it do
        subject
        expect(assigns(:order)).to eq(order_user_t)
      end
    end

    context 'order does not exits' do
      subject { get :show, params: { id: -1 } }

      it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end

  describe 'GET #index' do
    subject { get :index }

    it do
      subject
      expect(assigns(:orders)).to eq([order_user_t])
    end
  end

  describe 'POST #confirm' do
    subject { post :confirm, params: { id: order_user_t.id } }

    it do
      expect { subject }.to change { order_user_t.reload.status }.from(Order::PENDING_STATUS).to(Order::COMPLETE_STATUS)

      expect(subject).to redirect_to(user_panel_order_path(order_user_t))
    end
  end
end
