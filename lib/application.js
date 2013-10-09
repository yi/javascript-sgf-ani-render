// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$j(document).bind('beforeReveal.facebox', function() { $j('div.flash').fadeOut(); })

$j(function(){
     $j('a[rel*=facebox]').facebox();
   }
);

function coordinateElementsToMapEditor(elementType, hiddenFieldId){
  var wuids = $j('#'+hiddenFieldId).val();
  var methodToInvoke = 'add'+elementType;
  var s = "document['Main']." + methodToInvoke +"('"+wuids+"')";
  eval(s);
}

var Subform = Class.create({
  lineIndex: 1,
  parentElement: "",
  initialize: function(rawHTML, lineIndex, parentElement) {
    this.rawHTML        = rawHTML;
    this.lineIndex      = lineIndex;
    this.parentElement  = parentElement;
  },
  parsedHTML: function() {
    return this.rawHTML.replace(/INDEX/g, this.lineIndex++);
  },
  add: function() {
    new Insertion.Bottom($(this.parentElement), this.parsedHTML());
  }
});

$j.fn.sgfplay = function(method, options) {
  if (!this.length) return this;

  return this.each(function() {
    var img = $j(this),
        obj = img.parent(),
        wrap = obj.parent(),
        FILE_SIGNATURE = "SGF-asset",
        INTEGER_BYTE_LENGTH = 4;

    if (method === 'play') {
      play();
    } else if (method === 'stop') {
      stop();
    } else if (method === 'background') {
      background(options);
    } else {
      img.data('options', $j.extend({
        auto: false,
        width: 10,
        interval: 70,
        background: 'gray'
      }, method || {}, options || {}));
      init();
    }

    function background(color) {
      wrap.css('background', color);
    }

    function init() {
      wrap.css('background', img.data('options').background);
      var ba = new BinFileReader(img.attr('src')),
          fileSize = ba.getFileSize();
      if(fileSize == null || fileSize == 0) return;

      var signature = ba.readString(FILE_SIGNATURE.length, fileSize - FILE_SIGNATURE.length);
      if(signature != FILE_SIGNATURE);
      ba.movePointer(-INTEGER_BYTE_LENGTH - FILE_SIGNATURE.length);

      var amfLen = ba.readInt();

      ba.movePointer(-INTEGER_BYTE_LENGTH - amfLen);
      ba.movePointer(INTEGER_BYTE_LENGTH); // ignore canvas w,h, so jump 2 shorts
      var regPointX = ba.readShort(),
          regPointY = ba.readShort();
      img.data('assetFrameNum', ba.readShort());

      var info = [],
          height = 0,
          width = 0,
          yScroll = 0,
          maxAssetHeight = 0,
          maxWrapperHeight = 100,
          maxWrapperWidth = 50;
      for(i = 0; i < img.data('assetFrameNum'); i++) {
        if(i > 0) yScroll += info[info.length - 1];
        info.push(
          regPointX - ba.readShort(), regPointY - ba.readShort(),
          yScroll, ba.readShort(), ba.readShort()
        );

        if(info[info.length - 1] > maxAssetHeight) maxAssetHeight = info[info.length - 1];
        height = info[info.length - 1] - Math.min(info[info.length - 4], 0);
        if (height > maxWrapperHeight) maxWrapperHeight = height;
        width = info[info.length - 2] - Math.min(info[info.length - 5], 0);
        if (width > maxWrapperWidth) maxWrapperWidth = width;
      }

      obj.css({
        width: img.width() + 'px',
        height: maxAssetHeight +'px'
      });

      wrap.css({
        width: maxWrapperWidth + 'px',
        height: maxWrapperHeight + 'px'
      });

      img.attr('width', 0).attr('height', 0).data('info', info).data('maxAssetHeight', maxAssetHeight).data('currentFrame', 0);
      draw();
    }

    function draw() {
      var info = img.data('info');
      img.data('currentFrame', img.data('currentFrame') + 1);
      if(img.data('currentFrame') > img.data('assetFrameNum')) img.data('currentFrame', 0);
      pos = img.data('currentFrame') * 5;
      xOffset  = -info[pos], yOffset = -info[pos+1],  y = -info[pos+2], w = info[pos+3], h= info[pos+4]
      if (!isNaN(y) && !isNaN(w) && !isNaN(h)) {
        obj.css({
          backgroundPosition: '0px ' + y + 'px',
          width: w + 'px',
          height: h + 'px',
          marginLeft: Math.max(xOffset, 0) + 'px',
          marginTop: Math.max(yOffset, 0) + 'px'
        });
      }
    }

    function play() {
      stop();
      img.data('timer', setInterval(draw, img.data('options').interval));
    }

    function stop() {
      if (img.data('timer')) {
        clearInterval(img.data('timer'));
        img.data('timer', null).data('currentFrame', 0);
      }
    }
  });
};

  function awardLevelRebindClick(){
    $j('.awardLevel').click(
      function(){
        $j('.awardLevel').removeClass('selectedGroup');
        $j('.awardLevel').css('background-color','white');
        $j(this).addClass('selectedGroup');
        $j(this).css('background-color', 'yellow');
      }
    );
  }

