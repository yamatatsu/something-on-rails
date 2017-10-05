describe IkedaNote::PeopleController, type: :controller do
  describe '#edit' do
    subject { get :edit, params: { id: person_1.id } }

    let(:logined_user) { create(:user) }

    let(:team_1) { create(:team, user: logined_user) }
    let(:person_1) { create(:person, team: team_1, user: logined_user) }

    before do
      team_1
      person_1

      sign_in logined_user, scope: :user
    end

    it do
      subject
      expect(response).to render_template :edit
    end

    it '@person がassignされること' do
      subject
      expect(assigns(:person)).to eq(person_1)
    end
  end
end
