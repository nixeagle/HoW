(in-package :how)

(defun start-hearts ()
  (sdl:with-init (sdl:sdl-init-video)
    (sdl:window 50 50)
    (setf (sdl:frame-rate) 200)
    (sdl:enable-key-repeat nil nil)
    (let ((hearts (how.sprite::load-sprite-sheet (load-image "hearts_32x32.bmp") :x 32 :y 32))
	  (hearts-cell 0))
      (sdl:clear-display sdl:*black*)
      (how.sprite::draw-sprite-sheet-at hearts :x 10 :y 10 :cell hearts-cell)

      (sdl:with-events ()
        (:quit-event () t)
	(:key-repeat-on)
	(:key-down-event (:key key)
                         (when (sdl:key= key :sdl-key-escape) (sdl:push-quit-event))
			 (when (sdl:key= key :sdl-key-1) (setf hearts-cell 0))
			 (when (sdl:key= key :sdl-key-2) (setf hearts-cell 1))
			 (when (sdl:key= key :sdl-key-3) (setf hearts-cell 2))
			 (when (sdl:key= key :sdl-key-4) (setf hearts-cell 3))
			 (when (sdl:key= key :sdl-key-5) (setf hearts-cell 4)))
	(:idle ()
	       (sdl:clear-display sdl:*black*)
	       (how.sprite::draw-sprite-sheet-at hearts :x 10 :y 10 :cell hearts-cell)
	       (sdl:update-display))))))