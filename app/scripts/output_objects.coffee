class OutputBubble
  constructor: (@template, @data) ->

  html: ->
    return @template(@data)

class @ResultBubble extends OutputBubble
  constructor: (@data) ->
    super ((data) =>
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
      '), @data

class @ErrorBubble extends OutputBubble
  constructor: (@data) ->
    super ((data) =>
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
      '), @data

class @CommandBubble extends OutputBubble
  constructor: (@data) ->
    super ((data) =>
      '
      <div class="bubble command">
        <div class="content">
          <h3>
            Command:
          </h3>
          ' + data + '
        </div>
      </div>
      '), @data

class @ExtensionBubble extends OutputBubble
  constructor: (@data) ->
    super ((data) =>
      '
      <div class="bubble extension">
        <div class="pointer">
          <img src="/images/speech_bubble_pointer_left.png" />
        </div>
        <div class="content">
          ' + data + '
        </div>
      </div>
      '), @data
