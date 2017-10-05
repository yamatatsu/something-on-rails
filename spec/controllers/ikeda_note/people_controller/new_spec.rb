describe IkedaNote::PeopleController, type: :controller do
  describe '#new' do
    subject { get :new }

    let(:logined_user) { create(:user) }

    before do
      sign_in logined_user, scope: :user
    end

    it do
      subject
      expect(response).to render_template :new
    end
  end
end
