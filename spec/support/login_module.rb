module LoginModule
  def login(user)
    visit user_session_path(user.id)
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end
end