# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#pins').imagesLoaded ->
    $('#pins').masonry
      itemSelector: '.box'
      isFitWidth: true


# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  pin.setupForm()

pin =
  setupForm: ->
    $('#new_pin').submit ->
      if $('input').length > 6
        $('input[type=submit]').attr('disabled', true)
        Stripe.bankAccount.createToken($('#new_pin'), pin.handleStripeResponse)
        false
  handleStripeResponse: (status, response) ->
    if status == 200
      $('#new_pin').append($('<input type="hidden" name="stripeToken" />').val(response.id))
      $('#new_pin')[0].submit()
    else
      $('#stripe_error').text(response.error.message).show()
      $('input[type=submit]').attr('disabled', false)
