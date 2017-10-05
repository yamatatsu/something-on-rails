describe IkedaNote::TeamsController, type: :controller do
  describe '#update' do
    subject { put :update, params: { id: team_1.id, team: team_params } }

    let(:logined_user) { create(:user) }

    let(:team_params) { { name: name, color_code: color_code } }
    let(:name) { 'test_name' }
    let(:color_code) { '#000000' }

    let(:team_1) { create(:team, name: pre_name, color_code: pre_color_code, user: logined_user) }
    let(:pre_name) { 'pre_name' }
    let(:pre_color_code) { '#111111' }

    before do
      team_1

      sign_in logined_user, scope: :user
    end

    describe '応答' do
      before { subject }

      context '正常系のとき' do
        it { expect(response).to redirect_to action: :index }
        it { expect(assigns(:team).errors).to be_empty }
      end

      context 'nameが空文字のとき' do
        let(:name) { '' }

        it { expect(response).to render_template :edit }
        it { expect(assigns(:team).errors.messages[:name]).to include("can't be blank") }
      end

      context 'nameが20文字を超えるとき' do
        let(:name) { '000000000100000000021' }

        it { expect(response).to render_template :edit }
        it { expect(assigns(:team).errors.messages[:name]).to include('is too long (maximum is 20 characters)') }
      end
    end

    describe '副作用' do
      context '正常系のとき' do
        it { expect { subject }.to change { team_1.reload.name }.from(pre_name).to(name) }
        it { expect { subject }.to change { team_1.reload.color_code }.from(pre_color_code).to(color_code) }
      end
    end
  end
end
