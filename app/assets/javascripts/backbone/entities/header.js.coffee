@Demo.module 'Entities', (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Header extends Entities.Model

  class Entities.HeaderCollection extends Entities.Collection
    model: Entities.Header

  API =
    getHeaders: ->
      new Entities.HeaderCollection [
        {name: 'Users'}
        {name: 'Leads'}
        {name: 'Appointments'}
      ]

  App.reqres.setHandler 'header:entities', ->
    API.getHeaders()