Given /^I am signed in$/ do
  Given %{I have an account}
  And %{I go to login}
  And %{I fill in "user_email" with "test@mohanzhang.com"}
  And %{I fill in "user_password" with "asdfasdf"}
  And %{I press "Sign in"}
end

Given /^I have an account$/ do
  user = create_model('user "current user"', {
    :email => "test@mohanzhang.com",
    :password => "asdfasdf", :password_confirmation => "asdfasdf"
  })
end
