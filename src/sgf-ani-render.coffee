##
# sgf-ani-render
# https://github.com/yi/javascript-sgf-ani-render
#
# Copyright (c) 2013 yi
# Licensed under the MIT license.
##

class SgfAniRender

  # base64 of transparent background image
  @BG_TRANSPARENT = "url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAAA3NCSVQICAjb4U/gAAAABlBM
VEXf39////8zI3BgAAAACXBIWXMAAAsSAAALEgHS3X78AAAAFnRFWHRDcmVhdGlvbiBUaW1l
ADEwLzA5LzEzL23IjwAAABx0RVh0U29mdHdhcmUAQWRvYmUgRmlyZXdvcmtzIENTNui8sowA
AAARSURBVAiZY/jPwIAVYRf9DwB+vw/x5A8ThgAAAABJRU5ErkJggg==)"

  @ICON_PLAY = "url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAgMAAABinRfyAAAAA3NCSVQICAjb4U/gAAAADFBM
VEX///8AAAAAAAAAAAD4jAJNAAAABHRSTlMARJm7ODAY0QAAAAlwSFlzAAALEgAACxIB0t1+
/AAAABx0RVh0U29mdHdhcmUAQWRvYmUgRmlyZXdvcmtzIENTNui8sowAAAAWdEVYdENyZWF0
aW9uIFRpbWUAMTAvMTEvMTPXucnQAAAAKklEQVQImTXMMQ4AAAjCQP8/8V2nagccyCUQJ/O3
BhKJRCKRjbRIx+kDcbwHJDFPvYXLAAAAAElFTkSuQmCC)"

  @ICON_PAUSE = "url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAAA3NCSVQICAjb4U/gAAAABlBM
VEX///8AAABVwtN+AAAAAnRSTlMAuyogpzwAAAAJcEhZcwAACxIAAAsSAdLdfvwAAAAcdEVY
dFNvZnR3YXJlAEFkb2JlIEZpcmV3b3JrcyBDUzbovLKMAAAAFnRFWHRDcmVhdGlvbiBUaW1l
ADEwLzExLzEz17nJ0AAAAA5JREFUCJlj+GPPQAoCAN6nE7EZ+6SGAAAAAElFTkSuQmCC)"

  @ICON_AIM = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAA3NCSVQICAjb4U/gAAAAVFBM
