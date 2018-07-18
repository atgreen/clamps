;;; package.lisp
;;; 
;;; Package for the export to and import from svg files. The code is
;;; primarily aimed at using inkscape as some sort of piano-roll
;;; editor for music related data, especially in conjunction with
;;; common music (version 2) using the cm-svg glue code to integrate
;;; it with cm. It only imports line or circle objects in specified
;;; layers. The export code is more general and implements the major
;;; svg elements.
;;;
;;; Both, import and export code should be easily extensible to be
;;; adapted to other purposes.
;;;
;;; **********************************************************************
;;; Copyright (C) 2012-2018 Orm Finnendahl
;;;
;;; This program is free software; you can redistribute it and/or
;;; modify it under the terms of the Lisp Lesser Gnu Public License.
;;; See http://www.cliki.net/LLGPL for the text of this agreement.
;;; **********************************************************************

(defpackage #:svg-import-export
  (:use #:cl #:cl-user)
  (:nicknames #:svg-ie)
  (:export 
   #:NEW-ID
   #:EXPORT-SVG-FILE
   #:SVG-FILE
   #:SVG-LAYER
   #:SVG-GROUP
   #:SVG-POINT
   #:SVG-RECT
   #:SVG-LINE
   #:SVG-TEXT
   #:SVG-CLONE
   #:PRINT-TO-STREAM
   #:MAKE-PIANO-ROLL
   #:MAKE-STAFF-SYSTEM
   #:LIST->SVG-POINTS
   #:PRINT-HEAD-TO-STREAM
   #:PRINT-TAIL-TO-STREAM
   #:FORMAT-WITH-SLOTS
   #:SVG-ZEITACHSE
   #:PD-COLOR->SVG-COLOR
   #:POINTS->SVG
   #:LINES->SVG
   #:SVG->POINTS
   #:SVG->LINES
   #:XSCALE-POINTS
   #:XSCALE-LINES
   #:REGENERATE-POINTS
   #:RENEW-SVG
   #:GET-TICK-LINES
   #:SVG-ZEITACHSE
   #:SVG-PIANO-ROLL
   #:SVG-STAFF-SYSTEM
   ;; #:POINTS->PD-TEXT
   ;; #:POINTS->MIDI
   ;; #:SVG->BC-LIST
   ;; #:BC-LIST->KEYNUM-LIST
   ;; #:BC-LIST->SVG
   ;; #:SVG->PD-TEXT
   ))
