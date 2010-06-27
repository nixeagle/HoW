(in-package :how)

(defvar +root-directory+
  (asdf:system-relative-pathname (asdf:find-system :nisp.i) "/")
  "The root of where the asdf source is at.

We use this for locating data and configuration information for
nisp.i. This may run nto some issues in the future but for the near term
future this solves most issues.")

(defun start-sdl ()
  (sdl:with-init (sdl:sdl-init-video )
    (sdl:window 320 240)
    (sdl:draw-line (sdl:point) (sdl:point :x 100 :y 100))
    (sdl:draw-rectangle (sdl:rectangle :w 10 :h 10))
    (let ((counter 0)
	  (horizontal 0)
	  (vertical 0))
      (setf (sdl:frame-rate) 200)
      (sdl:with-events ()
	(:quit-event () t)
	(:key-down-event ()
			 (sdl:draw-line (sdl:point :x 200 :y 200)
					(sdl:point :x 0 :y 33))
			 (incf counter)
			 (when (= counter 2) (sdl:push-quit-event)))
        (:mouse-motion-event (:x x :y y)
                             (sdl:clear-display sdl:*black*)
                             (sdl:draw-box-* x y 50 50))
	(:idle ()
	       (sdl:draw-pixel (sdl:point :x (incf horizontal) :y vertical))
	       (when (= horizontal 320)
		 (incf vertical)
		 (setq horizontal 0))
	       (sdl:update-display))))))

;;; END
