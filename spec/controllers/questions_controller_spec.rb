require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe 'GET #inddex' do
    let(:questions) { create_list(:question, 2) }
    before { get :index }

    it 'create an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'index rendering' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:question) { create(:question) }
    before { get :show, params: { id: question } }

    it 'create @question variable' do
      expect(assigns(:question)).to eq question
    end

    it 'show rendering' do
      expect(response).to render_template :show
    end
  end
end
