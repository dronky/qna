require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'GET #index' do
    let(:question) {create(:question)}
    let(:answers) {create_list(:answer, 2, question: question)}
    before {get :index, params: {question_id: question}}

    it 'assign an array of all answers' do
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'index rendering' do
      expect(response).to render_template :index
    end
  end


  describe 'GET #show' do
    let(:question) {create(:question)}
    let(:answer) {create(:answer, question: question)}
    before {get :show, params: {id: answer, question_id: question}}

    it 'assign @answer variable' do
      expect(assigns(:answer)).to eq answer
    end

    it 'show rendering' do
      expect(response).to render_template :show
    end
  end

end
