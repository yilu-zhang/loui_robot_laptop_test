import numpy as np 
from matplotlib import pyplot as plt 

def open_e_file(path):
  t=[]
  e_vel_x = []
  e_vel_y = []
  e_vel_z = []
  vel_x = []
  vel_y = []
  vel_z = []
  with open(path, 'r') as f:
    for line in f.readlines():
      line_str = line.split()
      if(len(line_str)==8 and line_str[0] =="vel_compare"):
        t.append(float(line_str[1]))
        e_vel_x.append(float(line_str[2]))
        e_vel_y.append(float(line_str[3]))
        e_vel_z.append(float(line_str[4]))
        vel_x.append(float(line_str[5]))
        vel_y.append(float(line_str[6]))
        vel_z.append(float(line_str[7]))
  return t,e_vel_x,e_vel_y,e_vel_z,vel_x,vel_y,vel_z
	
        

if __name__=='__main__':
  t,e_vel_x,e_vel_y,e_vel_z,vel_x,vel_y,vel_z =  open_e_file("/home/yiluzhang/experiment/vins/camera/kinect2/tra_vel/vies_test.txt")

  t0=t[0]
  correct_t = [x-t0 for x in t]
  correct_t1 = [x-t0 for x in t]

  x1 = np.array(correct_t1)
  x = np.array(correct_t) 
  y1 =  np.array(e_vel_x)
  y2 =  np.array(vel_x)
  plt.title("Matplotlib demo") 
  plt.xlabel("x axis caption") 
  plt.ylabel("y axis caption") 
  plt.plot(x1,y1)
  plt.plot(x,y2,color='red')
  plt.show()


