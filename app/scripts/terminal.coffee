commandMap =
  "echo (.+)": ["POST", "/echo"]
  "logout": ["REDIRECT", "/users/sign_out"]

  "buf$": ["GET", "/buffer_items"]
  "aspects$": ["GET", "/aspects"]
  "appts": ["GET", "/appointments"]

  "buf (.+)": ["POST", "/buffer_items"]
  "mk aspect (.+)": ["POST", "/aspects"]
  "mk task (.+)": ["POST", "/tasks"]
  "mk appt (.+)": ["POST", "/appointments"]

  "next":["GET", "/visualization/priority"]

writeLine = (outputObject, afterWriteTriggers) =>
  line = new OutputLine(outputLineId, afterWriteTriggers)
  outputLines[outputLineId] = line
  line.append(outputObject)
  line.write()
  outputLineId++

outputLineId = 0 # TODO attach this to the #output dom element
outputLines = {}

$ () =>
  # Process input and clear the command bar
  $("#inputBar form").bind 'submit', (e) =>
    e.preventDefault()

    input = $("#command").val()

    if input is ""
      return false
    
    writeLine(new CommandBubble(input))

    routes = []
    for expr, route of commandMap
      routes.push(route) if input.match(new RegExp(expr))
        
    if routes.length is 1
      if routes[0][0] is "REDIRECT"
        window.location.replace(routes[0][1])
        return false

      $.ajax({
        type: routes[0][0],
        url: routes[0][1],
        data:
          args: input.substring(input.indexOf(' '), input.length),
        success: (data) =>
          writeLine(new ResultBubble(data), [
            ((id, object) => object.find(".rest_in_place").rest_in_place()),
            ((id, object) => 
              object.find("a[data-output-mode=extend]").click (e) =>
                e.preventDefault()
                $.get(e.target, null, ((data) => outputLines[id].extend(data)), "html"))
            ])

        error: (data) => writeLine(new ErrorBubble(data.responseText))
        dataType: "html"
      })
    else if routes.length > 1
      $.post("/echo", {args: "Command '#{input}' is ambiguous between #{routes}"}, ((data) => writeLine(new ErrorBubble(data))), "html")
    else
      $.post("/echo", {args: "Command '#{input}' was not recognized"}, ((data) => writeLine(new ErrorBubble(data))), "html")

    $("#command").val('')
    return false

  # Scroll to bottom of page for all ajax requests
  $(document).ajaxComplete () =>
    $("html body").animate({scrollTop: $(document).height()}, "slow")
