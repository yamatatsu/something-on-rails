describe IkedaNote::EventsController, type: :controller do
  let(:logined_user) { create(:user) }

  before do
    sign_in :user, logined_user
  end

  describe 'GET /ikeda_note_events' do
    subject { get :index }

    it do
      subject
      expect(response).to render_template :index
    end
  end

  describe 'GET /ikeda_note_events/new' do
    subject { get :new }

    it do
      subject
      expect(response).to render_template :new
    end
  end

  describe 'POST /ikeda_note_events' do
    subject { post :create, params: { event: event_params } }

    let(:event_params) { { name: 'test_name', occurrence_year: 'test_occurrence_year' } }

    it do
      subject
      expect(response).to redirect_to action: :index
    end
  end
end
