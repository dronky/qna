# frozen_string_literal: true

module OmniauthMacros
  def twitter_mock_auth_hash
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
      'provider' => 'twitter',
      'uid' => '123545',
      'info' => {
        'name' => 'mockuser',
        'image' => 'mock_user_thumbnail_url'
      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret'
      }
    )
  end

  def fb_mock_auth_hash
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      'provider' => 'facebook',
      'uid' => '123545',
      'info' => {
        'name' => 'mockuser',
        'email' => 'belozerov@rzd.ru',
        'image' => 'mock_user_thumbnail_url'
      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret'
      }
    )
  end
end
