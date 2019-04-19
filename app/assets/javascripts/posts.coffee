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

  # function for adding new posts to the feed
  updateFeed = (post) ->
    postTime = new Date(post.created_at.replace(' ', 'T')).toLocaleString('en-US', { hour: 'numeric', minute: 'numeric', hour12: true })
    $('.posts').prepend """
      <div class="post-wrapper col-12 mb-2 p-0">
        <div class="card">
          <div class="card-header">@#{post.username}<small class="float-right mt-1">at #{postTime}</small></div>
          <div class="card-body">
            <p class="card-text">#{post.post}</p>
            <a class="far fa-thumbs-up add-like" data-remote="true" rel="nofollow" data-method="post" href="/likes/#{post.id}"></a>
            <span class="ml-2" data-post="#{post.id}">#{post.likes[0].like_count}</span>
          </div>
        </div>
      </div>
    """
    return

  # if the post was successfully saved, get the post and pass it to the updateFeed function
  $('#post-form').on 'ajax:success', (data) ->
    post = data.detail[0]
    updateFeed post
    $('#post-form')[0].reset()
    return