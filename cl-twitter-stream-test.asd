#|
  This file is a part of cl-twitter-stream project.
  Copyright (c) 2014 Kentaro Teramoto (twkgr424@yahoo.co.jp)
|#

(in-package :cl-user)
(defpackage cl-twitter-stream-test-asd
  (:use :cl :asdf))
(in-package :cl-twitter-stream-test-asd)

(defsystem cl-twitter-stream-test
  :author "Kentaro Teramoto"
  :license "LLGPL"
  :depends-on (:cl-twitter-stream
               :cl-test-more)
  :components ((:module "t"
                :components
                ((:test-file "cl-twitter-stream"))))

  :defsystem-depends-on (:cl-test-more)
  :perform (test-op :after (op c)
                    (funcall (intern #. (string :run-test-system) :cl-test-more)
                             c)
                    (asdf:clear-system c)))
