describe IkedaNote::TeamsController, type: :controller do
  describe '#edit' do
    subject { get :edit, params: { id: team_1.id } }

    let(:logined_user) { create(:user) }

    let(:team_1) { create(:team, user: logined_user) }

    before do
      team_1

      sign_in logined_user, scope: :user
    end

    it do
      subject
      expect(response).to render_template :edit
    end

    it '@team がassignされること' do
      subject
      expect(assigns(:team)).to eq(team_1)
    end
  end
end
