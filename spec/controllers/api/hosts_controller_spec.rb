require 'rails_helper'

RSpec.describe Api::HostsController do
  describe 'GET #email_exists' do
    subject { get :email_exists, params: { email: email } }
    let(:email) { 'test@test.com' }

    it do
      expect(subject).to be_successful
      expect(JSON.parse(subject.body)).to eq(false)
    end

    context 'when email is taken' do
      let(:host) { create :host }
      let(:email) { host.email }

      it do
        expect(subject).to be_successful
        expect(JSON.parse(subject.body)).to eq(true)
      end
    end
  end
end
