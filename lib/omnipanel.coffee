OmnipanelView = require './omnipanel-view'
{CompositeDisposable} = require 'atom'

module.exports = Omnipanel =
  omnipanelView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @omnipanelView = new OmnipanelView(state.omnipanelViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @omnipanelView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'omnipanel:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @omnipanelView.destroy()

  serialize: ->
    omnipanelViewState: @omnipanelView.serialize()

  toggle: ->
    console.log 'Omnipanel was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
