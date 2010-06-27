(asdf:defsystem :how
  :depends-on (:lispbuilder-sdl)
  :components
  ((:module #:src
            :components
            ((:file "actor")))
   (:file "simple-sdl-init")))
