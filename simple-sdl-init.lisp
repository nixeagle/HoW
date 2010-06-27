(in-package :how)

(defgeneric handle-key-down-event
    (key state &key &allow-other-keys)
  (:documentation "Handle key down presses."))

(defmethod handle-key-down-event :around
    ((key t) (state t) &key (surface sdl:*default-surface*)
     (display sdl:*default-display*))
  "Bind display and surface before calling onwards."
  (let ((sdl:*default-display* display)
        (sdl:*default-surface* surface))
    (call-next-method)))

(defmethod handle-key-down-event ((key (eql :sdl-key-escape)) (state t) &key)
  "Leave the game!"
  (sdl:push-quit-event))

(defmethod handle-key-down-event (key state &key)
  "If we don't handle the key, say something!"
  (format t "No key-down event! Key: ~S State: ~S~%" key state))

(defun start-how ()
  (sdl:with-init (sdl:sdl-init-video )
    (sdl:window *game-frame-size-x* *game-frame-size-y*)
    (setf (sdl:frame-rate) 200)
    (sdl:enable-key-repeat nil nil)
    (let ((house (load-image "house_64x64.bmp"))
	  (dude (make-instance 'how.characters::actor
			       :surface (load-image "stickfigure_64x64.bmp")
			       :name "Igoru"))
	  (dude-position-x 0)
	  (dude-position-y 0)
	  (fire (how.sprite::load-sprite-sheet (load-image "ani2.bmp") :x 64 :y 64))
	  (fire-cell 0))
      (sdl:with-events ()
        (:quit-event ()
                     (sdl:save-image sdl:*default-display* (merge-pathnames #P"last-surface.bmp" +root-directory+))
                     t)
	(:key-repeat-on)
	(:key-down-event (:key key)
			 (when (sdl:key= key :sdl-key-escape) (sdl:push-quit-event))
			 (when (sdl:key= key :sdl-key-up) (setf dude-position-y (- dude-position-y 1)))
			 (when (sdl:key= key :sdl-key-down) (setf dude-position-y (+ dude-position-y 1)))
			 (when (sdl:key= key :sdl-key-left) (setf dude-position-x (- dude-position-x 1)))
			 (when (sdl:key= key :sdl-key-right) (setf dude-position-x (+ dude-position-x 1)))
			 (when (sdl:key= key :sdl-key-1) (setf fire-cell 0))
			 (when (sdl:key= key :sdl-key-2) (setf fire-cell 1))
			 (when (sdl:key= key :sdl-key-3) (setf fire-cell 2))
			 (when (sdl:key= key :sdl-key-4) (setf fire-cell 3))
			 (when (sdl:key= key :sdl-key-5) (setf fire-cell 4))
			 (when (sdl:key= key :sdl-key-6) (setf fire-cell 5))
			 (when (sdl:key= key :sdl-key-7) (setf fire-cell 6))
			 (when (sdl:key= key :sdl-key-8) (setf fire-cell 7))
			 (when (sdl:key= key :sdl-key-9) (setf fire-cell 8))
			 (when (sdl:key= key :sdl-key-0) (setf fire-cell 9))
			 (when (sdl:key= key :sdl-key-q) (setf fire-cell 10))
			 (when (sdl:key= key :sdl-key-w) (setf fire-cell 11))
			 (when (sdl:key= key :sdl-key-e) (setf fire-cell 12))
			 (when (sdl:key= key :sdl-key-r) (setf fire-cell 13))
			 (when (sdl:key= key :sdl-key-t) (setf fire-cell 14))
			 (when (sdl:key= key :sdl-key-y) (setf fire-cell 15)))
	(:idle ()
	       (sdl:clear-display sdl:*green*)
	       (sdl:draw-surface-at-* house 100 100)
	       (sdl:draw-surface-at-* (how.characters::surface dude)
				      dude-position-x dude-position-y)
	       (how.sprite::draw-sprite-sheet-at fire :x 30 :y 30 :cell fire-cell)
	       (how.health::draw-health-at* (make-instance 'how.health::health :current 14 :maximum 20)
					    :y 0 :x (- *game-frame-size-x* (* 10 how.health::*heart-image-side-length*)))
	       (sdl:update-display))))))
;;; END
