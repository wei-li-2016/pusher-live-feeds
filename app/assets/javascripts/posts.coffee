# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready =>
  currentUser = ''
  welcomePage = $('.welcome-page')
  postPage = $('.post-page')
  newUserForm = $('#new-user-form')

  # when user enters a username, store it and show the post page
  newUserForm.on 'keyup', (event) ->
    if event.keyCode == 13 and !event.shiftKey
      currentUser = event.target.value
      newUserForm.val('')
      welcomePage.addClass('collapse')
      postPage.removeClass('collapse')
      greeting = """welcome @#{currentUser}"""
      $('.current-user').html(greeting)
      $('#username').val(currentUser)
    return