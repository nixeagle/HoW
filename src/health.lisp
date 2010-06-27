(in-package :how.health)


;;; Need to default current to maximum if it is not supplied at creation
;;; time.
(defclass health ()
  ((maximum :type (integer 0 #.most-positive-fixnum)
            :initarg :maximum
            :accessor health-maximum)
   (current :type (integer 0 #.most-positive-fixnum)
            :initarg :current
            :accessor health-current))
  (:documentation "Information on actor health."))

