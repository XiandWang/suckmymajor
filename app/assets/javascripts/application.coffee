#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require underscore
#= require backbone
#= require message-bus
#= require_tree .
#= require_self

AppView = Backbone.View.extend
  initialize: ->
    @initNotification()

  initNotification: () ->
    MessageBus.start()
    MessageBus.callbackInterval = 1000
    MessageBus.subscribe "/notifications_count/#{App.access_token}", (json) ->
      if json.count > 0
        console.log "sz"
        alert("dayu")
    true



window.App = 
  access_token : ""


$(document).ready ->
  window._appView = new AppView()