require 'rails_helper'

describe 'Answer API' do
  describe 'GET /index' do
    it_behaves_like 'API Authenticable'

    context 'authorized' do
      let!(:question) {create(:question, id: 0)}
      let(:access_token) {create(:access_token)}
      let!(:answers) {create_list(:answer, 2, question: question)}
      let(:answer) {answers.first}

      before {get '/api/v1/questions/0/answers', params: {format: :json, access_token: access_token.token}}

      it 'returns 200 status' do
        expect(response).to be_success
      end

      it 'returns list of answers' do
        expect(response.body).to have_json_size(2)
      end

      %w{id body created_at updated_at}.each do |attr|
        it "answer object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end
    end

    def do_request(options = {})
      get '/api/v1/questions/0/answers', params: {format: :json}.merge(options)
    end
  end

  describe 'GET #show' do
    it_behaves_like 'API Authenticable'

    context 'authorized' do
      let!(:question) {create(:question, id: 0)}
      let!(:answer) {create(:answer, id: 0, question: question)}
      let(:access_token) {create(:access_token)}

      before {get '/api/v1/answers/0', params: {format: :json, access_token: access_token.token}}

      it 'returns 200 status' do
        expect(response).to be_success
      end

      %w{id body created_at updated_at attachments comments}.each do |attr|
        it "answer contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("#{attr}")
        end
      end
    end

    def do_request(options = {})
      get '/api/v1/answers/0', params: {format: :json}.merge(options)
    end

  end

  describe 'POST #create' do
    it_behaves_like 'API Authenticable'

    context 'autorizred' do
      let!(:question) {create(:question, id: 0)}
      let(:access_token) {create(:access_token)}

      it 'creates a valid object' do
        expect {post "/api/v1/questions/0/answers", params: {
            format: :json, access_token: access_token.token, answer: attributes_for(:answer)}}.to change(Answer, :count).by(1)
      end
      it 'dont create invalid object' do
        expect {post "/api/v1/questions/0/answers", params: {
            format: :json, access_token: access_token.token,
            answer: attributes_for(:invalid_answer)
        }}.to_not change(Answer, :count)
      end
    end

    def do_request(options = {})
      post '/api/v1/questions/0/answers', params: {format: :json}.merge(options)
    end
  end
end