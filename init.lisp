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


(defun load-image (name &key (directory +image-directory+) (color-key (sdl:color :r 255 :g 0 :b 255)))
  "Load image NAME from `+image-directory+'."
  (declare (string name))
  (sdl:load-image (merge-pathnames name directory) :color-key color-key))

(defun generate-cells (x y width height)
  "Generate a cell list for use with sprite sheets"
  (loop for cell-y from 0 to (- width y) by y
                            append (loop for cell-x from 0 to (- height x) by x
                                         collect (list cell-x cell-y x y))))
(defun load-sprite-sheet (sprite-sheet x y)
  "Set the cells for a sprite sheet at `sdl:cells' using `generate-cells'"
  (setf (sdl:cells sprite-sheet) (generate-cells x y (sdl:width sprite-sheet) (sdl:height sprite-sheet)))
  (values sprite-sheet))

(defun draw-sprite-sheet-at (sprite-sheet x y cell)
  "draw surface for a sprite sheet"
  (sdl:draw-surface-at sprite-sheet (apply #'vector (list x y)) :cell cell))

;;; END
