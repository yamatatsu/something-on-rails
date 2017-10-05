describe IkedaNote::TeamsController, type: :controller do
  describe '#create' do
    subject { post :create, params: { team: team_params } }

    let(:logined_user) { create(:user) }

    let(:team_params) { { name: name, color_code: color_code } }
    let(:name) { 'test_name' }
    let(:color_code) { '#000000' }

    before do
      sign_in logined_user, scope: :user
    end

    describe '応答' do
      before { subject }

      context '正常系のとき' do
        it { expect(response).to redirect_to action: :index }
      end

      context 'nameが空文字のとき' do
        let(:name) { '' }

        it { expect(response).to render_template :new }
        it { expect(assigns(:team).errors.messages[:name]).to include("can't be blank") }
      end

      context 'nameが20文字を超えるとき' do
        let(:name) { '000000000100000000021' }

        it { expect(response).to render_template :new }
        it { expect(assigns(:team).errors.messages[:name]).to include('is too long (maximum is 20 characters)') }
      end
    end

    describe '副作用' do
      context '正常系のとき' do
        it { expect { subject }.to change { logined_user.teams.count }.by(1) }
        it { expect { subject }.to change { logined_user.teams.last&.name }.to(name) }
        it { expect { subject }.to change { logined_user.teams.last&.color_code }.to(color_code) }
      end
    end
  end
end
