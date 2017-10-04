require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'GET #index' do
    let(:question) {create(:question)}
    let(:answers) {create_list(:answer, 2)}
    before {get :index, params: {question_id: question}}

    it 'create an array of all answers' do
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'index rendering' do
      expect(response).to render_template :index
    end
  end


  describe 'GET #show' do
    let(:answer) {create(:answer)}
    let(:question) {create(:question)}
    before {get :show, params: {id: answer, question_id: question}}

    it 'create @answer variable' do
      expect(assigns(:answer)).to eq answer
    end

    it 'show rendering' do
      expect(response).to render_template :show
    end
  end

end
