describe IkedaNote::EventsController, type: :controller do
  describe '#update' do
    subject { put :update, params: { id: event_1.id, event: event_params } }

    let(:logined_user) { create(:user) }

    let(:event_params) { { name: name, occurrence_year: occurrence_year, event_people_attributes: event_people_attributes } }
    let(:name) { 'test_name' }
    let(:occurrence_year) { 2017 }
    let(:event_people_attributes) do
      [
        { id: event_person_1.id, person_id: person_1.id, _destroy: false },
        { id: event_person_2.id, person_id: person_2.id, _destroy: true },
        { person_id: person_3.id, _destroy: false },
      ]
    end

    let(:event_1) { create(:event, user: logined_user, name: pre_name, occurrence_year: pre_occurrence_year) }
    let(:pre_name) { 'pre' }
    let(:pre_occurrence_year) { 1 }
    let(:event_person_1) { create(:event_person, event: event_1, person: person_1) }
    let(:event_person_2) { create(:event_person, event: event_1, person: person_2) }
    let(:person_1) { create(:person, name: 'person_1', team: team_1, user: logined_user) }
    let(:person_2) { create(:person, name: 'person_2', team: team_1, user: logined_user) }
    let(:person_3) { create(:person, name: 'person_3', team: team_1, user: logined_user) }
    let(:team_1) { create(:team, user: logined_user) }

    before do
      person_1
      person_2
      person_3
      event_person_1
      event_person_2
      sign_in logined_user, scope: :user
    end

    describe '応答' do
      before { subject }

      context '正常系のとき' do
        it { expect(response).to redirect_to action: :index }
        it { expect(assigns(:event).errors).to be_empty }
      end

      context 'nameが空文字のとき' do
        let(:name) { '' }

        it { expect(response).to render_template :edit }
        it { expect(assigns(:event).errors.messages[:name]).to include("can't be blank") }
      end

      context 'nameが30文字を超えるとき' do
        let(:name) { '0000000001000000000200000000031' }

        it { expect(response).to render_template :edit }
        it { expect(assigns(:event).errors.messages[:name]).to include('is too long (maximum is 30 characters)') }
      end

      context 'occurrence_yearが空文字のとき' do
        let(:occurrence_year) { '' }

        it { expect(response).to render_template :edit }
        it { expect(assigns(:event).errors.messages[:occurrence_year]).to include("can't be blank") }
      end

      context 'occurrence_yearが数字以外のとき' do
        let(:occurrence_year) { 'something_string' }

        it { expect(response).to render_template :edit }
        it { expect(assigns(:event).errors.messages[:occurrence_year]).to include('is not a number') }
      end
    end

    describe '副作用' do
      context '正常系のとき' do
        it { expect { subject }.to change { event_1.reload.name }.from(pre_name).to(name) }
        it { expect { subject }.to change { event_1.reload.occurrence_year }.from(pre_occurrence_year).to(occurrence_year) }
        it { expect { subject }.to change { event_1.reload.people.count }.by(0) }
        it { expect { subject }.to change { event_1.reload.people.second.name }.from(person_2.name).to(person_3.name) }
      end
    end
  end
end