VEX///9jcJVNev9OevtPefRReO1SeOhTd+BXdc9Ydc1YdcladMRmb4lbdL5dc7Vec7Ffcqxe
cq9icZxlb49mb4lmb4dpbXlnboJsbGxsbG5rbHEiIiJyfgGzAAAAHHRSTlMAVYiIiIiIiJmZ
mZmZqqqqqqq7zN3d3d3/////Jrqp7AAAAAlwSFlzAAALEgAACxIB0t1+/AAAABx0RVh0U29m
dHdhcmUAQWRvYmUgRmlyZXdvcmtzIENTNui8sowAAAAWdEVYdENyZWF0aW9uIFRpbWUAMTAv
MTEvMTPXucnQAAAAd0lEQVQYlW2P4Q7CMAiES+t0auemVgrj/d9zo6Au0/tBcl8ulyMQUVCJ
HjVmHazoFzQBrmGE8Fbmcu76wtk9zFOKMaY7ewaf0fRCA9w7GLRSROjg4Mhicy7bhHaUZKB6
B/DY/IPgu+N6ulXKn62ATNyW/ntu9/4CzvIHc4Ju2MsAAAAASUVORK5CYII="

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

  @MIN_CANVAS_SIZE = 256

  @BG_LIST = ["trans", "black","white","red","green","blue","grey"]

  @start = ->
    @ox = @attr("x")
    @oy = @attr("y")
    @animate
      opacity: .5
    , 500, ">"
    return

  @move = (dx, dy) ->
    @newX = @ox + dx - 8
    @newY = @oy + dy - 8
    @attr
      x: @newX
      y: @newY
    return

  @up = ->
    @attr
      x: @ox
      y: @oy
    @animate
      opacity: 1
    , 500, ">"
    return unless @newX? and @newY?
    @parent.setRegPoint(@newX + 8, @newY + 8)
    delete @newX
    delete @newY
    return


  # 构造函数
  # @param {HTMLElement || String} parentElement
  # @param {String} url
  # @param {String} title
  constructor : (parentElement, @url, title)->
    unless parentElement? and @url?
      console.log "[sgf-ani-render::constructor] bad arguments, parentElement:#{parentElement}, @url={@url}"
      return

    err = null

    try
      ba = new BinFileReader(url)
      fileSize = ba.getFileSize()
    catch err
      @displayError err
      return

    if isNaN(fileSize) or fileSize <= 0
      err = "fail to read image binary"
      console.log "[sgf-ani-render::constructor] #{err}"
      @displayError err
      return

    signature = ba.readString(SgfAniRender.FILE_SIGNATURE.length, fileSize - SgfAniRender.FILE_SIGNATURE.length)
    if signature isnt SgfAniRender.FILE_SIGNATURE
      err = "invalid animation file"
      console.log "[sgf-ani-render::constructor] #{err}"
      @displayError err
      return

    ba.movePointer(- SgfAniRender.INTEGER_BYTE_LENGTH - SgfAniRender.FILE_SIGNATURE.length)

    amfLen = ba.readInt()

    ba.movePointer(- SgfAniRender.INTEGER_BYTE_LENGTH - amfLen)
    @canvasWidth = ba.readShort()
    @canvasWidth = SgfAniRender.MIN_CANVAS_SIZE if @canvasWidth < SgfAniRender.MIN_CANVAS_SIZE

    @canvasHeight = ba.readShort()
    @canvasHeight = SgfAniRender.MIN_CANVAS_SIZE if @canvasHeight < SgfAniRender.MIN_CANVAS_SIZE

    @regPointX = ba.readShort()
    @regPointY = ba.readShort()
    @assetFrameNum = ba.readShort()

    if @canvasWidth > SgfAniRender.MAX_CANVAS_SIZE or @canvasHeight > SgfAniRender.MAX_CANVAS_SIZE or @assetFrameNum <= 0
      err ="bad animation attrs, canvasWidth:#{@canvasWidth}, @canvasHeight:#{@canvasHeight}, @assetFrameNum:#{@assetFrameNum}"
      console.log "[sgf-ani-render::constructor] #{err}"
      @displayError err
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

    # add bg control button
    @btnBgColor = @paper.rect(@canvasWidth - 21, @canvasHeight - 21, 16, 16)
    @btnBgColor.attr(
      fill : SgfAniRender.BG_TRANSPARENT
      stroke : "#333"
    ).click => @switchBackground()
    @setBackground()

    # add play control button
    # must use rect, cause the inside icon changes
    @btnPlayControl = @paper.rect(5, @canvasHeight - 21, 16, 16)
    @btnPlayControl.attr(
      fill : SgfAniRender.ICON_PAUSE
      stroke : "#none"
    ).click => @togglePlay()

    # display title
    if title? then @paper.text(10, 15, String(title)).attr
      "font-family" : "arial"
      "font-size" : "14"
      "text-anchor" : "start"
      "fill" : "#999"

    @setFps()

    @elFrame = @paper.image(@url, 0, 0, @assetWidth, @assetHight)
    @elFrame.node.setAttribute("pointer-events", "none")

    @setRegPoint(@regPointX, @regPointY)

    # add reg control button
    @btnRegControl = @paper.image(SgfAniRender.ICON_AIM, @canvasWidth - 47, @canvasHeight - 21, 16, 16)
    .drag(SgfAniRender.move, SgfAniRender.start, SgfAniRender.up).parent = @
    #.click(=> @toggleRegLAid())

    @restart()

    return

  toggleRegLAid : ->
    @isShowRegAid = not @isShowRegAid
    if @isShowRegAid
      @regAidH.show()
      @regAidV.show()
    else
      @regAidH.hide()
      @regAidV.hide()
    return

  switchBackground : ->
    #console.log "[sgf-ani-render::switchBackground] @bgColor:#{@bgColor}"
    @setBackground(SgfAniRender.BG_LIST[SgfAniRender.BG_LIST.indexOf(@bgColor) + 1])
    return

  togglePlay : ->
    if @tickToPlay
      @stop()
      @btnPlayControl.attr
        fill : SgfAniRender.ICON_PLAY
    else
      @play()
      @btnPlayControl.attr
        fill : SgfAniRender.ICON_PAUSE
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

    return

  setFps : (val)->
    val = (parseInt(val, 10) || SgfAniRender.DEFAULT_FPS) % SgfAniRender.MAX_FPS
    val = SgfAniRender.DEFAULT_FPS if val < 1 or val > SgfAniRender.MAX_FPS
    @fps = val
    @spf = Math.ceil(1000 / val)
    #console.log "[sgf-ani-render::setFps] fps:#{@fps}, spf:#{@spf}"
    return

  setRegPoint : (x, y)->
    #console.log "[sgf-ani-render::setRegPoint] #{x}, #{y}"
    @regPointX = x
    @regPointY = y
    @regAidH = @regAidH || @paper.path("M0 #{y}L#{@canvasWidth} #{y}").attr
      "stroke-dasharray" : ". "
      "stroke-opacity" : "1"
      "stroke" : "#F00"

    @regAidH.animate
      path : "M0 #{y}L#{@canvasWidth} #{y}"
    , 500

    #@regAidH.attr
      #d : "M0 #{y}L#{@canvasWidth} #{y}"
    @regAidV = @regAidV || @paper.path("M#{x} 0L#{x} #{@canvasHeight}").attr
      "stroke-dasharray" : ". "
      "stroke-opacity" : "1"
      "stroke" : "#F00"
    @regAidV.animate
      path : "M#{x} 0L#{x} #{@canvasHeight}"
    , 500
    #@regAidV.attr
      #d : "M#{x} 0L#{x} #{@canvasHeight}"
    @isShowRegAid = true

    return

  setBackground : (bgColor)->
    bgColor = String(bgColor).toLowerCase()
    switch bgColor
      when "white"
        @bgColor = "white"
        fill = "#FFF"
      when "black"
        @bgColor = "black"
        fill = "#000"
      when "red"
        @bgColor = "red"
        fill = "#F00"
      when "green"
        @bgColor = "green"
        fill = "#0F0"
      when "blue"
        @bgColor = "blue"
        fill = "#00F"
      when "grey", "gray"
        @bgColor = "grey"
        fill = "#999"
      else
        @bgColor = "trans"
        fill = SgfAniRender.BG_TRANSPARENT

    @elBackgrond.attr "fill", fill
    @btnBgColor.attr "fill", fill
    return

  toString : ->
    "[SgfAniRender url:#{@url}]"

  displayError : (msg) ->
    document.write "<div style='disply:block; width:256px; height:256px; background:#999; border:1px solid #f00; color:#f00'>#{msg}</div>"
    return


window.SgfAniRender = SgfAniRender






