require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  describe 'GET #index' do
    let(:questions) {create_list(:question, 2)}
    before {get :index}

    it 'create an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'index rendering' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:question) {create(:question)}
    before {get :show, params: {id: question}}

    it 'create @question variable' do
      expect(assigns(:question)).to eq question
    end

    it 'show rendering' do
      expect(response).to render_template :show
    end

    it 'build new attachment for answer' do
      expect(assigns(:answer).attachments.first).to be_a_new(Attachment)
    end

  end

  describe 'POST #create' do
    sign_in_user

    context 'correct validation' do
      it 'creates a valid object' do
        expect {post :create, params: {question: attributes_for(:question)}}.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: {question: attributes_for(:question)}
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'incorrect validation' do
      it 'creates an invalid object' do
        expect {post :create, params: {question: attributes_for(:invalid_question)}}.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, params: {question: attributes_for(:invalid_question)}
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    context 'question flow (registered user)' do
      let!(:question) {create(:question, user: @user)}

      it 'tries to delete question' do
        expect {delete :destroy, params: {id: question}}.to change(Question, :count).by(-1)
      end

      it 'redirects to questions url' do
        delete :destroy, params: {id: question}
        expect(response).to redirect_to questions_path
      end
    end

    context 'question flow (unregistered user)' do
      let!(:question) {create(:question)}

      it 'tries to delete question' do
        expect {delete :destroy, params: {id: question}}.not_to change(Question, :count)
      end
    end
  end

  describe 'DELETE #destroy, user tries to delete the question of another user' do
    context 'question flow (registered user)' do
      let!(:user2) {create(:user)}
      let!(:question2) {create(:question, user: user2)}
      sign_in_user

      it 'tries to delete the question' do
        expect {delete :destroy, params: {id: question2}, format: :js}.not_to change(Question, :count)
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user
    let(:question) {create(:question)}
    it 'changes question attributes' do
      patch :update, params: {id: question, question: {title: 'new title', body: 'new body'}}
      question.reload
      expect(question.title).to eq 'new title'
      expect(question.body).to eq 'new body'
    end
  end
end
