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

(nutils:eval-always
  (defgeneric optional-arg-form (input &key gensym-name))
  (defmethod optional-arg-form ((input (eql nil)) &key (gensym-name "G"))
    `(,(gensym gensym-name) t))
  (defmethod optional-arg-form ((input symbol) &key (gensym-name "G"))
    `(,(gensym gensym-name) (eql ,input)))
  (defmethod optional-arg-form ((input list) &key (gensym-name "G"))
    (declare (ignore gensym-name))
    input))

(defmacro define-key-down-event ((key &optional state &rest keys) &body body)
  `(defmethod handle-key-down-event
       (,(optional-arg-form key :gensym-name "KEY-")
        ,(optional-arg-form state :gensym-name "STATE-") &key ,@keys)
     ,@body))

(define-key-down-event (:sdl-key-escape)
  "Leave the game!"
  (sdl:push-quit-event))
