commandMap =
  "echo (.+)": ["POST", "/echo"]

  "buf$": ["GET", "/buffer_items"]
  "aspects": ["GET", "/aspects"]
  "appts": ["GET", "/appointments"]

  "buf (.+)": ["POST", "/buffer_items"]
  "mk aspect (.+)": ["POST", "/aspects"]
  "mk task (.+)": ["POST", "/tasks"]
  "mk appt (.+)": ["POST", "/appointments"]

agriasBubble = (data) => 
  '
  <div class="bubble result">
    <div class="avatar left">
      <img src="/images/avatar_left.png" />
    </div>
    <div class="content">
      <h3 class="name">
        <img src="/images/speech_bubble_name.png" />
      </h3>
      ' + data + '
    </div>
  </div>
  <div class="clear" />
  '
errorBubble = (data) => 
  '
  <div class="bubble error">
    <div class="avatar right">
      <img src="/images/avatar_right.png" />
    </div>
    <div class="content">
      <h3 class="name">
        <img src="/images/speech_bubble_name.png" />
      </h3>
      ' + data + '
    </div>
  </div>
  <div class="clear" />
  '
commandBubble = (data) =>
  '
  <div class="bubble command">
    <div class="content">
      <h3>
        Command:
      </h3>
      ' + data + '
    </div>
  </div>
  <div class="clear" />
  '

drawBubble = (data,template) =>
  bubble = $(template(data))
  bubble.find(".rest_in_place").rest_in_place()
  $("#output").append(bubble)
  # Enable REST in place for server responses

$ () =>
  # Process input and clear the command bar
  $("#inputBar form").bind 'submit', (e) =>
    input = $("#command").val()

    if input is ""
      e.preventDefault()
      return false

    drawBubble(input, commandBubble)

    routes = []
    for expr, route of commandMap
      routes.push(route) if input.match(new RegExp(expr))
        
    if routes.length is 1
      $.ajax({
        type: routes[0][0],
        url: routes[0][1],
        data:
          args: input.substring(input.indexOf(' '), input.length),
        success: (data) => drawBubble(data,agriasBubble)
        error: (data) => drawBubble(data.responseText,errorBubble)
        dataType: "html"
      })
    else if routes.length > 1
      $.post("/echo", {args: "Command '#{input}' is ambiguous between #{routes}"}, ((data) => drawBubble(data, errorBubble)), "html")
    else
      $.post("/echo", {args: "Command '#{input}' was not recognized"}, ((data) => drawBubble(data, errorBubble)), "html")

    e.preventDefault()
    $("#command").val('')
    return false

  # Scroll to bottom of page for all ajax requests
  $(document).ajaxComplete () =>
    $("html body").animate({scrollTop: $(document).height()}, "slow")
