@Demo.module 'HeaderApp', (HeaderApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  API =
    listHeader: ->
      HeaderApp.List.Controller.listHeader()

  @on 'start', ->
    API.listHeader()