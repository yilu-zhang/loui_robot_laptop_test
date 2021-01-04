; Auto-generated. Do not edit!


(cl:in-package motor_info_listener-msg)


;//! \htmlinclude Motor.msg.html

(cl:defclass <Motor> (roslisp-msg-protocol:ros-message)
  ((current
    :reader current
    :initarg :current
    :type cl:fixnum
    :initform 0)
   (velocity
    :reader velocity
    :initarg :velocity
    :type cl:fixnum
    :initform 0)
   (position
    :reader position
    :initarg :position
    :type cl:fixnum
    :initform 0))
)

(cl:defclass Motor (<Motor>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Motor>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Motor)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name motor_info_listener-msg:<Motor> is deprecated: use motor_info_listener-msg:Motor instead.")))

(cl:ensure-generic-function 'current-val :lambda-list '(m))
(cl:defmethod current-val ((m <Motor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader motor_info_listener-msg:current-val is deprecated.  Use motor_info_listener-msg:current instead.")
  (current m))

(cl:ensure-generic-function 'velocity-val :lambda-list '(m))
(cl:defmethod velocity-val ((m <Motor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader motor_info_listener-msg:velocity-val is deprecated.  Use motor_info_listener-msg:velocity instead.")
  (velocity m))

(cl:ensure-generic-function 'position-val :lambda-list '(m))
(cl:defmethod position-val ((m <Motor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader motor_info_listener-msg:position-val is deprecated.  Use motor_info_listener-msg:position instead.")
  (position m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Motor>) ostream)
  "Serializes a message object of type '<Motor>"
  (cl:let* ((signed (cl:slot-value msg 'current)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'velocity)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'position)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Motor>) istream)
  "Deserializes a message object of type '<Motor>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'current) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'velocity) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'position) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Motor>)))
  "Returns string type for a message object of type '<Motor>"
  "motor_info_listener/Motor")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Motor)))
  "Returns string type for a message object of type 'Motor"
  "motor_info_listener/Motor")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Motor>)))
  "Returns md5sum for a message object of type '<Motor>"
  "26411605b4fae1f6e867c4d5a5f569df")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Motor)))
  "Returns md5sum for a message object of type 'Motor"
  "26411605b4fae1f6e867c4d5a5f569df")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Motor>)))
  "Returns full string definition for message of type '<Motor>"
  (cl:format cl:nil "int16 current~%int16 velocity~%int16 position~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Motor)))
  "Returns full string definition for message of type 'Motor"
  (cl:format cl:nil "int16 current~%int16 velocity~%int16 position~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Motor>))
  (cl:+ 0
     2
     2
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Motor>))
  "Converts a ROS message object to a list"
  (cl:list 'Motor
    (cl:cons ':current (current msg))
    (cl:cons ':velocity (velocity msg))
    (cl:cons ':position (position msg))
))
