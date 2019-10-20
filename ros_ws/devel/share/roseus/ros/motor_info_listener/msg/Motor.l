;; Auto-generated. Do not edit!


(when (boundp 'motor_info_listener::Motor)
  (if (not (find-package "MOTOR_INFO_LISTENER"))
    (make-package "MOTOR_INFO_LISTENER"))
  (shadow 'Motor (find-package "MOTOR_INFO_LISTENER")))
(unless (find-package "MOTOR_INFO_LISTENER::MOTOR")
  (make-package "MOTOR_INFO_LISTENER::MOTOR"))

(in-package "ROS")
;;//! \htmlinclude Motor.msg.html


(defclass motor_info_listener::Motor
  :super ros::object
  :slots (_current _velocity _position ))

(defmethod motor_info_listener::Motor
  (:init
   (&key
    ((:current __current) 0)
    ((:velocity __velocity) 0)
    ((:position __position) 0)
    )
   (send-super :init)
   (setq _current (round __current))
   (setq _velocity (round __velocity))
   (setq _position (round __position))
   self)
  (:current
   (&optional __current)
   (if __current (setq _current __current)) _current)
  (:velocity
   (&optional __velocity)
   (if __velocity (setq _velocity __velocity)) _velocity)
  (:position
   (&optional __position)
   (if __position (setq _position __position)) _position)
  (:serialization-length
   ()
   (+
    ;; int16 _current
    2
    ;; int16 _velocity
    2
    ;; int16 _position
    2
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int16 _current
       (write-word _current s)
     ;; int16 _velocity
       (write-word _velocity s)
     ;; int16 _position
       (write-word _position s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int16 _current
     (setq _current (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _velocity
     (setq _velocity (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _position
     (setq _position (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;;
   self)
  )

(setf (get motor_info_listener::Motor :md5sum-) "26411605b4fae1f6e867c4d5a5f569df")
(setf (get motor_info_listener::Motor :datatype-) "motor_info_listener/Motor")
(setf (get motor_info_listener::Motor :definition-)
      "int16 current
int16 velocity
int16 position


")



(provide :motor_info_listener/Motor "26411605b4fae1f6e867c4d5a5f569df")


