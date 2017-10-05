describe IkedaNote::PeopleController, type: :controller do
  describe '#update' do
    subject { put :update, params: { id: person_1.id, person: person_params } }

    let(:logined_user) { create(:user) }

    let(:person_params) { { name: name, team_id: team_id } }
    let(:name) { 'test_name' }
    let(:team_id) { team_2.id }
    let(:team_1) { create(:team, user: logined_user) }

    let(:person_1) { create(:person, name: pre_name, team: team_1, user: logined_user) }
    let(:pre_name) { 'pre' }
    let(:team_1) { create(:team, user: logined_user) }
    let(:team_2) { create(:team, user: logined_user) }

    before do
      team_1
      team_2
      person_1

      sign_in logined_user, scope: :user
    end

    describe '応答' do
      before { subject }

      context '正常系のとき' do
        it { expect(response).to redirect_to action: :index }
        it { expect(assigns(:person).errors).to be_empty }
      end

      context 'nameが空文字のとき' do
        let(:name) { '' }

        it { expect(response).to render_template :edit }
        it { expect(assigns(:person).errors.messages[:name]).to include("can't be blank") }
      end

      context 'nameが20文字を超えるとき' do
        let(:name) { '000000000100000000021' }

        it { expect(response).to render_template :edit }
        it { expect(assigns(:person).errors.messages[:name]).to include('is too long (maximum is 20 characters)') }
      end
    end

    describe '副作用' do
      context '正常系のとき' do
        it { expect { subject }.to change { person_1.reload.name }.from(pre_name).to(name) }
        it { expect { subject }.to change { person_1.reload.team.id }.from(team_1.id).to(team_2.id) }
      end
    end
  end
end
