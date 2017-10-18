require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  describe 'POST #create' do
    sign_in_user

    let(:question) {create(:question)}

    context 'correct validation' do
      it 'creates a valid object' do
        expect {post :create, params: {answer: attributes_for(:answer), question_id: question}, format: :js}.to change(question.answers, :count).by(1)
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

  describe 'DELETE #destroy' do
    sign_in_user

    let(:answer) {create(:answer, question: question)}
    let(:question) {create(:question)}

    context 'answer flow' do
      it 'tries to delete answer' do
        expect {delete :destroy, params: {question_id: question, id: answer}, format: :js}
            .not_to change(Answer, :count)
      end

      it 'redirects to root url' do
        delete :destroy, params: {question_id: question, id: answer}, format: :js
        expect(response).to redirect_to root_path
      end
    end
  end
end
