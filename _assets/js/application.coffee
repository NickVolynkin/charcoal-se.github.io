#= require vendor/jquery
#= require search-stub

# https://github.com/Charcoal-SE/charcoal-se.github.io/new/site?filename=_posts/2017-06-07-title-here.md&value=---%0Alayout:%20post%0Atitle:%20Enter%20Title%20Here%0Adate:2017-06-07%0A---%0AAnnouncement%20Here%20%E2%80%94%20don%E2%80%99t%20forget%20to%20edit%20the%20filename%20to%20include%20the%20title
$ ->
  navTimeout = null
  NProgress.configure
    parent: 'html'

  $(window).on 'load turbolinks:load', ->
    $('.hash-target').removeClass 'hash-target'

    if location.hash != ""
      $(location.hash).parent().addClass 'hash-target'
      
    date = new Date()
    dateStr = "#{p(date.getFullYear())}-#{p(date.getMonth() + 1)}-#{p(date.getDate())}"
    encodedValue = encodeURIComponent """
    ---
    layout: post
    title: Enter Title Here
    date:2017-06-07
    ---
    Announcement here — don’t forget to edit the filename to include the title.
    """
    $('.new-announcement-link').attr href: "https://github.com/Charcoal-SE/charcoal-se.github.io/new/site?filename=_posts/#{dateStr}-title-here.md&value=#{encodedValue}"

    $('h2,h3,h4,h5,h6').filter('[id]')
    .filter ->
      return !$(this).find('.small').length
    .each ->
      $(this).append(' ').append $('<span class="small">').append $('<a />').attr('href', '#' + this.id).append $ '<i class="fa fa-link" />'

    $('.footer-insert').remove().children().prependTo $ '.body + .footer'
  .on 'turbolinks:before-visit', (event) ->
    return if event.isDefaultPrevented()
    clearTimeout(navTimeout)
    NProgress.start()
    # navTimeout = setTimeout(NProgress.start, 100)
  .on 'turbolinks:visit', (event) ->
    return if event.isDefaultPrevented()
    clearTimeout(navTimeout)
    NProgress.done()
  .on 'click', '.link.alert', (event) ->
    return if event.isDefaultPrevented()
    Turbolinks.visit $(this).find('a').attr 'href'
