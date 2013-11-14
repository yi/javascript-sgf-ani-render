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

  @makeURLFromWuid = (wuid)->
    return "#{SgfAniRender.ASSET_PATH}#{wuid}.sgf"

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
    @setFps()


  # 载入要播放的素材的wuid
  # @param {String} wuid
  # @param {String} url custom url
  load : (wuid, url)->

    #url = "#{SgfAniRender.ASSET_PATH}#{wuid}.sgf"
    url = url || SgfAniRender.makeURLFromWuid(wuid)

    #console.log "[sgf-ani-render::load] url:#{url}"

    if url is @url
      console.log "[sgf-ani-render::load] target url already loaded. #{url}"
      return @

    @url = url

    @stop()

    @containsError = false
    err = null

    # read binary data
    try
      ba = new BinFileReader(url)
      fileSize = ba.getFileSize()
    catch err
      @displayError err
      return @

    if isNaN(fileSize) or fileSize <= 0
      err = "fail to read image binary"
      console.log "[sgf-ani-render::constructor] #{err}"
      @displayError err
      return @

    # check signature
    signature = ba.readString(SgfAniRender.FILE_SIGNATURE.length, fileSize - SgfAniRender.FILE_SIGNATURE.length)
    if signature isnt SgfAniRender.FILE_SIGNATURE
      err = "invalid animation file"
      console.log "[sgf-ani-render::constructor] #{err}"
      @displayError err
      return @

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
      return @

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

    @setRegPoint(@regPointX, @regPointY)

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

    # 重置播放脚本
    @setPlayScript()

    return @

  # 设定播放脚本
  setPlayScript : (script)->

    return @ if @containsError # 在遭遇错误的时候跳过这个请求
    console.log "[sgf-ani-render::setPlayScript] script:#{script}"

    @frames = [0]

    # key: frame number
    # value: sound wuid
    @frameIdToSoundTrigger = {}

    script = String(script || "").trim()

    if script is ""
      # 空白的播放脚本
      for i in [1...@assetFrameNum] by 1
        @frames.push i
    else
      # 特定的播放脚本

      # 从播放脚本中解析出音效的wuid
      soundWuids = []
      script = script.replace /[a-z0-9A-Z]+/g, (wuid)->
        soundWuids.push wuid
        url = SgfAniRender.makeURLFromWuid(wuid)
        console.log "[sgf-ani-render::setPlayScript] url:#{url}, wuid:#{wuid}"
        #createjs.Sound.registerSound(url, wuid)
        return "^"

      # 过滤掉非播放脚步的字符
      script = script.replace(/[^\-\+\^]/g, '')
      currentAssetFrame = 0

      for i in [0...script.length] by 1
        cmd = script.charAt(i)
        if cmd is "^"
          # 遇到一个发音标记
          @frameIdToSoundTrigger[currentAssetFrame] = soundWuids.shift()
          continue
        ++ currentAssetFrame if cmd is "+"
        currentAssetFrame = (@assetFrameNum - 1) if currentAssetFrame >= @assetFrameNum
        @frames.push currentAssetFrame

    return @

  toggleRegAid : ->
    return @ if @containsError # 在遭遇错误的时候跳过这个请求

    @isShowRegAid = not @isShowRegAid
    if @isShowRegAid
      @regAidH.show()
      @regAidV.show()
    else
      @regAidH.hide()
      @regAidV.hide()
    return @

  switchBackground : ->
    return @ if @containsError # 在遭遇错误的时候跳过这个请求
    #console.log "[sgf-ani-render::switchBackground] @bgColor:#{@bgColor}"
    @setBackground(SgfAniRender.BG_LIST[SgfAniRender.BG_LIST.indexOf(@bgColor) + 1])
    return @

  togglePlay : ->
    return @ if @containsError # 在遭遇错误的时候跳过这个请求
    if @tickToPlay
      @stop()
      @btnPlayControl.attr
        fill : SgfAniRender.ICON_PLAY
    else
      @play()
      @btnPlayControl.attr
        fill : SgfAniRender.ICON_PAUSE
    return @

  stop : ->
    return @ if @containsError # 在遭遇错误的时候跳过这个请求
    clearTimeout @tickToPlay if @tickToPlay?
    @tickToPlay = null
    return @

  restart : ->
    return @ if @containsError # 在遭遇错误的时候跳过这个请求
    @stop()
    @currentFrame = -1
    @play()
    return @

  play : ->
    return @ if @containsError # 在遭遇错误的时候跳过这个请求
    #console.log "[sgf-ani-render::play] spf:#{@spf}"
    @goto(@currentFrame + 1)
    @tickToPlay = setTimeout =>
      @play()
    , @spf
    return @

  goto : (num)->
    return @ if @containsError # 在遭遇错误的时候跳过这个请求
    #num = (parseInt(num, 10) || 0) % @assetFrameNum
    #num = (@assetFrameNum + num) % @assetFrameNum if num < 0
    framesLength = @frames.length

    num = (parseInt(num, 10) || 0) % framesLength
    num = framesLength + (num % framesLength) if num < 0
    @currentFrame = num

    if (soundWuid = @frameIdToSoundTrigger[num])?
      #console.log "[sgf-ani-render::goto] play sound:#{soundWuid}"
      new Audio(SgfAniRender.makeURLFromWuid(soundWuid)).play()
      #createjs.Sound.play(soundWuid)

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

    return @

  setFps : (val)->
    return @ if @containsError # 在遭遇错误的时候跳过这个请求

    val = (parseInt(val, 10) || SgfAniRender.DEFAULT_FPS) % SgfAniRender.MAX_FPS
    val = SgfAniRender.DEFAULT_FPS if val < 1 or val > SgfAniRender.MAX_FPS
    @fps = val
    @spf = Math.ceil(1000 / val)
    console.log "[sgf-ani-render::setFps] fps:#{@fps}, spf:#{@spf}"
    return @

  setRegPoint : (x, y)->
    return @ if @containsError # 在遭遇错误的时候跳过这个请求
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

    return @

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
    return @

  toString : ->
    "[SgfAniRender url:#{@url}]"

  setTitle : (msg)->
    @displayLabel msg unless @containsError
    return @

  displayError : (msg) ->
    @containsError = true
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
    msg = String(msg || "").trim()
    msg = msg.replace('{fps}', @fps).replace('{assetFrameNum}', @assetFrameNum)
    @label.attr
      "font-family" : "arial"
      "font-size" : "14"
      "text-anchor" : "start"
      "fill" : "#333"
      "text" : msg
    return


window.SgfAniRender = SgfAniRender






