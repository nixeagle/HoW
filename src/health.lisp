(in-package :how.health)

(defvar +unit-full-heart+ 1
  "Treat 1 damage unit as the loss of 1 heart.")
(defvar +unit-half-heart+ 2
  "Treat 1 damage unit as the loss of half a heart.")
(defvar +unit-quarter-heart+ 4
  "Treat 1 damage unit as the loss of quarter of a heart.")

(defvar *heart-image-side-length* 32
  "Size of a heart image side in pixels.")

;;; Need to default current to maximum if it is not supplied at creation
;;; time.
(defclass health ()
  ((maximum :type (integer 0 #.most-positive-fixnum)
            :initarg :maximum
            :accessor health-maximum)
   (current :type (integer 0 #.most-positive-fixnum)
            :initarg :current
            :accessor health-current)
   (units :type (integer 0 12)
          :initarg :units
          :accessor health-units
          :initform +unit-quarter-heart+))
  (:documentation "Information on actor health."))

(defun %heart-count (maximum current units)
  "Compute current heart count and max count.

Max count is returned as the second value from this function."
  (declare ((integer 0 #.most-positive-fixnum) maximum current units))
  (values (ceiling (/ current units))
          (ceiling (/ maximum units))))

(defmethod heart-count ((object health))
  "Compute health in terms of hearts."
  (with-slots (maximum current units) object
    (%heart-count maximum current units)))

(defmethod draw-health-at* ((object health)
                            &key (heart-size *heart-image-side-length*)
                            (x 0) (y 0) (surface sdl:*default-surface*))
  "Draw a surface with health."
  (multiple-value-bind (current max) (heart-count object)
    (let ((surf (sdl:create-surface (* heart-size max) heart-size)))
      (loop for i from 1 to (heart-count object)
         do (sdl:draw-surface-at-* (how::load-image "full_heart_32x32.bmp")
                                   (* heart-size (1- i)) 0 :surface surf))
      (sdl:draw-surface-at-* surf x y :surface surface)
      surf)))

(defun draw-full-heart-at-* (x &key (y 0)
                             (surface sdl:*default-surface*))
  (how.sprite::draw-sprite-sheet-at-*
   (how.sprite::load-sprite-sheet (how::load-image "hearts_32x32.bmp") :x 32 :y 32)
   x y :surface surface :cell 4))

(defmethod draw-health-at-* ((object health) x y
                             &key (heart-size *heart-image-side-length*)
                             (surface sdl:*default-surface*))
  "Draw a surface with health."
  (multiple-value-bind (current max) (heart-count object)
    (let ((surf (sdl:create-surface (* heart-size max) heart-size)))
      (loop for i from 1 to (heart-count object)
         do (draw-full-heart-at-* (* heart-size (1- i)) :surface surf))
      (sdl:draw-surface-at-* surf x y :surface surface)
      surf)))

;;; END
