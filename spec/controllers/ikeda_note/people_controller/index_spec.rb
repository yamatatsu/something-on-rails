describe IkedaNote::PeopleController, type: :controller do
  describe '#index' do
    subject { get :index }

    let(:logined_user) { create(:user) }

    let(:team_1) { create(:team, user: logined_user) }
    let(:team_2) { create(:team, user: logined_user) }
    let(:person_1) { create(:person, team: team_1, user: logined_user) }
    let(:person_2) { create(:person, team: team_1, user: logined_user) }
    let(:person_3) { create(:person, team: team_2, user: logined_user) }
    let(:person_4) { create(:person, team: team_2, user: logined_user) }

    before do
      person_1
      person_2
      person_3
      person_4

      sign_in logined_user, scope: :user
    end

    it do
      subject
      expect(response).to render_template :index
    end

    it '@people がassignされること' do
      subject
      expect(assigns(:people)).to eq([person_1, person_2, person_3, person_4])
    end
  end
end
