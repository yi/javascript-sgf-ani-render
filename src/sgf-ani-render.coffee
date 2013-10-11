##
# sgf-ani-render
# https://github.com/yi/javascript-sgf-ani-render
#
# Copyright (c) 2013 yi
# Licensed under the MIT license.
##

class SgfAniRender

  # base64 of transparent background image
  @IMG_TRANSPARENT = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAAA3NCSVQICAjb4U/gAAAABlBM
VEXf39////8zI3BgAAAACXBIWXMAAAsSAAALEgHS3X78AAAAFnRFWHRDcmVhdGlvbiBUaW1l
ADEwLzA5LzEzL23IjwAAABx0RVh0U29mdHdhcmUAQWRvYmUgRmlyZXdvcmtzIENTNui8sowA
AAARSURBVAiZY/jPwIAVYRf9DwB+vw/x5A8ThgAAAABJRU5ErkJggg=="

  # max fps acceptable
  @MAX_FPS = 60

  # defaut fps
  @DEFAULT_FPS = 24

  # sgf file signature
  @FILE_SIGNATURE = "SGF-asset"

  # number of bytes per int
  @INTEGER_BYTE_LENGTH = 4

  # max canvas size acceptable
  @MAX_CANVAS_SIZE = 2048

  #@TOOLBAR_HEIGHT = 30

  # 构造函数
  # @param {HTMLElement || String} parentElement
  # @param {String} url
  # @param {String} title
  # @param {Function} onChange, signature: onChange(eventObj)->
  #                   eventObj: type: and value:
  constructor : (parentElement, @url, title, @onChange)->
    unless parentElement? and @url?
      console.log "[sgf-ani-render::constructor] bad arguments, parentElement:#{parentElement}, @url={@url}"
      return

    ba = new BinFileReader(url)
    fileSize = ba.getFileSize()

    if isNaN(fileSize) or fileSize <= 0
      console.log "[sgf-ani-render::constructor] fail to read image binary"
      return

    signature = ba.readString(SgfAniRender.FILE_SIGNATURE.length, fileSize - SgfAniRender.FILE_SIGNATURE.length)
    if signature isnt SgfAniRender.FILE_SIGNATURE
      console.log "[sgf-ani-render::constructor] invalid animation file"
      return

    ba.movePointer(- SgfAniRender.INTEGER_BYTE_LENGTH - SgfAniRender.FILE_SIGNATURE.length)

    amfLen = ba.readInt()

    ba.movePointer(- SgfAniRender.INTEGER_BYTE_LENGTH - amfLen)
    @canvasWidth = ba.readShort()
    @canvasHeight = ba.readShort()
    @regPointX = ba.readShort()
    @regPointY = ba.readShort()
    @assetFrameNum = ba.readShort()

    if @canvasWidth > SgfAniRender.MAX_CANVAS_SIZE or @canvasHeight > SgfAniRender.MAX_CANVAS_SIZE or @assetFrameNum <= 0
      console.log "[sgf-ani-render::constructor] bad animation attrs, canvasWidth:#{@canvasWidth}, @canvasHeight:#{@canvasHeight}, @assetFrameNum:#{@assetFrameNum}"
      return

    # 每帧动画在png压缩画布上的 x,y,w,h
    @assetRects = []

    # 每帧动画在原尺寸画布上的 x,y,w,h
    @originalRects = []

    @assetHight = 0
    @assetWidth = 0

    yScroll = 0
    for i in [0...@assetFrameNum] by 1
      left  = ba.readShort()
      top   = ba.readShort()
      width = ba.readShort()
      height = ba.readShort()

      @originalRects.push
        left : left
        top : top
        width : width
        height : height

      @assetRects.push
        left : 0
        top : yScroll
        width : width
        height : height

      @assetHight += height
      @assetWidth = width if width > @assetWidth

      yScroll += height

    ## complte image binary file parsing
    #console.log @

    @paper = Raphael parentElement, @canvasWidth, @canvasHeight

    # build background
    @elBackgrond = @paper.rect 0, 0, @canvasWidth, @canvasHeight
    @elBackgrond.attr "stroke" : "#999"
    @setBackground()

    # display title
    if title? then @paper.text(10, 15, String(title)).attr
      "font-family" : "arial"
      "font-size" : "14"
      "text-anchor" : "start"
      "fill" : "#999"

    @setFps()

    @elFrame = @paper.image @url, 0, 0, @assetWidth, @assetHight

    @setRegPoint(@regPointX, @regPointY)

    @restart()

    return


  togglePlay : ->
    if @tickToPlay then @stop() else @play()
    return

  stop : ->
    clearTimeout @tickToPlay
    @tickToPlay = null
    return

  restart : ->
    @currentFrame = -1
    @play()
    return

  play : ->
    @goto(@currentFrame + 1)
    @tickToPlay = setTimeout =>
      @play()
    , @spf
    return

  goto : (num)->
    num = (parseInt(num, 10) || 0) % @assetFrameNum
    num = (@assetFrameNum + num) % @assetFrameNum if num < 0
    assetRect = @assetRects[num]
    originalRect = @originalRects[num]
    @currentFrame = num

    assetLeft = originalRect.left
    assetTop = originalRect.top - assetRect.top

    rectLeft = originalRect.left
    rectTop = originalRect.top

    @elFrame.attr
      x : assetLeft
      y : assetTop
      "clip-rect":  "#{rectLeft},#{rectTop},#{assetRect.width},#{assetRect.height}"

    if @onChange then @onChange
      currentFrame : @currentFrame

    return

  setFps : (val)->
    val = (parseInt(val, 10) || SgfAniRender.DEFAULT_FPS) % SgfAniRender.MAX_FPS
    val = SgfAniRender.DEFAULT_FPS if val < 1 or val > SgfAniRender.MAX_FPS
    @fps = val
    @spf = Math.ceil(1000 / val)
    #console.log "[sgf-ani-render::setFps] fps:#{@fps}, spf:#{@spf}"
    return

  setRegPoint : (x, y)->
    @regPointX = x
    @regPointY = y
    @paper.path("M0 #{y}L#{@canvasWidth} #{y}").attr
      "stroke-dasharray" : ". "
      "stroke-opacity" : "1"
      "stroke" : "#F00"
    @paper.path("M#{x} 0L#{x} #{@canvasHeight}").attr
      "stroke-dasharray" : ". "
      "stroke-opacity" : "1"
      "stroke" : "#F00"

    return

  setBackground : (bgColor)->
    bgColor = String(bgColor).toLowerCase()
    switch bgColor
      when "red" then fill = "#F00"
      when "green" then fill = "#0F0"
      when "blue" then fill = "#00F"
      when "grey", "gray" then fill = "#999"
      else fill = "url(#{SgfAniRender.IMG_TRANSPARENT})"

    @elBackgrond.attr "fill", fill
    return

  toString : ->
    "[SgfAniRender url:#{@url}]"



window.SgfAniRender = SgfAniRender






