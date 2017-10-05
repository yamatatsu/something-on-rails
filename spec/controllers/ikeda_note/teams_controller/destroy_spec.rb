describe IkedaNote::TeamsController, type: :controller do
  describe '#destroy' do
    subject { delete :destroy, params: { id: team_1.id } }

    let(:logined_user) { create(:user) }

    let(:team_1) { create(:team, user: logined_user) }

    before do
      team_1

      sign_in logined_user, scope: :user
    end

    context '正常系' do
      it do
        subject
        expect(response).to redirect_to action: :index
      end

      it { expect { subject }.to change { Team.count }.by(-1) }
    end

    context '異常系 perpleが紐付いているとき' do
      before do
        create(:person, team: team_1, user: logined_user)
        subject
      end

      it { expect(response).to redirect_to action: :index }
      it { expect(assigns(:team).errors.full_messages).to include("Cannot delete record because dependent people exist") }

      it { expect { subject }.to change { Team.count }.by(0) }
    end
  end
end
