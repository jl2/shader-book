;; common.lisp
;;
;; Copyright (c) 2020 Jeremiah LaRocco <jeremiah_larocco@fastmail.com>


;; Permission to use, copy, modify, and/or distribute this software for any
;; purpose with or without fee is hereby granted, provided that the above
;; copyright notice and this permission notice appear in all copies.

;; THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
;; WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
;; MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
;; ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
;; WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
;; ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
;; OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

(in-package :shader-book)

(defclass shader-canvas (newgl:vertex-object)
  ((newgl:vertices :initform #(-1.0f0   1.0f0  0.0f0  -1.0f0   1.0f0
                               -1.0f0  -1.0f0  0.0f0  -1.0f0  -1.0f0
                                1.0f0   1.0f0  0.0f0   1.0f0   1.0f0
                                1.0f0  -1.0f0  0.0f0   1.0f0  -1.0f0))
   (newgl:indices :initform #(0 1 2 1 3 2))
   (newgl:shader-program :initarg :shader-program)
   (start-time :initform (local-time:now)))
  (:documentation "Shaping function examples."))

(defmethod newgl:handle-resize ((object shader-canvas) window width height)
  (declare (ignorable window width height))
  (call-next-method))

(defun to-f (val)
  (coerce val 'single-float))

(defmethod newgl:set-uniforms ((object shader-canvas))
  (call-next-method)
  (with-slots (newgl:shader-program start-time) object
    (let ((t-diff (local-time:timestamp-difference (local-time:now) start-time))
          (cur-pos (glfw:get-cursor-position))
          (win-size (glfw:get-window-size)))

      (newgl:set-uniform newgl:shader-program "u_time" (to-f t-diff))

      (newgl:set-uniform newgl:shader-program "u_resolution"
                         (vec2 (to-f (car win-size))
                               (to-f (cadr win-size))))

      (newgl:set-uniform newgl:shader-program "u_mouse"
                         (vec2 (to-f (car cur-pos))
                               (to-f (cadr cur-pos)))))))

(defmethod newgl:update ((object shader-canvas))
  (newgl:set-uniforms object))

