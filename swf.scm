(module flash.display ()
	(external-class Sprite (addChild soundTransform useHandCursor soundTransform stopDrag dropTarget hitArea graphics useHandCursor startDrag hitArea buttonMode buttonMode)))
(module flash.text ()
	(external-class TextField (replaceText pasteRichText maxScrollH numLines scrollH caretIndex maxScrollV getImageReference scrollV border text background getCharBoundaries borderColor scrollH getFirstCharInParagraph type replaceSelectedText getRawText alwaysShowSelection sharpness textColor defaultTextFormat condenseWhite autoSize scrollV border styleSheet background embedFonts displayAsPassword antiAliasType multiline selectionEndIndex styleSheet mouseWheelEnabled selectedText thickness getLineIndexAtPoint appendText selectionBeginIndex textColor text bottomScrollV htmlText alwaysShowSelection sharpness selectable getLineIndexOfChar restrict gridFitType setSelection getTextFormat setTextFormat type borderColor condenseWhite textWidth getTextRuns getLineOffset wordWrap useRichTextClipboard autoSize defaultTextFormat multiline useRichTextClipboard backgroundColor embedFonts selectable textHeight getXMLText displayAsPassword getLineText maxChars mouseWheelEnabled restrict gridFitType getParagraphLength antiAliasType backgroundColor getCharIndexAtPoint maxChars length thickness insertXMLText wordWrap htmlText getLineMetrics getLineLength)))

(define-class Main (flash.display.Sprite) ())
(define-method init ([self Main])
  (let [(t (new flash.text.TextField))]
    (. t (appendText "Hello,world!!"))
    (. self (addChild t))))

