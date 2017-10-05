describe IkedaNote::TeamsController, type: :controller do
  describe '#index' do
    subject { get :index }

    let(:logined_user) { create(:user) }

    let(:team_1) { create(:team, user: logined_user) }
    let(:team_2) { create(:team, user: logined_user) }

    before do
      team_1
      team_2

      sign_in logined_user, scope: :user
    end

    it do
      subject
      expect(response).to render_template :index
    end

    it '@teams がassignされること' do
      subject
      expect(assigns(:teams)).to eq([team_1, team_2])
    end
  end
end
