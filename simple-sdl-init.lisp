(in-package :how)

(let (fire (cell 0))
  (defun draw-fire (cell &key (x 30) (y 30))
    (how.sprite::draw-sprite-sheet-at fire :x x :y y :cell cell))
  (defmethod handle-key-down-event :before ((key t) (state (eql :fire)) &key)
    (or fire (progn (setq fire (how.sprite::load-sprite-sheet (load-image "ani2.bmp") :x 64 :y 64)) fire)))
  (define-key-down-event (:sdl-key-1 :fire)
    (setf cell 0)
    (draw-fire cell))
  (define-key-down-event (:sdl-key-2 :fire)
    (setf cell 1)
    (draw-fire cell))
  (define-key-down-event (:sdl-key-3 :fire)
    (setf cell 2)
    (draw-fire cell))
  (define-key-down-event (:sdl-key-4 :fire)
    (setf cell 3)
    (draw-fire cell))
  (define-key-down-event (:sdl-key-5 :fire)
    (setf cell 4)
    (draw-fire cell))
  (define-key-down-event (:sdl-key-6 :fire)
    (setf cell 5)
    (draw-fire cell))
  (define-key-down-event (:sdl-key-7 :fire)
    (setf cell 6)
    (draw-fire cell))
  (define-key-down-event (:sdl-key-8 :fire)
    (setf cell 7)
    (draw-fire cell))
  (define-key-down-event (:sdl-key-9 :fire)
    (setf cell 8)
    (draw-fire cell))
  (define-key-down-event (:sdl-key-0 :fire)
    (setf cell 9)
    (draw-fire cell))
  (define-key-down-event (:sdl-key-q :fire)
    (setf cell 10)
    (draw-fire cell))
  (define-key-down-event (:sdl-key-w :fire)
    (setf cell 11)
    (draw-fire cell))
  (define-key-down-event (:sdl-key-e :fire)
    (setf cell 12)
    (draw-fire cell))
  (define-key-down-event (:sdl-key-r :fire)
    (setf cell 13)
    (draw-fire cell))
  (define-key-down-event (:sdl-key-t :fire)
    (setf cell 14)
    (draw-fire cell))
  (define-key-down-event (:sdl-key-y :fire)
    (setf cell 15)
    (draw-fire cell))
  (define-key-down-event ((key t) (state t))
    "If we don't handle the key, say something!"
    (values (format t "Key: ~S State: ~S~%" key state))
    (draw-fire cell)))

(defun start-how ()
  (sdl:with-init (sdl:sdl-init-video )
    (sdl:window *game-frame-size-x* *game-frame-size-y*)
    (setf (sdl:frame-rate) 60)
    (sdl:enable-key-repeat nil nil)
    (let ((house (load-image "house_64x64.bmp"))
	  (dude (make-instance 'how.characters::actor
			       :surface (load-image "stickfigure_64x64.bmp")
			       :name "Igoru"))
	  (dude-position-x 0)
	  (dude-position-y 0))
      (sdl:clear-display sdl:*green*)
      (sdl:draw-surface-at-* house 100 100)
      (sdl:draw-surface-at-* (how.characters::surface dude)
                             dude-position-x dude-position-y)
      (handle-key-down-event :sdl-key-1 :fire)
      (how.health::draw-health-at-* (make-instance 'how.health::health :current 14 :maximum 20)
				    (- *game-frame-size-x* (* 5 how.health::*heart-image-side-length*))
				    0)
    (sdl:with-events ()
      (:quit-event ()
		   (sdl:save-image sdl:*default-display* (merge-pathnames #P"last-surface.bmp" +root-directory+))
		   t)
      (:key-repeat-on)
      (:key-down-event (:key key)
		       (sdl:clear-display sdl:*green*)
		       (handle-key-down-event key t)
		       (when (sdl:key= key :sdl-key-up) (setf dude-position-y (- dude-position-y 1)))
		       (when (sdl:key= key :sdl-key-down) (setf dude-position-y (+ dude-position-y 1)))
		       (when (sdl:key= key :sdl-key-left) (setf dude-position-x (- dude-position-x 1)))
		       (when (sdl:key= key :sdl-key-right) (setf dude-position-x (+ dude-position-x 1)))
		       (sdl:draw-surface-at-* house 100 100)
		       (sdl:draw-surface-at-* (how.characters::surface dude)
					      dude-position-x dude-position-y)
		       (handle-key-down-event key :fire)

		       (how.health::draw-health-at-* (make-instance 'how.health::health :current 14 :maximum 20)
						     (- *game-frame-size-x* (* 5 how.health::*heart-image-side-length*))
						     0))

      (:idle ()
	     (sdl:update-display))))))
;;; END
