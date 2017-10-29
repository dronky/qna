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

  let!(:user) {create(:user)}
  let!(:question) {create(:question, user: user)}
  let!(:answer) {create(:answer, question: question, user: user)}

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
        expect(response).to render_template :destroy
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
      sign_in_user

      let!(:user2) {create(:user)}
      let!(:answer2) {create(:answer, question: question, user: user2)}

      it 'tries to delete answer' do
        expect {delete :destroy, params: {question_id: question, id: answer2}, format: :js}
            .not_to change(Answer, :count)
      end
    end
  end

  describe 'PATCH #update' do
    context 'updating answer' do
      sign_in_user

      it 'tries to update the answer' do
        patch :update, params: {id: answer, question_id: question, answer: attributes_for(:answer)}, format: :js # уточнить зачем тут передавать question_id, если он передается в 34 строчке
        answer.reload
        expect(answer.body).to eq 'MyText'
      end
    end
  end

  describe 'GET #mark_as_best' do
    sign_in_user

    context 'making answer as a best for question' do
      let(:answer) {create(:answer, question: question, user: user)}

      it 'tries to mark the answer as a best' do
        get :mark_as_best, params: {id: answer.id, answer_id: answer.id, question_id: question.id}, format: :js
        answer.reload
        expect(answer.best_answer).to eq true
      end
    end
  end
end
