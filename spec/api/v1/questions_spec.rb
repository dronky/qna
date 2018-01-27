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
      before {get '/api/v1/questions', params: {format: :json, access_token: access_token.token}}
      it 'returns 200 status' do
        expect(response).to be_success
      end
    end
  end
end