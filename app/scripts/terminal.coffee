commandMap = (() =>
    map = 
      "echo (.+)": ["POST", "/echo"]
      "logout": ["REDIRECT", "/users/sign_out"]

      "(list|buf)": ["GET", "/buffer_items"]
      "(asp|aspects)": ["GET", "/aspects"]
      "appts": ["GET", "/appointments"]
      "tasks": ["GET", "/tasks"]

      "buf (.+)": ["POST", "/buffer_items/args"]
      "(make|mk) aspect (.+)": ["POST", "/aspects/args"]
      "(make|mk) task (.+)": ["POST", "/tasks/args"]
      "(make|mk) appt (.+)": ["POST", "/appointments/args"]

      "(move|mv) aspect (.+)": ["POST", "/aspects/args"]

      "next":["GET", "/visualization/priority"]
      "table":["GET", "/visualization/table"]
    
    ret = {}

    for k,v of map
      ret["^"+k+"$"] = v
    
    return ret
  )()


writeLine = (outputObject, afterWriteTriggers) =>
  line = new OutputLine(outputLineId, afterWriteTriggers)
  outputLines[outputLineId] = line
  line.append(outputObject)
  line.write()
  outputLineId++

outputLineId = 0 # TODO attach this to the #output dom element
outputLines = {}

commandHistory = []
commandHistoryIndex = 0

$ () =>
  # Say hello
  $.post("/echo", {args: "Welcome"}, ((data) => writeLine(new ResultBubble(data))), "html")

  # Process input and clear the command bar
  $("#inputBar form").bind 'submit', (e) =>
    e.preventDefault()

    input = $("#command").val()

    if input is ""
      return false
    
    commandHistory.push(input)
    commandHistoryIndex = commandHistory.length

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
          args: input
        success: (data) =>
          writeLine(new ResultBubble(data), [
            ((id, object) => object.find(".rest_in_place").rest_in_place()),
            ((id, object) => 
              object.find("a[data-output-mode=extend]").click (e) =>
                e.preventDefault()
                $.get(e.target, null, ((data) => outputLines[id].extend(data)), "html")),
            ((id, object) =>
              object.find("a[data-output-mode=hide]").click (e) =>
                $(e.target).closest(".bubble").hide())
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

  # Pressing up and down traverses the command history
  $("#command").focus () =>
    $(document).keydown (e) =>
      if e.keyCode is 38
        commandHistoryIndex-- unless commandHistoryIndex is 0
        $("#command").val(commandHistory[commandHistoryIndex])
      else if e.keyCode is 40
        if commandHistoryIndex is commandHistory.length
          $("#command").val("")
        else
          commandHistoryIndex++
          $("#command").val(commandHistory[commandHistoryIndex])

  $("#command").blur () =>
    $(document).unbind("keydown")
    commandHistoryIndex = commandHistory.length

  
