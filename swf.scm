(define-class Hello (flash.display.Sprite) ())
(define-method init ([self Hello])
  (let [(t (new flash.text.TextField))]
	    (invoke t appendText "Hello,world!!")
	    (invoke this addChild t)))

