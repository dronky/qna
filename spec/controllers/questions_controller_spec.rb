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
  end

  describe 'POST #create' do
    sign_in_user

    context 'correct validation' do
      it 'creates a valid object' do
        expect {post :create, params: {question: attributes_for(:question)}}.to change(Question, :count).by(1)
      end

      it 'create rendering' do
        post :create, params: {question: attributes_for(:question)}
        expect(response).to redirect_to questions_path
      end
    end

    context 'incorrect validation' do
      it 'creates an invalid object' do
        expect {post :create, params: {question: attributes_for(:invalid_question)}}.to_not change(Question, :count)
      end

      it 'create rendering' do
        post :create, params: {question: attributes_for(:invalid_question)}
        expect(response).to render_template :index
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    let(:question) {create(:question)}

    context 'question flow' do
      it 'tries to delete question' do
        expect {delete :destroy, params: {id: question}}.to change(Question, :count).by(-1) # уточнить
      end

      it 'redirects to questions url' do
        delete :destroy, params: {id: question}
        expect(response).to redirect_to questions_path
      end
    end
  end
end
