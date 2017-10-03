describe IkedaNote::EventsController, type: :controller do
  describe '#index' do
    subject { get :index }

    let(:logined_user) { create(:user) }

    let(:team_1) { create(:team, user: logined_user) }
    let(:team_2) { create(:team, user: logined_user) }
    let(:person_1) { create(:person, team: team_1, user: logined_user) }
    let(:person_2) { create(:person, team: team_1, user: logined_user) }
    let(:person_3) { create(:person, team: team_2, user: logined_user) }
    let(:person_4) { create(:person, team: team_2, user: logined_user) }
    let(:event_1) { create(:event, user: logined_user, name: 'pre', occurrence_year: 1) }
    let(:event_2) { create(:event, user: logined_user) }

    before do
      create(:event_person, event: event_1, person: person_1)
      create(:event_person, event: event_1, person: person_2)
      create(:event_person, event: event_2, person: person_1)
      create(:event_person, event: event_2, person: person_2)
      create(:event_person, event: event_2, person: person_3)
      create(:event_person, event: event_2, person: person_4)

      sign_in logined_user, scope: :user
    end

    it do
      subject
      expect(response).to render_template :index
    end

    it '@event が作られること' do
      subject
      expect(assigns(:events)).to eq([event_1, event_2])
    end
  end
end
