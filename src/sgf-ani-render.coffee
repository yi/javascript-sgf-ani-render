##
# sgf-ani-render
# https://github.com/yi/javascript-sgf-ani-render
#
# Copyright (c) 2013 yi
##

class SgfAniRender

  # base64 of transparent background image
  @BG_TRANSPARENT = "url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAAA3NCSVQICAjb4U/gAAAABlBM VEXf39////8zI3BgAAAACXBIWXMAAAsSAAALEgHS3X78AAAAFnRFWHRDcmVhdGlvbiBUaW1l ADEwLzA5LzEzL23IjwAAABx0RVh0U29mdHdhcmUAQWRvYmUgRmlyZXdvcmtzIENTNui8sowA AAARSURBVAiZY/jPwIAVYRf9DwB+vw/x5A8ThgAAAABJRU5ErkJggg==)"

  # base64 of play icon
  @ICON_PLAY = "url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAgMAAABinRfyAAAAA3NCSVQICAjb4U/gAAAADFBM VEX///8AAAAAAAAAAAD4jAJNAAAABHRSTlMARJm7ODAY0QAAAAlwSFlzAAALEgAACxIB0t1+ /AAAABx0RVh0U29mdHdhcmUAQWRvYmUgRmlyZXdvcmtzIENTNui8sowAAAAWdEVYdENyZWF0 aW9uIFRpbWUAMTAvMTEvMTPXucnQAAAAKklEQVQImTXMMQ4AAAjCQP8/8V2nagccyCUQJ/O3 BhKJRCKRjbRIx+kDcbwHJDFPvYXLAAAAAElFTkSuQmCC)"

  # base64 of pause icon
  @ICON_PAUSE = "url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAAA3NCSVQICAjb4U/gAAAABlBM VEX///8AAABVwtN+AAAAAnRSTlMAuyogpzwAAAAJcEhZcwAACxIAAAsSAdLdfvwAAAAcdEVY dFNvZnR3YXJlAEFkb2JlIEZpcmV3b3JrcyBDUzbovLKMAAAAFnRFWHRDcmVhdGlvbiBUaW1l ADEwLzExLzEz17nJ0AAAAA5JREFUCJlj+GPPQAoCAN6nE7EZ+6SGAAAAAElFTkSuQmCC)"

  # base64 of target icon
  @ICON_AIM = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAA3NCSVQICAjb4U/gAAAAGFBM VEX///8cHBwMDAwrKysXFxclJSUlJSUQEBASWjZYAAAACHRSTlMA////RKr//3XOcfIAAAAJ cEhZcwAACxIAAAsSAdLdfvwAAAA8dEVYdEFMVFRhZwBUaGlzIGlzIHRoZSBpY29uIGZyb20g R2VudGxlZmFjZS5jb20gZnJlZSBpY29ucyBzZXQuINhr6MQAAAAcdEVYdFNvZnR3YXJlAEFk b2JlIEZpcmV3b3JrcyBDUzbovLKMAAAAQXRFWHREZXNjcmlwdGlvbgBUaGlzIGlzIHRoZSBp Y29uIGZyb20gR2VudGxlZmFjZS5jb20gZnJlZSBpY29ucyBzZXQuIFR+b4cAAAAfdEVYdENv cHlyaWdodABST1lBTFRZIEZSRUUgTElDRU5TRSDe2YtpAAAAX0lEQVQImWNgQAIsJmgMVmNj UzAjOMQkOAAkkMKQwJIKZDAGMCQwBAJVOjoAeY4uDI6CggIMgoKCEBGXQBcGBvYAhgKGcJCu EoYClhKQOUEhKkEBYJOVlFSgdqkwIDEATgUMeYxn03gAAAAASUVORK5CYII="

  # base64 of brush icon
  @ICON_BRUSH = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAA3NCSVQICAjb4U/gAAAAGFBM VEX///8iIiIqKioYGBgYGBgcHBwYGBgMDAxAz6O/AAAACHRSTlMA///M//8RZnplY+YAAAAJ cEhZcwAACxIAAAsSAdLdfvwAAAA8dEVYdEFMVFRhZwBUaGlzIGlzIHRoZSBpY29uIGZyb20g R2VudGxlZmFjZS5jb20gZnJlZSBpY29ucyBzZXQuINhr6MQAAABEdEVYdENvcHlyaWdodABD cmVhdGl2ZSBDb21tb25zIEF0dHJpYnV0aW9uIE5vbi1Db21tZXJjaWFsIE5vIERlcml2YXRp dmVze92woAAAAEF0RVh0RGVzY3JpcHRpb24AVGhpcyBpcyB0aGUgaWNvbiBmcm9tIEdlbnRs ZWZhY2UuY29tIGZyZWUgaWNvbnMgc2V0LiBUfm+HAAAAHHRFWHRTb2Z0d2FyZQBBZG9iZSBG aXJld29ya3MgQ1M26LyyjAAAAG9JREFUCJljYAADdiUIzVAEZrAlsCupg+gidSOlAiAjWVBQ UBwkYAhkGAAZzMKFgoJAGTbzUvPQ0DCgCvNy4xIXNwYG45IyZ3MXoFS5c0myszNIrbm7eYkZ yNyUYvfiBBAjzaTEAGKhuXMC1AlgFQDpxxNswBv1gwAAAABJRU5ErkJggg=="

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

  # minimuns canvas size acceptable
  @MIN_CANVAS_SIZE = 256

  # max number of asset allowed
  @MAX_ASSET_FRAME_COUNT = 32

  # acceptable background color name
  @BG_LIST = ["transparent", "black","white","red","green","blue","grey"]

  # default background
  @DEFAULT_BACKGROUND = "transparent"

  @ASSET_PATH = "./"

  # start the play
  @start = ->
    @ox = @attr("x")
    @oy = @attr("y")
    @animate
      opacity: .5
    , 500, ">"
    return

  # handle reg point move
  @move = (dx, dy) ->
    @newX = @ox + dx - 8
    @newY = @oy + dy - 8
    @attr
      x: @newX
      y: @newY
    return

  # when release the reg point hanlder
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

  # @param {String} script, "-" means repeat previous frame, "+" means goto the next frame
  # @return {byte[]} frame number in an array
  @parsePlayScript = (script, assetFrameCount)->

    # validate input
    assetFrameCount = (assetFrameCount || SgfAniRender.MAX_ASSET_FRAME_COUNT) % (SgfAniRender.MAX_ASSET_FRAME_COUNT + 1)
    assetFrameCount = 0 if assetFrameCount < 0
    script = String(script || "").trim().replace(/[^\-\+]/g,'')

    result = [0]
    currentAssetFrame = 0

    for i in [0...script.length]
      cmd = script.charAt(i)
      ++ currentAssetFrame if cmd is "+"
      currentAssetFrame = assetFrameCount if currentAssetFrame >= assetFrameCount
      result.push currentAssetFrame

    return result



  # 构造函数
  # @param {HTMLElement || String} parentElement
  constructor : (parentElement, background, @fixedCanvasWidth, @fixedCanvasHeight) ->
    #console.log "[sgf-ani-render::constructor] background:#{background}"

    unless parentElement?
      throw "[sgf-ani-render::constructor] bad parentElement:#{parentElement}"
      return

    # check input range
    @fixedCanvasWidth = parseInt(@fixedCanvasWidth, 10) || 0
    @fixedCanvasWidth = 0 if @fixedCanvasWidth < SgfAniRender.MIN_CANVAS_SIZE
    @fixedCanvasWidth = SgfAniRender.MAX_CANVAS_SIZE if @fixedCanvasWidth > SgfAniRender.MAX_CANVAS_SIZE

    @fixedCanvasHeight= parseInt(@fixedCanvasHeight, 10) || 0
    @fixedCanvasHeight= 0 if @fixedCanvasHeight < SgfAniRender.MIN_CANVAS_SIZE
    @fixedCanvasHeight= SgfAniRender.MAX_CANVAS_SIZE if @fixedCanvasHeight > SgfAniRender.MAX_CANVAS_SIZE

    @paper = Raphael parentElement, @fixedCanvasWidth || SgfAniRender.MIN_CANVAS_SIZE, @fixedCanvasHeight || SgfAniRender.MIN_CANVAS_SIZE
    @setBackground background

    # add bg control button
    @btnBgColor = @paper.image(SgfAniRender.ICON_BRUSH, @paper.width - 21, @paper.height - 21, 16, 16).click => @switchBackground()

    # add play control button
    # must use rect, cause the inside icon changes
    @btnPlayControl = @paper.rect(5, @paper.height - 21, 16, 16)
    @btnPlayControl.attr(
      fill : SgfAniRender.ICON_PAUSE
      stroke : "#none"
    ).click => @togglePlay()

    # add reg control button
    @btnRegControl = @paper.image(SgfAniRender.ICON_AIM, @paper.width - 47, @paper.height - 21, 16, 16)
    .drag(SgfAniRender.move, SgfAniRender.start, SgfAniRender.up)
    @btnRegControl.parent = @


  # 构造函数
  # @param {HTMLElement || String} parentElement
  # @param {String} url
  # @param {Object} config: {
  #     title:String
  # }
  #
  load : (wuid, title, fps, playScript)->

    url = "#{SgfAniRender.ASSET_PATH}#{wuid}.sgf"

    console.log "[sgf-ani-render::load] url:#{url}"

    if url is @url
      console.log "[sgf-ani-render::load] target url already loaded. #{url}"
      return

    @url = url

    @displayLabel(title || "")

    @stop()

    err = null

    # read binary data
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

    # check signature
    signature = ba.readString(SgfAniRender.FILE_SIGNATURE.length, fileSize - SgfAniRender.FILE_SIGNATURE.length)
    if signature isnt SgfAniRender.FILE_SIGNATURE
      err = "invalid animation file"
      console.log "[sgf-ani-render::constructor] #{err}"
      @displayError err
      return

    ba.movePointer(- SgfAniRender.INTEGER_BYTE_LENGTH - SgfAniRender.FILE_SIGNATURE.length)

    amfLen = ba.readInt()

    ba.movePointer(- SgfAniRender.INTEGER_BYTE_LENGTH - amfLen)

    canvasWidth = ba.readShort()
    canvasWidth = SgfAniRender.MIN_CANVAS_SIZE if canvasWidth < SgfAniRender.MIN_CANVAS_SIZE

    canvasHeight = ba.readShort()
    canvasHeight = SgfAniRender.MIN_CANVAS_SIZE if canvasHeight < SgfAniRender.MIN_CANVAS_SIZE

    @regPointX = ba.readShort()
    @regPointY = ba.readShort()
    @assetFrameNum = ba.readShort()

    if canvasWidth > SgfAniRender.MAX_CANVAS_SIZE or canvasHeight > SgfAniRender.MAX_CANVAS_SIZE or @assetFrameNum <= 0
      err ="bad animation attrs, canvasWidth:#{canvasWidth}, canvasHeight:#{canvasHeight}, @assetFrameNum:#{@assetFrameNum}"
      console.log "[sgf-ani-render::load] #{err}"
      @displayError err
      return

    if @fixedCanvasWidth is 0 and @fixedCanvasHeight is 0
      @_setCanvasSize canvasWidth, canvasHeight

    # 每帧动画在png压缩画布上的 x,y,w,h
    @assetRects = []

    # 每帧动画在原尺寸画布上的 x,y,w,h
    @originalRects = []

    @assetHight = 0
    @assetWidth = 0

    # read each asset rect info
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

    @setFps(fps)

    @setRegPoint(@regPointX, @regPointY)

    @setPlayScript(playScript)

    if @btnPlayControl? then @btnPlayControl.show()
    if @btnBgColor? then @btnBgColor.show()
    if @btnRegControl? then @btnRegControl.show()

    # load in images to canvas
    unless @elFrame?
      @elFrame = @paper.image(@url, 0, 0, @assetWidth, @assetHight)
      @elFrame.node.setAttribute("pointer-events", "none")
    else
      @elFrame.attr
        href  : @url
        width : @assetWidth
        height : @assetHight
      @elFrame.node.href.baseVal = @url

    @restart()
    return

  # 设定播放脚本
  setPlayScript : (script)->
    script = String(script || "").trim()

    if script is ""
      # no script
      @frames = [0]
      for i in [1...@assetFrameNum]
        @frames.push i
    else
      # with specifed script
      @frames = SgfAniRender.parsePlayScript(script, @assetFrameNum)
    return

  toggleRegAid : ->
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
    clearTimeout @tickToPlay if @tickToPlay?
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
    #num = (parseInt(num, 10) || 0) % @assetFrameNum
    #num = (@assetFrameNum + num) % @assetFrameNum if num < 0
    framesLength = @frames.length

    num = (parseInt(num, 10) || 0) % framesLength
    num = framesLength + (num % framesLength) if num < 0
    @currentFrame = num

    assetFrame = @frames[num]
    assetRect = @assetRects[assetFrame]
    originalRect = @originalRects[assetFrame]

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
    @regAidH = @regAidH || @paper.path("M0 #{y}L#{@paper.width} #{y}").attr
      "stroke-dasharray" : ". "
      "stroke-opacity" : "1"
      "stroke" : "#F00"

    @regAidH.animate
      path : "M0 #{y}L#{@paper.width} #{y}"
    , 500

    @regAidV = @regAidV || @paper.path("M#{x} 0L#{x} #{@paper.height}").attr
      "stroke-dasharray" : ". "
      "stroke-opacity" : "1"
      "stroke" : "#F00"
    @regAidV.animate
      path : "M#{x} 0L#{x} #{@paper.height}"
    , 500
    @isShowRegAid = true

    return

  _setCanvasSize : (w, h)->
    @paper.setSize(w,h)
    if @elBackgrond? then @elBackgrond.attr
      "width" : w
      "height" : h
    if @btnPlayControl then @btnPlayControl.attr
      y : @paper.height - 21
    if @btnBgColor? then @btnBgColor.attr
      x : @paper.width - 21
      y : @paper.height - 21
    if @btnRegControl?
      @btnRegControl.attr
        x : @paper.width - 47
        y : @paper.height - 21
    return

  setBackground : (bgColor)->
    bgColor = String(bgColor).toLowerCase()

    unless @elBackgrond?
      @elBackgrond = @paper.rect 0, 0, @paper.width, @paper.height
      @elBackgrond.attr "stroke" : "#999"

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
        @bgColor = "transparent"
        fill = SgfAniRender.BG_TRANSPARENT

    @elBackgrond.attr "fill", fill
    #@btnBgColor.attr "fill", fill
    return

  toString : ->
    "[SgfAniRender url:#{@url}]"

  displayError : (msg) ->
    @label = @label || @paper.text(10, 15, String(msg))
    @label.attr
      "font-family" : "arial"
      "font-size" : "14"
      "text-anchor" : "start"
      "fill" : "#f00"
      "text" : msg
    if @btnPlayControl? then @btnPlayControl.hide()
    if @btnBgColor? then @btnBgColor.hide()
    if @btnRegControl? then @btnRegControl.hide()
    @setBackground("grey")
    return

  displayLabel : (msg) ->
    @label = @label ||  @paper.text(10, 15, String(msg))
    @label.attr
      "font-family" : "arial"
      "font-size" : "14"
      "text-anchor" : "start"
      "fill" : "#333"
      "text" : msg
    return


window.SgfAniRender = SgfAniRender






