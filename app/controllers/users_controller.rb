class UsersController < ApplicationController
  get '/profile/?' do
    erb :profile
  end

  get '/login/?' do
    erb :login
  end

  post '/login/?' do
    user = User.find_by username: params['username']

    if user
      password = BCrypt::Password.new user.password

      if password == params['password']
        session[:is_logged_in] = true
        session[:user_id] = user.id
        'You are logged in ' + user.username
      else
        'Password does not match'
      end
    else
      'No user with that username'
    end
  end

  get '/logout/?' do
    session[:is_logged_in] = false
    session[:user_id] = nil

    redirect '/'
  end

  get '/membersonly/?' do
    if session[:is_logged_in]
      'Hello user'
    else
      redirect '/'
    end
  end

  get '/?' do
    erb :home
  end

  post '/?' do
    password = BCrypt::Password.create params['password']
    user = User.create username: params['username'], email: params['email'], password: password

    if user
      session[:is_logged_in] = true
      session[:user_id] = user.id
      user.to_json
    else
      'Cannot create user'
    end
  end
end
