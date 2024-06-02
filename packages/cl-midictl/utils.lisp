;;; 
;;; utils.lisp
;;;
;;; **********************************************************************
;;; Copyright (c) 2023 Orm Finnendahl <orm.finnendahl@selma.hfmdk-frankfurt.de>
;;;
;;; Revision history: See git repository.
;;;
;;; This program is free software; you can redistribute it and/or
;;; modify it under the terms of the Gnu Public License, version 2 or
;;; later. See https://www.gnu.org/licenses/gpl-2.0.html for the text
;;; of this agreement.
;;; 
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;;; GNU General Public License for more details.
;;;
;;; **********************************************************************

(in-package :cl-midictl)

(defun ccin (ccnum &optional (channel *global-midi-channel*))
  (get-val (aref (aref *midi-cc-state* channel) ccnum)))

(defsetf ccin (ccnum &optional (channel *global-midi-channel*)) (value)
  `(progn
     (set-val (aref (aref *midi-cc-state* ,channel) ,ccnum) ,value)
     ,value))

(defun get-ref (controller ref-idx)
  "return the ref-object of a midi-controller given the idx according to
cc-nums."
  (with-slots (cc-nums cc-state) controller
    (aref cc-state (aref cc-nums ref-idx))))

(defmacro toggle-slot (slot)
  `(set-val ,slot
            (if (zerop (get-val ,slot))
                127 0)))

(defun buchla-scale (curr old target &key (max 127))
  "scale the target fader by interpolating using the curr and old values
of the source fader."
  (float
   (cond
     ((= old target) curr)
     ((= curr old) target)
     ((< curr old)
      (* (- 1 (/ (- old curr) old)) target))
     (t (- max (* (- 1 (/ (- curr old) (- max old))) (- max target)))))
   1.0))

(defmacro with-gui-update-off ((instance) &body body)
  `(progn
     (setf (gui-update-off ,instance) t)
     (unwind-protect ,@body
       (setf (gui-update-off ,instance) nil))))
