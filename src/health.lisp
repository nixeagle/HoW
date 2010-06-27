(in-package :how.health)

(defvar +unit-full-heart+ 1
  "Treat 1 damage unit as the loss of 1 heart.")
(defvar +unit-half-heart+ 2
  "Treat 1 damage unit as the loss of half a heart.")
(defvar +unit-quarter-heart+ 4
  "Treat 1 damage unit as the loss of quarter of a heart.")
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
          :initform +unit-half-heart+))
  (:documentation "Information on actor health."))

