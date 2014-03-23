(require :cl-oauth)
(require :drakma)

(defparameter *callback-uri* "")
(defparameter *callback-port* 8090
  "Port to listen on for the callback")

(defparameter *get-request-token-endpoint* "https://api.twitter.com/oauth/request_token")
(defparameter *auth-request-token-endpoint* "https://api.twitter.com/oauth/authorize")
(defparameter *get-access-token-endpoint* "https://api.twitter.com/oauth/access_token")
(defparameter *key* "your api key")
(defparameter *secret* "your api secret")
(defparameter *consumer-token* (cl-oauth:make-consumer-token :key *key* :secret *secret*))
(defparameter *request-token* nil)
(defparameter *access-token* nil)


(defun get-access-token ()
  (defparameter *access-token*
    (cl-oauth:obtain-access-token *get-access-token-endpoint* *request-token*)))

(defun get-request-token ()
  (defparameter *request-token*
    (cl-oauth:obtain-request-token
     *get-request-token-endpoint*
     *consumer-token*
     :callback-uri *callback-uri*)))

(defun auth ()
  (get-request-token)
  (let
      ((auth-uri (cl-oauth:make-authorization-uri 
		  *auth-request-token-endpoint* 
		  *request-token*)))
    (format t "Please authorize the request token at this URI: ~A~%" (puri:uri auth-uri)))
  (set-pin (read))
  (get-access-token))

(defun set-pin (n)
  (setf (cl-oauth:request-token-verification-code *request-token*) (format nil "~D" n)))

(auth)
