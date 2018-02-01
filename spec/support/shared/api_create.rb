shared_examples_for 'API Creatable' do

  context 'autorizred' do
    let(:access_token) {create(:access_token)}

    it 'creates a valid object' do
      expect {post api_path, params: {
          format: :json, access_token: access_token.token,
          object_class.name.downcase => attributes_for(object_class.name.downcase.to_sym)}}.to change(object_class, :count).by(1)
    end
    it 'dont create invalid object' do
      expect {post api_path, params: {
          format: :json, access_token: access_token.token,
          object_class.name.downcase => attributes_for(('invalid_' + object_class.name.downcase).to_sym)}}.to_not change(object_class, :count)
    end
  end
end
