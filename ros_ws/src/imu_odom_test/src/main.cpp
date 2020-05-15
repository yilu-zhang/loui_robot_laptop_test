#include "ros/ros.h"
#include "sensor_msgs/Imu.h"
#include <eigen3/Eigen/Dense>
#include <eigen3/Eigen/Geometry>

using namespace Eigen;

Quaterniond qi_wk0(1.0,0.0,0.0,0.0);
Vector3d vel(0.0,0.0,0.0);
Vector3d acc_0(0.0,0.0,9.8);
Vector3d g_w(0.0,0.0,9.8);
//double detal_t(0.005);

void imu_vel_compute(const sensor_msgs::Imu::ConstPtr &msg)
{
    Vector3d acc_1(msg->linear_acceleration.x,msg->linear_acceleration.y,msg->linear_acceleration.z),vel_k;
    Quaterniond qi_wk1(msg->orientation.w,msg->orientation.x,msg->orientation.y,msg->orientation.z);
    vel += 0.0025*(qi_wk0*acc_0-g_w + qi_wk1*acc_1-g_w);
    vel_k=qi_wk1.inverse()*vel;
    acc_0 = acc_1;
    qi_wk0 = qi_wk1;

    ROS_INFO("The vel is:%f %f %f",vel_k.x(),vel_k.y(),vel_k.z());	
}

int main(int argc, char **argv)
{
    ros::init(argc,argv,"imu_odom_node");
    ros::NodeHandle n;
    ros::Subscriber sub0=n.subscribe("/imu",1000,imu_vel_compute);
    ros::spin();
    return 0;
}
