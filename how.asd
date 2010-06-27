(asdf:defsystem :how
  :depends-on (:lispbuilder-sdl)
  :components
  ((:file "packages")
   (:file "init" :depends-on ("packages"))
   (:module #:src
            :depends-on ("init")
            :components
            ((:file "image")
             (:file "health" :depends-on ("image"))
             (:file "actor" :depends-on ("health"))))
   (:file "simple-sdl-init" :depends-on (#:src))))
