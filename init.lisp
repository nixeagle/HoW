(in-package :how)

(defvar +root-directory+
  (asdf:system-relative-pathname (asdf:find-system :how) "/")
  "The root of where the asdf source is at.

We use this for locating data and configuration information for HoW. This
may run into some issues in the future but for the near term future this
solves most issues.")

(defvar +image-directory+
  (merge-pathnames #P"images/" +root-directory+))

(defvar *game-frame-size-x* 640
  "X direction for the game's frame.")
(defvar *game-frame-size-y* 480
  "Y direction for the game's frame.")




(defun load-image (name &key (directory +image-directory+))
  "Load image NAME from `+image-directory+'."
  (declare (string name))
  (sdl:load-image (merge-pathnames name directory)))

;;; END
