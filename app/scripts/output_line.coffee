class @OutputLine
  constructor: (@id, @afterWriteFilters) ->
    @outputObjects = []

  append: (outputBubble) ->
    @outputObjects.push(outputBubble)
    return this

  extend: (data) ->
    object = $(new ExtensionBubble(data).html())
    $("#line_"+@id).append(object)
    @doAfterWrite(object)

  doAfterWrite: (jquery) ->
    if @afterWriteFilters?
      for f in @afterWriteFilters
        f(@id, jquery)

  write: ->
    $("#output").append('<div class="outputLine" id="line_'+@id+'"></div>')
    for o in @outputObjects
      object = $(o.html())
      $("#line_#{@id}").append(object)
      @doAfterWrite(object)
    $("#output").append('<div class="clear"></div>')

