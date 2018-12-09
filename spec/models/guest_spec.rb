require 'rails_helper'

RSpec.describe Guest do
  describe '.cart' do
    let!(:guest1) { FactoryBot.create :guest }
    subject { guest1.cart }

    context "when there are not any guest's orders" do
      it 'should create new one and assign it to guest' do
        expect(subject.owner_id).to eq(guest1.id)
        expect(subject.owner_type).to eq('Guest')
      end
    end

    context "when there is one guest's order" do
      let!(:order1) { FactoryBot.create :order, owner_id: guest1.id, owner_type: 'Guest', status: 'pending' }
      subject { guest1.cart }

      it 'should return this order' do
        is_expected.to eq(order1)
      end
    end

    context "when there are many guest's orders" do
      let!(:order1) { FactoryBot.create :order, owner_id: guest1.id, owner_type: 'Guest', status: 'pending' }
      let!(:order2) { FactoryBot.create :order, owner_id: guest1.id, owner_type: 'Guest', status: 'pending' }
      let!(:order3) { FactoryBot.create :order, owner_id: guest1.id, owner_type: 'Guest', status: 'pending' }
      subject { guest1.cart }

      it 'should return first order' do
        is_expected.to eq(order1)
      end
    end
  end
end
