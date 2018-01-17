module OmniauthMacros
  def mock_auth_hash
    OmniAuth.config.mock_auth[:twitter] = {
        'provider' => 'twitter',
        'uid' => '123545',
        'user_info' => {
            'name' => 'mockuser',
            'image' => 'mock_user_thumbnail_url'
        },
        'credentials' => {
            'token' => 'mock_token',
            'secret' => 'mock_secret'
        }
    }
  end
end