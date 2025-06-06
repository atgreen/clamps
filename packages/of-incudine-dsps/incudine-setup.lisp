
;;;; incudine-setup.lisp
;;;;
;;;; Copyright (c) 2018-2024 Orm Finnendahl
;;;; <orm.finnendahl@selma.hfmdk-frankfurt.de>

(in-package #:of-incudine-dsps)

#|
(define-vug input-bus ((channel fixnum))
  (bus (the fixnum
         (+ (the fixnum
              (* current-frame *number-of-input-bus-channels*))
            channel))))

(dsp! cp-input-buses ((first-in-bus channel-number))
  (:defaults 0)
  (foreach-frame
    (dochannels (current-channel *number-of-input-bus-channels*)
      (setf (input-bus (+ current-channel first-in-bus))
            (audio-in (+ current-channel first-in-bus))))))

(dsp! cp-output-buses ((first-out-bus channel-number))
  (:defaults 8)
  (foreach-frame
    (setf (input-bus (+ 0 first-out-bus)) (audio-out current-channel))
    (setf (input-bus (+ 1 first-out-bus)) (audio-out current-channel))))

(dsp! bus-to-out ((numchannels channel-number) (startidx channel-number))
  (foreach-frame
    (dochannels (current-channel numchannels)
      (setf (audio-out current-channel)
            (input-bus (+ current-channel startidx))))))

(dsp! mix-bus-to-out ((startidx channel-number) (numchannels channel-number))
  (:defaults 16 8)
  (foreach-frame
    (dochannels (current-channel numchannels)
      (incf (audio-out current-channel) (input-bus (+ current-channel startidx))))))

(dsp! clear-buses ((startidx channel-number) (numchannels channel-number))
  (:defaults 16 8)
  (foreach-frame
    (dochannels (current-channel numchannels)
      (setf (input-bus (+ current-channel startidx)) +sample-zero+))))

(defvar *aux* (incudine.external:foreign-alloc-sample
               (* 256 *number-of-input-bus-channels*)))

(declaim (inline aux))
(defun aux (n)
  (smp-ref *aux* n))

(declaim (inline set-aux))
(defun set-aux (n value)
  (setf (smp-ref *aux* n) (sample value)))

(defsetf aux set-aux)
|#


#|
(defmacro foreach-input-channel (&body body)
  (with-gensyms (i)
    `(dochannels (,i *number-of-input-bus-channels*)
       (let ((current-channel ,i))
         (declare (type channel-number current-channel)
                  (ignorable current-channel))
         ,@body))))

(declaim (inline bus))
(defun bus (num &optional (frame 0))
  "Return the value of the bus number NUM. Setfable."
  (declare (type bus-number num)
           (type non-negative-fixnum frame))
  (smp-ref incudine::*bus-pointer*
           (the non-negative-fixnum
                (+ (the non-negative-fixnum
                        (* frame *number-of-bus-channels*))
                   num))))

(declaim (inline set-bus))
(defun set-bus (num frame value)
  (declare (type bus-number num)
           (type non-negative-fixnum frame))
  (setf (smp-ref *bus-pointer*
                 (the non-negative-fixnum
                                (+ (the non-negative-fixnum
                                        (* frame *number-of-bus-channels*))
                                   num)))
        (sample value)))

(defsetf bus (num &optional (frame 0)) (value)
  `(set-bus ,num ,frame ,value))
|#

;;; (setup-io)
;;; (dump (node 0))
;;; (block-size)
;;; (set-rt-block-size 256)
;;; (rt-start)

#|
(define-vug input-bus ((channel fixnum))
  (bus (the fixnum
         (+ (the fixnum
              (* current-frame *number-of-input-bus-channels*))
            channel))))

(dsp! cp-input-buses ()
  (foreach-frame
    (dochannels (current-channel *number-of-input-bus-channels*)
      (setf (input-bus current-channel)
            (audio-in current-channel)))))

(dsp! out-test ()
  (foreach-frame
    (dochannels (current-channel *number-of-input-bus-channels*)
      (cout (input-bus current-channel)))))
|#
