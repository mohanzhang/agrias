When /^I change the value of the hidden field "([^\"]*)" to "([^\"]*)"$/ do |field_name, value|
  page.driver.browser.execute_script("$('#{field_name}').val('#{value}');false")
end

When /^I follow the image within "([^\"]*)"$/ do |selector|
  page.find(:css, selector).click
end

Then /^pause the page$/ do
  sleep(5000)
end
