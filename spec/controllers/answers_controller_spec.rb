require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'GET #index' do
    sign_in_user

    let(:question) {create(:question)}
    let(:answers) {create_list(:answer, 2, question: question)}
    before {get :index, params: {question_id: question}}

    it 'assign an array of all answers' do # не прошел
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'index rendering' do
      expect(response).to render_template :index
    end
  end


  describe 'GET #show' do
    sign_in_user

    let(:question) {create(:question)}
    let(:answer) {create(:answer, question: question)}
    before {get :show, params: {id: answer, question_id: question}}

    it 'assign @answer variable' do # не прошел
      expect(assigns(:answer)).to eq answer
    end

    it 'show rendering' do
      expect(response).to render_template :show
    end
  end

  describe 'POST #create' do
    sign_in_user

    let(:question) {create(:question)}

    context 'correct validation' do
      it 'creates a valid object' do
        expect { post :create, params: {answer: attributes_for(:answer), question_id: question}}.to change(question.answers, :count).by(1)
      end

      it 'create rendering' do
        post :create, params: {answer: attributes_for(:answer), question_id: question}
        expect(response).to redirect_to question_answers_path
      end
    end

    context 'incorrect validation' do
      it 'creates an invalid object' do
        expect { post :create, params: {answer: attributes_for(:invalid_answer), question_id: question}}.to_not change(question.answers, :count)
      end

      it 'create rendering' do
        post :create, params: {answer: attributes_for(:invalid_answer), question_id: question}
        expect(response).to render_template :index
      end
    end
  end

end
