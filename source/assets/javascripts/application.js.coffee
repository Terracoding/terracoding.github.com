//= require_tree .
//= require bootstrap

class FluidVideos
  @init: (container=null, $videos=null) ->
    $videos ||= $("iframe[src*='vimeo.com'], iframe[src*='youtube.com']")

    $videos.each ->
      $(this)
        .data('aspectRatio', this.height/this.width)
        .removeAttr('height')
        .removeAttr('width')

    $(window).on "debouncedresize", ->
      $videos.each ->
        $elm = $(this)
        $parent = if container then $(container) else $elm.parent()
        newWidth = $parent.width()
        $elm
          .width(newWidth)
          .height(newWidth * $elm.data('aspectRatio'))

    $(window).resize()

class Carousel
  constructor: (carousel, itemClass) ->
    @$carousel = $(carousel)
    @$items = @$carousel.find(itemClass)
    @paddingBottom = 32

  resize: =>
    heights = []
    maxHeight = 0

    @$items.each (i, elm) ->
      $elm = $(elm)
      height = $elm.css("height", "auto").innerHeight()
      heights.push(height)
      maxHeight = height if height > maxHeight

    return if maxHeight == 0

    @$carousel.css("height", maxHeight+@paddingBottom)

    @$items.each (i, elm) ->
      $(elm).css
        height: maxHeight
        paddingTop: (maxHeight-heights[i])/2

  init: =>
    @resize()
    $(window).on("debouncedresize", @resize)

$ ->
  $("[data-toggle=tooltip]").tooltip({ container: 'body' })
  carousel = new Carousel("#testimonials-carousel", ".item")
  carousel.init()
  FluidVideos.init()
