(defpackage #:how.characters
  (:use :cl))

(in-package :how.characters)

(defclass actor ()
  ((name :initarg :name :type string :reader name
         :documentation "Character name.")
   (surface :initarg :surface :accessor surface
            :documentation "Surface that has the character's current image.")
   (location :initarg :position :accessor location
             :documentation "Location on game surface."))
  (:documentation "Class for characters."))
