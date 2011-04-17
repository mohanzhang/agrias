commandMap =
  "echo (.+)": "/echo"

$ () =>
  # Process input and clear the command bar
  $("#inputBar form").bind 'submit', (e) =>
    input = $("#command").val()
    routes = []
    for expr, route of commandMap
      routes.push(route) if input.match(new RegExp(expr))
        
    if routes.length is 1
      $.post(routes[0], {args: input.substring(input.indexOf(' '), input.length)})
    else if routes.length > 1
      $.post("/echo", {args: "Command '#{input}' is ambiguous between #{routes}"})
      alert("routes #{routes.length}")
      e.preventDefault()
    else
      $.post("/echo", {args: "Command '#{input}' was not recognized"})
      e.preventDefault()

    $("#command").val('')

  # Scroll to bottom of page for all ajax requests
  $(document).ajaxComplete () =>
    $("html body").animate({scrollTop: $(document).height()}, "slow")

