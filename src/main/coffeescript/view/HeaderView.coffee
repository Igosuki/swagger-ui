class HeaderView extends Backbone.View
  events: {
    'mouseenter #version-pick' : 'toggleVersionPicker'
    'click #version-pick' : 'toggleVersionPicker'
    'mouseleave #version-list' : 'hideVersionPicker'
    'click .version-pick' : 'showNewEnv'
    'click #explore'                : 'showCustom'
    'keyup #input_baseUrl'          : 'showCustomOnKeyup'
    'keyup #input_apiKey'           : 'showCustomOnKeyup'
  }

  initialize: ->
    getVersionsFromApacheIndex("http://localhost/~geps/api", 
      (versions) -> $("#version-list").append $("<li class='version-pick header-text'>"+version.replace(/\//g, "")+"</li>") for version in versions 
    )
    
  toggleVersionPicker: (e) ->
    $("#version-list").slideToggle()

  hideVersionPicker: (e) ->
    $("#version-list").slideUp()

  showNewEnv: (e) ->
    newVersion = e.currentTarget.textContent
    @trigger(
      'update-swagger-ui'
      {discoveryUrl:"http://localhost/~geps/api/" + newVersion + "/doc.json", apiKey:""}
    )
    @updateVersion(newVersion)

    ###e.currentTarget.attributes.id.value.replace(/show-([a-z]+)-icon/g, "$1")###

  showCustomOnKeyup: (e) ->
    @showCustom() if e.keyCode is 13

  showCustom: (e) ->
    e?.preventDefault()
    @trigger(
      'update-swagger-ui'
      {discoveryUrl: $('#input_baseUrl').val(), apiKey: $('#input_apiKey').val()}
    )

  update: (url, apiKey, trigger = false) ->
    $('#input_baseUrl').val url
    $('#input_apiKey').val apiKey
    @trigger 'update-swagger-ui', {discoveryUrl:url, apiKey:apiKey} if trigger


  updateVersion: (version) ->
    $('#logoversion').text version
