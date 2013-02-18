class ServerView extends Backbone.View

  initialize: ->

  render: ->
    $(@el).html(Handlebars.templates.server(@model))

    @number = 0
    # Render each operation
    ###@addOperation operation for operation in @model.operationsArray###
    @

  addServer: (operation) ->
    ###
      operation.number = @number

      # Render an operation and add it to operations li
      operationView = new OperationView({model: operation, tagName: 'li', className: 'endpoint'})
      $('.endpoints', $(@el)).append operationView.render().el

      @number++
    ###

  updateServerStatuses: ->
    #updateServerStatuses(".targets-container div span a")