describe IkedaNote::EventsController, type: :controller do
  describe '#create' do
    subject { post :create, params: { event: event_params } }

    let(:logined_user) { create(:user) }

    let(:event_params) { { name: 'test_name', occurrence_year: 2017 } }

    before do
      sign_in logined_user, scope: :user
    end

    it do
      subject
      expect(response).to redirect_to action: :index
    end

    it { expect { subject }.to change { Event.count }.by(1) }
  end
end
