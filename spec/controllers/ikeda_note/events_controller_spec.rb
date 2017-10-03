describe IkedaNote::EventsController, type: :controller do
  let(:logined_user) { create(:user) }

  let(:team_1) { create(:team, user: logined_user) }
  let(:team_2) { create(:team, user: logined_user) }
  let(:person_1) { create(:person, team: team_1, user: logined_user) }
  let(:person_2) { create(:person, team: team_1, user: logined_user) }
  let(:person_3) { create(:person, team: team_2, user: logined_user) }
  let(:person_4) { create(:person, team: team_2, user: logined_user) }

  let(:event_1) { create(:event, user: logined_user, name: 'pre', occurrence_year: 1) }
  let(:event_2) { create(:event, user: logined_user) }
  let(:event_person_1) { create(:event_person, event: event_1, person: person_1) }
  let(:event_person_2) { create(:event_person, event: event_1, person: person_2) }
  let(:event_person_3) { create(:event_person, event: event_2, person: person_1) }
  let(:event_person_4) { create(:event_person, event: event_2, person: person_2) }
  let(:event_person_5) { create(:event_person, event: event_2, person: person_3) }
  let(:event_person_6) { create(:event_person, event: event_2, person: person_4) }

  before do
    create(:event_person, event: event_1, person: person_1)
    create(:event_person, event: event_1, person: person_2)
    create(:event_person, event: event_2, person: person_1)
    create(:event_person, event: event_2, person: person_2)
    create(:event_person, event: event_2, person: person_3)
    create(:event_person, event: event_2, person: person_4)

    sign_in logined_user, scope: :user
  end

  describe '#index' do
    subject { get :index }

    it do
      subject
      expect(response).to render_template :index
    end

    it '@event が作られること' do
      subject
      expect(assigns(:events)).to eq([event_1, event_2])
    end
  end

  describe '#new' do
    subject { get :new }

    it do
      subject
      expect(response).to render_template :new
    end
  end

  describe '#create' do
    subject { post :create, params: { event: event_params } }

    let(:event_params) { { name: 'test_name', occurrence_year: 2017 } }

    it do
      subject
      expect(response).to redirect_to action: :index
    end

    it { expect { subject }.to change { Event.count }.by(1) }
  end

  describe '#edit' do
    subject { get :edit, params: { id: event_1.id } }

    it do
      subject
      expect(response).to render_template :edit
    end
  end

  describe '#update' do
    subject { put :update, params: { id: event_1.id, event: event_params } }

    let(:event_params) { { name: 'test_name', occurrence_year: 2017 } }

    it do
      subject
      expect(response).to redirect_to action: :index
    end

    it { expect { subject }.to change { Event.find(event_1.id).name }.from('pre').to('test_name') }
    it { expect { subject }.to change { Event.find(event_1.id).occurrence_year }.from(1).to(2017) }
  end

  describe '#destroy' do
    subject { delete :destroy, params: { id: event_1.id } }

    it do
      subject
      expect(response).to redirect_to action: :index
    end

    it { expect { subject }.to change { Event.count }.by(-1) }
  end
end
