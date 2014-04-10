CivicSourcing.MarkdownEditor = Em.TextArea.extend(

  buttonBarId: ""

  random: 0

  init: ->
    @set('random', Math.floor(Math.random() * (999999 - 100000 + 1)) + 100000)
    @set('buttonBarId', 'wmd-button-bar-' + @get('random'))
    @set('elementId', 'wmd-input-' + @get('random'))
    @_super()

  didInsertElement: ->
    $("##{@get('elementId')}").before("<div id='#{@get("buttonBarId")}'></div>")
    editor = new Markdown.Editor(CivicSourcing.markdown, '-'+ @get('random'))
    editor.run()

)