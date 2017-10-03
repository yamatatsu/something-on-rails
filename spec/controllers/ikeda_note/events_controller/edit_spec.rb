describe IkedaNote::EventsController, type: :controller do
  describe '#edit' do
    subject { get :edit, params: { id: event_1.id } }

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
      expect(response).to render_template :edit
    end
  end
end
