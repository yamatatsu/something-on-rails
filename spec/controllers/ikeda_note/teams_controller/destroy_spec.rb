describe IkedaNote::TeamsController, type: :controller do
  describe '#destroy' do
    subject { delete :destroy, params: { id: team_1.id } }

    let(:logined_user) { create(:user) }

    let(:team_1) { create(:team, user: logined_user) }

    before do
      team_1

      sign_in logined_user, scope: :user
    end

    it do
      subject
      expect(response).to redirect_to action: :index
    end

    it { expect { subject }.to change { Team.count }.by(-1) }
  end
end
