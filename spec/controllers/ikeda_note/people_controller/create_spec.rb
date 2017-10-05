describe IkedaNote::PeopleController, type: :controller do
  describe '#create' do
    subject { post :create, params: { person: person_params } }

    let(:logined_user) { create(:user) }

    let(:person_params) { { name: name, team_id: team_id } }
    let(:name) { 'test_name' }
    let(:team_id) { team_1.id }
    let(:team_1) { create(:team, user: logined_user) }

    before do
      team_1

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
        it { expect(assigns(:person).errors.messages[:name]).to include("can't be blank") }
      end

      context 'nameが20文字を超えるとき' do
        let(:name) { '000000000100000000021' }

        it { expect(response).to render_template :new }
        it { expect(assigns(:person).errors.messages[:name]).to include('is too long (maximum is 20 characters)') }
      end
    end

    describe '副作用' do
      context '正常系のとき' do
        it { expect { subject }.to change { logined_user.people.count }.by(1) }
        it { expect { subject }.to change { logined_user.people.last&.name }.to(name) }
        it { expect { subject }.to change { logined_user.people.last&.team_id }.to(team_id) }
      end
    end
  end
end
