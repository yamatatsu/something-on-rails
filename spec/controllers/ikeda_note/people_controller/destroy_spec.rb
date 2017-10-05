describe IkedaNote::PeopleController, type: :controller do
  describe '#destroy' do
    subject { delete :destroy, params: { id: person_1.id } }

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
      expect(response).to redirect_to action: :index
    end

    it { expect { subject }.to change { Person.count }.by(-1) }
    it { expect { subject }.to change { Team.count }.by(0) }
  end
end
