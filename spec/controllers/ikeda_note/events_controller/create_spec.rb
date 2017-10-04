describe IkedaNote::EventsController, type: :controller do
  describe '#create' do
    subject { post :create, params: { event: event_params } }

    let(:logined_user) { create(:user) }

    let(:event_params) { { name: name, occurrence_year: occurrence_year, event_people_attributes: event_people_attributes } }
    let(:name) { 'test_name' }
    let(:occurrence_year) { 2017 }
    let(:event_people_attributes) do
      [
        { person_id: person_1.id, _destroy: false },
        { person_id: person_2.id, _destroy: false },
      ]
    end
    let(:person_1) { create(:person, name: 'person_1', team: team_1, user: logined_user) }
    let(:person_2) { create(:person, name: 'person_2', team: team_1, user: logined_user) }
    let(:team_1) { create(:team, user: logined_user) }

    before do
      person_1
      person_2

      sign_in logined_user, scope: :user
    end

    describe '応答' do
      before { subject }

      context '正常系のとき' do
        it { expect(response).to redirect_to action: :index }
      end

      context 'nameが空文字のとき' do
        let(:name) { '' }

        it { expect(response).to render_template :new }
        it { expect(assigns(:event).errors.messages[:name]).to include("can't be blank") }
      end

      context 'nameが30文字を超えるとき' do
        let(:name) { '0000000001000000000200000000031' }

        it { expect(response).to render_template :new }
        it { expect(assigns(:event).errors.messages[:name]).to include('is too long (maximum is 30 characters)') }
      end

      context 'occurrence_yearが空文字のとき' do
        let(:occurrence_year) { '' }

        it { expect(response).to render_template :new }
        it { expect(assigns(:event).errors.messages[:occurrence_year]).to include("can't be blank") }
      end

      context 'occurrence_yearが数字以外のとき' do
        let(:occurrence_year) { 'something_string' }

        it { expect(response).to render_template :new }
        it { expect(assigns(:event).errors.messages[:occurrence_year]).to include('is not a number') }
      end
    end

    describe '副作用' do
      context '正常系のとき' do
        it { expect { subject }.to change { logined_user.events.count }.by(1) }
        it { expect { subject }.to change { logined_user.events.last&.name }.to(name) }
        it { expect { subject }.to change { logined_user.events.last&.occurrence_year }.to(occurrence_year) }
        it { expect { subject }.to change { logined_user.events.last&.people&.count }.from(nil).to(2) }
        it { expect { subject }.to change { logined_user.events.last&.people&.first&.name }.to(person_1.name) }
        it { expect { subject }.to change { logined_user.events.last&.people&.second&.name }.to(person_2.name) }
      end
    end
  end
end
