describe IkedaNote::EventsController, type: :controller do
  describe '#update' do
    subject { put :update, params: { id: event_1.id, event: event_params } }

    let(:event_params) { { name: 'test_name', occurrence_year: 2017 } }

    let(:logined_user) { create(:user) }

    let(:team_1) { create(:team, user: logined_user) }
    let(:person_1) { create(:person, team: team_1, user: logined_user) }
    let(:person_2) { create(:person, team: team_1, user: logined_user) }
    let(:event_1) { create(:event, user: logined_user, name: 'pre', occurrence_year: 1) }

    before do
      create(:event_person, event: event_1, person: person_1)
      create(:event_person, event: event_1, person: person_2)

      sign_in logined_user, scope: :user
    end

    it do
      subject
      expect(response).to redirect_to action: :index
    end

    it { expect { subject }.to change { Event.find(event_1.id).name }.from('pre').to('test_name') }
    it { expect { subject }.to change { Event.find(event_1.id).occurrence_year }.from(1).to(2017) }
  end
end
