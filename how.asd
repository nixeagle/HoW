(asdf:defsystem :how
  :depends-on (:lispbuilder-sdl :nutils :cl-opengl :cl-glu)
  :components
  ((:file "packages")
   (:file "init" :depends-on ("packages"))
   (:module #:src
            :depends-on ("init")
            :components
            ((:file "key-events")
	     (:file "image")
	     (:file "sprite" :depends-on ("image"))
             (:file "health" :depends-on ("sprite"))
             (:file "actor" :depends-on ("health"))))
   (:file "simple-sdl-init" :depends-on (#:src))
   (:file "hearts-sdl-init" :depends-on (#:src))))
