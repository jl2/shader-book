;; hello-world.lisp
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

(defclass hello-world (newgl:vertex-object)
  ((newgl:vertices :initform #(-1.0f0   1.0f0  0.0f0  -1.0f0   1.0f0
                               -1.0f0  -1.0f0  0.0f0  -1.0f0  -1.0f0
                                1.0f0   1.0f0  0.0f0   1.0f0   1.0f0
                                1.0f0  -1.0f0  0.0f0   1.0f0  -1.0f0))
   (newgl:indices :initform #(0 1 2 1 3 2))
   (newgl:shader-program :initform (newgl:make-shader-program
                                    (shader-file "hello-fragment.glsl")
                                    (shader-file "simple-vertex.glsl")))
   (start-time :initform (local-time:now)))
  (:documentation "Hello world shader."))

(defmethod newgl:handle-resize ((object hello-world) window width height)
  (declare (ignorable window width height))
  (call-next-method))

(defmethod newgl:set-uniforms ((object hello-world))
  (call-next-method)
  (with-slots (newgl:shader-program start-time) object
    (let ((t-diff (local-time:timestamp-difference (local-time:now) start-time))
          (cur-pos (glfw:get-cursor-position))
          (win-size (glfw:get-window-size)))

      (newgl:set-uniform newgl:shader-program
                         "u_time"
                         (coerce t-diff 'single-float))
      (newgl:set-uniform newgl:shader-program
                         "u_resolution"
                         (vec2 (coerce (car win-size) 'single-float)
                               (coerce (cadr win-size) 'single-float)))
      (newgl:set-uniform newgl:shader-program
                         "u_resolution"
                         (vec2 (coerce (car cur-pos) 'single-float)
                               (coerce (cadr cur-pos) 'single-float))))))

(defmethod newgl:update ((object hello-world))
  (newgl:set-uniforms object))

(defun hello (&optional debug)
  (newgl:display (make-instance 'hello-world) :debug debug))
