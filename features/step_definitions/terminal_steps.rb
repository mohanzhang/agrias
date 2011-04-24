When /^I enter the command "([^"]*)"$/ do |command|
  When %{I fill in "command" with "#{command}"}
  page.driver.browser.execute_script("$('#inputBar form').submit()")
end

Then /^I should see a result with "([^"]*)"$/ do |result|
  regexp = Regexp.new(result)
  xpath = "(//div[contains(@class, 'result')])[last()]"

  if page.respond_to? :should
    page.should have_xpath(xpath, :text => regexp)
  else
    assert page.has_xpath(xpath, :text => regexp)
  end
end

Then /^I should see an error with "([^"]*)"$/ do |error|
  Then %{I should see "#{error}" within ".bubble.error"}
end
