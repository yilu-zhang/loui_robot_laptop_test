#include "ros/ros.h"
#include "sensor_msgs/Image.h"
#include "std_msgs/Header.h"

void info0_show(const sensor_msgs::Image::ConstPtr &msg)
{
	std_msgs::Header head;
	head = msg->header;

	ROS_INFO("image0_seq:%d",msg->header.seq);	
        ROS_INFO("image0_seconds:%f",head.stamp.toSec());        
}

void info1_show(const sensor_msgs::Image::ConstPtr &msg)
{
	ROS_INFO("image1_seq:%d",msg->header.seq);	
        ROS_INFO("image1_seconds:%f",msg->header.stamp.toSec());       
}

int main(int argc, char **argv)
{
        ros::init(argc,argv,"show_image_raw");
        ros::NodeHandle n;
        ros::Subscriber sub0=n.subscribe("/kinect2/hd/image_color",10,info0_show);
	ros::Subscriber sub1=n.subscribe("/kinect2/qhd/image_color",10,info1_show);
        ros::spin();
        return 0;
}
