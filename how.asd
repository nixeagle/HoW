(asdf:defsystem :how
  :depends-on (:lispbuilder-sdl)
  :components
  ((:file "packages")
   (:file "init" :depends-on ("packages"))
   (:module #:src
            :depends-on ("init")
            :components
            ((:file "health")
             (:file "actor" :depends-on ("health"))
	     (:file "image")))
   (:file "simple-sdl-init" :depends-on (#:src))))
