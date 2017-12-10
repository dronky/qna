require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  describe 'POST #create' do
    sign_in_user

    let(:question) {create(:question)}

    context 'correct validation' do

      it 'creates a valid object' do
        expect {post :create, params: {answer: attributes_for(:answer), question_id: question}, format: :js}.to change(@user.answers, :count).by(1)
      end

      it 'create rendering' do
        post :create, params: {answer: attributes_for(:answer), question_id: question}, format: :js
        expect(response).to render_template :create
      end
    end

    context 'incorrect validation' do
      it 'creates an invalid object' do
        expect {post :create, params: {answer: attributes_for(:invalid_answer), question_id: question}, format: :js}.to_not change(question.answers, :count)
      end

      it 'create rendering' do
        post :create, params: {answer: attributes_for(:invalid_answer), question_id: question}, format: :js
        expect(response).to render_template :create
      end
    end
  end

  let!(:answer) {create(:answer, question: question, user: user)}
  let!(:question) {create(:question)}
  let!(:user) {create(:user)}


  describe 'DELETE #destroy' do
    context 'answer flow (registered user)' do
      sign_in_user
      before {allow(controller).to receive(:current_user).and_return(user)}

      it 'tries to delete answer' do
        expect {delete :destroy, params: {question_id: question, id: answer}, format: :js}
            .to change(Answer, :count).by(-1)
      end

      it 'redirects to root url' do
        delete :destroy, params: {question_id: question, id: answer}, format: :js
        expect(response).to redirect_to root_path
      end
    end

    context 'answer flow (unregistered user)' do
      it 'tries to delete answer' do
        expect {delete :destroy, params: {question_id: question, id: answer}, format: :js}
            .not_to change(Answer, :count)
      end

      it 'redirects to root url' do
        delete :destroy, params: {question_id: question, id: answer}, format: :js
        expect(response.body).to eq "You need to sign in or sign up before continuing."
      end
    end
  end

  describe 'DELETE #destroy, user tries to delete the answer of another user' do
    context 'answer flow (registered user)' do
      let!(:user2) {create(:user)}
      let!(:answer2) {create(:answer, question: question, user: user2)}
      sign_in_user

      it 'tries to delete answer' do
        expect {delete :destroy, params: {question_id: question, id: answer2}, format: :js}
            .not_to change(Answer, :count)
      end
    end
  end
end
