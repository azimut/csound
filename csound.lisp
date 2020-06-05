;; L I S P   C F F I   I N T E R F A C E   F O R   C S O U N D . H
;;
;; Copyright (C) 2016 Michael Gogins
;;
;; This file belongs to Csound.
;;
;; This software is free software; you can redistribute it and/or
;; modify it under the terms of the GNU Lesser General Public
;; License as published by the Free Software Foundation; either
;; version 2.1 of the License, or (at your option) any later version.
;;
;; This software is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; Lesser General Public License for more details.
;;
;; You should have received a copy of the GNU Lesser General Public
;; License along with this software; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
;;
;; This file is handwritten and should be maintained by keeping it up to date
;; with regard to include/csound.h. This file is not intended to be complete
;; and essentially defines a Lisp interface to a subset of the most useful
;; functions in csound.h. At the present time, only pointers and
;; other primitive types are used in this interface.
;;
;; Please note, in particular, that all strings passed to Csound are foreign
;; strings, created for example with (setq foreign-string
;; (cffi:foreign-string-alloc lisp-string))

(uiop:define-package #:csound
  (:use #:common-lisp #:cffi)
  (:shadow #:compile)
  (:export
   #:cleanup
   #:compile-args
   #:compile-csd
   #:compile-csd-text
   #:compile-orc
   #:create
   #:create-thread
   #:destroy
   #:eval-code
   #:get-api-version
   #:get-current-time-samples
   #:get-host-data
   #:get-input-buffer
   #:get-input-buffer-size
   #:get-kr
   #:get-ksmps
   #:get-nchnls
   #:get-nchnls-input
   #:get-output-buffer
   #:get-output-buffer-size
   #:get-output-name
   #:get-size-of-myflt
   #:get-spin
   #:get-spout
   #:get-spout-sample
   #:get-sr
   #:get-version
   #:get0d-bfs
   #:initialize
   #:perform
   #:perform-buffer
   #:perform-ksmps
   #:read-score
   #:reset
   #:set-host-data
   #:set-input
   #:set-midi-file-input
   #:set-midi-file-output
   #:set-midi-input
   #:set-option
   #:set-output
   #:set-rt-audio-module
   #:start
   #:stop
   #:set-control-channel))

(cffi:define-foreign-library libcsound64
  (:darwin "libcsnd6.dylib")
  (:unix (:or "libcsound64.so" "libcsound64.so.6.0"))
  (:windows "csound64.dll")
  (t (:default "libcsound64")))
(cffi:use-foreign-library libcsound64)
(in-package :csound)

;; You can paste below here new definitions including those created
;; e.g. by SWIG. Be sure to TEST any changes you make to this file!

;; (cffi:defcfun ("csoundTableLength" csoundTableLength) :int
;; (csound :pointer)
;; (table :int))

;; (cffi:defcfun ("csoundTableGet" csoundTableGet) :double
;; (csound :pointer)
;; (table :int)
;; (index :int))

;; (cffi:defcfun ("csoundTableSet" csoundTableSet) :void
;; (csound :pointer)
;; (table :int)
;; (index :int)
;; (valu :double))

;; (cffi:defcfun ("csoundRunUtility" csoundRunUtility) :int
;; (csound :pointer)
;; (nayme :pointer)
;; (argc :int)
;; (argv :pointer))

;; (cffi:defcfun ("csoundMessage" csoundMessage) :void
;; (csound :pointer)
;; (control :pointer)
;; &rest)

;; (defun csoundMessage (csound control &rest values)
;; (cffi:foreign-funcall "csoundMessage" csound :pointer control :pointer &rest values :void))

(cffi:defcfun ("csoundSetControlChannel" set-control-channel) :void
  (csound :pointer)
  (name :string)
  (value :double))

(cffi:defcfun ("csoundInitialize" initialize) :int
  (flags :int))

(cffi:defcfun ("csoundCreate" create) :pointer
  (host-data :pointer))

(cffi:defcfun ("csoundDestroy" destroy) :void
  (csound :pointer))

(cffi:defcfun ("csoundGetVersion" get-version) :int)

(cffi:defcfun ("csoundGetAPIVersion" get-api-version) :int)

(cffi:defcfun ("csoundCompileOrc" compile-orc) :int
  (csound :pointer)
  (orc :string))

(cffi:defcfun ("csoundEvalCode" eval-code) :double
  (csound :pointer)
  (orc :pointer))

(cffi:defcfun ("csoundCompileArgs" compile-args) :int
  (csound :pointer)
  (argc :int)
  (argv :pointer))

(cffi:defcfun ("csoundStart" start) :int
  (csound :pointer))

(cffi:defcfun ("csoundCompile" compile) :int
  (csound :pointer)
  (argc :int)
  (argv :pointer))

(cffi:defcfun ("csoundCompileCsd" compile-csd) :int
  (csound :pointer)
  (csd-pathname :string))

(cffi:defcfun ("csoundCompileCsdText" compile-csd-text) :int
  (csound :pointer)
  (csd-text :pointer))

(cffi:defcfun ("csoundPerform" perform) :int
  (csound :pointer))

(cffi:defcfun ("csoundPerformKsmps" perform-ksmps) :int
  (csound :pointer))

(cffi:defcfun ("csoundPerformBuffer" perform-buffer) :int
  (csound :pointer))

(cffi:defcfun ("csoundStop" stop) :void
  (csound :pointer))

(cffi:defcfun ("csoundCleanup" cleanup) :int
  (csound :pointer))

(cffi:defcfun ("csoundReset" reset) :void
  (csound :pointer))

(cffi:defcfun ("csoundGetSr" get-sr) :double
  (csound :pointer))

(cffi:defcfun ("csoundGetKr" get-kr) :double
  (csound :pointer))

(cffi:defcfun ("csoundGetKsmps" get-ksmps) :int32
  (csound :pointer))

(cffi:defcfun ("csoundGetNchnls" get-nchnls) :int32
  (csound :pointer))

(cffi:defcfun ("csoundGetNchnlsInput" get-nchnls-input) :int32
  (csound :pointer))

(cffi:defcfun ("csoundGet0dBFS" get0d-bfs) :double
  (csound :pointer))

(cffi:defcfun ("csoundGetCurrentTimeSamples" get-current-time-samples) :int64
  (csound :pointer))

(cffi:defcfun ("csoundGetSizeOfMYFLT" get-size-of-myflt) :int)

(cffi:defcfun ("csoundGetHostData" get-host-data) :pointer
  (csound :pointer))

(cffi:defcfun ("csoundSetHostData" set-host-data) :void
  (csound :pointer)
  (hostData :pointer))

(cffi:defcfun ("csoundSetOption" set-option) :int
  (csound :pointer)
  (option :string))

(cffi:defcfun ("csoundGetOutputName" get-output-name) :pointer
  (csound :pointer))

(cffi:defcfun ("csoundSetOutput" set-output) :void
  (csound :pointer)
  (nayme :pointer)
  (tipe :pointer)
  (format :pointer))

(cffi:defcfun ("csoundSetInput" set-input) :void
  (csound :pointer)
  (nayme :pointer))

(cffi:defcfun ("csoundSetMIDIInput" set-midi-input) :void
  (csound :pointer)
  (nayme :pointer))

(cffi:defcfun ("csoundSetMIDIFileInput" set-midi-file-input) :void
  (csound :pointer)
  (nayme :pointer))

(cffi:defcfun ("csoundSetMIDIOutput" set-midi-output) :void
  (csound :pointer)
  (nayme :pointer))

(cffi:defcfun ("csoundSetMIDIFileOutput" set-midi-file-output) :void
  (csound :pointer)
  (nayme :pointer))

(cffi:defcfun ("csoundSetRTAudioModule" set-rt-audio-module) :void
  (csound :pointer)
  (moduule :pointer))

(cffi:defcfun ("csoundGetInputBufferSize" get-input-buffer-size) :long
  (csound :pointer))

(cffi:defcfun ("csoundGetOutputBufferSize" get-output-buffer-size) :long
  (csound :pointer))

 (cffi:defcfun ("csoundGetInputBuffer" csoundGetInputBuffer) :pointer
   (csound :pointer))

(cffi:defcfun ("csoundGetOutputBuffer" get-output-buffer) :pointer
  (csound :pointer))

(cffi:defcfun ("csoundGetSpin" get-spin) :pointer
  (csound :pointer))

;; (cffi:defcfun ("csoundAddSpinSample" csoundAddSpinSample) :void
;; (csound :pointer)
;; (frayme :int)
;; (channel :int)
;; (sample :float))

(cffi:defcfun ("csoundGetSpout" get-spout) :pointer
  (csound :pointer))

(cffi:defcfun ("csoundGetSpoutSample" get-spout-sample) :double
  (csound :pointer)
  (frame :int)
  (channel :int))

(cffi:defcfun ("csoundReadScore" read-score) :int
  (csound :pointer)
  (score :string))

(cffi:defcfun ("csoundCreateThread" create-thread) :void
  (threadroutine :pointer)
  (userdata :pointer))

;; (cffi:defcfun ("csoundGetScoreTime" csoundGetScoreTime) :double
;; (csound :pointer))

;; (cffi:defcfun ("csoundIsScorePending" csoundIsScorePending) :int
;; (csound :pointer))

;; (cffi:defcfun ("csoundSetScorePending" csoundSetScorePending) :void
;; (csound :pointer)
;; (pending :int))

;; (cffi:defcfun ("csoundGetScoreOffsetSeconds" csoundGetScoreOffsetSeconds) :double
;; (csound :pointer))

;; (cffi:defcfun ("csoundSetScoreOffsetSeconds" csoundSetScoreOffsetSeconds) :void
;; (csound :pointer)
;; (time :double))

;; (cffi:defcfun ("csoundRewindScore" csoundRewindScore) :void
;; (csound :pointer))

;; (cffi:defcfun ("csoundGetMessageLevel" csoundGetMessageLevel) :int
;; (csound :pointer))

;; (cffi:defcfun ("csoundSetMessageLevel" csoundSetMessageLevel) :void
;; (csound :pointer)
;; (messageLevel :int))

;; (cffi:defcfun ("csoundCreateMessageBuffer" csoundCreateMessageBuffer) :void
;; (csound :pointer)
;; (toStdOut :int))

;; (cffi:defcfun ("csoundGetFirstMessage" csoundGetFirstMessage) :pointer
;; (csound :pointer))

;; (cffi:defcfun ("csoundGetFirstMessageAttr" csoundGetFirstMessageAttr) :int
;; (csound :pointer))

;; (cffi:defcfun ("csoundPopFirstMessage" csoundPopFirstMessage) :void
;; (csound :pointer))

;; (cffi:defcfun ("csoundGetMessageCnt" csoundGetMessageCnt) :int
;; (csound :pointer))

;; (cffi:defcfun ("csoundDestroyMessageBuffer" csoundDestroyMessageBuffer) :void
;; (csound :pointer))

;; (cffi:defcfun ("csoundGetControlChannel" csoundGetControlChannel) :double
;; (csound :pointer)
;; (nayme :pointer)
;; (err :pointer))

;; (cffi:defcfun ("csoundGetAudioChannel" csoundGetAudioChannel) :void
;; (csound :pointer)
;; (name :pointer)
;; (samples :pointer))

;; (cffi:defcfun ("csoundSetAudioChannel" csoundSetAudioChannel) :void
;; (csound :pointer)
;; (name :pointer)
;; (samples :pointer))

;; (cffi:defcfun ("csoundGetStringChannel" csoundGetStringChannel) :void
;; (csound :pointer)
;; (name :pointer)
;; (string :pointer))

;; (cffi:defcfun ("csoundSetStringChannel" csoundSetStringChannel) :void
;; (csound :pointer)
;; (name :pointer)
;; (string :pointer))

;; (cffi:defcfun ("csoundScoreEvent" csoundScoreEvent) :int
;; (csound :pointer)
;; (tipe :char)
;; (pFields :pointer)
;; (numFields :long))

;; (cffi:defcfun ("csoundScoreEventAbsolute" csoundScoreEventAbsolute) :int
;; (csound :pointer)
;; (type :char)
;; (pfields :pointer)
;; (numFields :long)
;; (time_ofs :double))

;; (cffi:defcfun ("csoundInputMessage" csoundInputMessage) :void
;; (csound :pointer)
;; (message :pointer))

;; (cffi:defcfun ("csoundIsNamedGEN" csoundIsNamedGEN) :int
;; (csound :pointer)
;; (num :int))

;; (cffi:defcfun ("csoundGetNamedGEN" csoundGetNamedGEN) :void
;; (csound :pointer)
;; (num :int)
;; (name :pointer)
;; (len :int))

;; (cffi:defcfun ("csoundAppendOpcode" csoundAppendOpcode) :int
;; (csound :pointer)
;; (opname :pointer)
;; (dsblksiz :int)
;; (flags :int)
;; (thread :int)
;; (outypes :pointer)
;; (intypes :pointer)
;; (iopadr :pointer)
;; (kopadr :pointer)
;; (aopadr :pointer))
