#|
  This file is a part of cl-twitter-stream project.
  Copyright (c) 2014 Kentaro Teramoto (twkgr424@yahoo.co.jp)
|#

#|
  Author: Kentaro Teramoto (twkgr424@yahoo.co.jp)
|#

(in-package :cl-user)
(defpackage cl-twitter-stream-asd
  (:use :cl :asdf))
(in-package :cl-twitter-stream-asd)

(defsystem cl-twitter-stream
  :version "0.1"
  :author "Kentaro Teramoto"
  :license "LLGPL"
  :depends-on (:cl-oauth
               :drakma
               :bordeaux-threads)
  :components ((:module "src"
                :components
                ((:file "cl-twitter-stream"))))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op cl-twitter-stream-test))))
