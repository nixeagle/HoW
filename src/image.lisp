(in-package :how)

(defun load-image (name &key (directory +image-directory+) (color-key (sdl:color :r 255 :g 0 :b 255)))
  "Load image NAME from `+image-directory+'."
  (declare (string name))
  (sdl:load-image (merge-pathnames name directory) :color-key color-key))