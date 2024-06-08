class FakeAuthController < ApplicationController
    def twitter2
      auth = {
        'provider' => 'twitter2',
        'uid' => '12345',
        'info' => {
          'nickname' => 'testuser'
        },
        'credentials' => {
          'token' => 'token',
          'secret' => 'secret'
        }
      }
      session[:user_id] = auth['uid']
      redirect_to root_path
    end
  end
  