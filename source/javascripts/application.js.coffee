//= require_tree .
//= require bootstrap

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
  $("[data-toggle=tooltip]").tooltip()
  carousel = new Carousel("#testimonials-carousel", ".item")
  carousel.init()
