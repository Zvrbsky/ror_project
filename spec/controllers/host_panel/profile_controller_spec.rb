require 'rails_helper'

RSpec.describe HostPanel::ProfileController do
  let!(:host1) { create :host }
  let!(:host2) { create :host }
  let!(:event1_h2) { create :event, host: host2 }
  let!(:event2_h2) { create :event, host: host2 }

  before do
    sign_in host1
  end

  describe '#index' do
    context 'when host did not create any events' do
      subject { controller.index }
      it do
        is_expected.to be_empty
      end

      context 'when host created events' do
        let!(:event1_h1) { create :event, host: host1 }
        let!(:event2_h1) { create :event, host: host1 }

        it do
          is_expected.to eq([event1_h1, event2_h1])
        end

        context 'hosts do not share events' do
          before do
            sign_in host2
          end

          it do
            is_expected.to eq([event1_h2, event2_h2])
          end
        end
      end
    end
  end
end
