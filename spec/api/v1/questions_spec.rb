require 'rails_helper'

describe 'Question API' do
  describe 'GET /index' do
    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        get '/api/v1/questions', params: {format: :json}
        expect(response.status).to eq 401
      end
      it 'returns 401 status if access_token not valid' do
        get '/api/v1/questions', params: {format: :json, access_token: '1234'}
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:access_token) {create(:access_token)}
      let!(:questions) {create_list(:question, 2)}
      let!(:answer) {create(:answer, question: question)}
      let(:question) {questions.first}

      before {get '/api/v1/questions', params: {format: :json, access_token: access_token.token}}

      it 'returns 200 status' do
        expect(response).to be_success
      end

      it 'returns list of questions' do
        expect(response.body).to have_json_size(2)
      end

      %w{id title body created_at updated_at}.each do |attr|
        it "question object contains #{attr}" do
          #at_path("0") means first element of array
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end

      context 'answers' do

        it 'included in question object' do
          expect(response.body).to have_json_size(1).at_path('0/answers')
        end

        %w{id body created_at updated_at}.each do |attr|
          it "answer contains #{attr}" do
            #at_path("0") means first element of array
            expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("0/answers/0/#{attr}")
          end
        end
      end
    end
  end
end