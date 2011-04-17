When /^I enter the command "([^"]*)"$/ do |command|
  When %{I fill in "command" with "#{command}"}
  page.driver.browser.execute_script("$('#inputBar form').submit()")
end

Then /^I should see a result with "([^"]*)"$/ do |result|
  Then %{I should see "#{result}" within ".bubble.result"}
end
