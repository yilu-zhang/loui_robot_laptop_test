import os
import sys
import numpy as np
import cv2
import json

#high_list=[1.5,2,2.5] #输出几个高度的平面图 单位米
#每个高度取的阈值 如高度为1.5,阈值0.25时取得1.5-0.25到1.5+0.25米点云做输出
#high_thre=0.25
high_list=[1.6,1.7,1.8] #输出几个高度的平面图 单位米
#每个高度取的阈值 如高度为1.5,阈值0.25时取得1.5-0.25到1.5+0.25米点云做输出
high_thre=0.2
cx = 314.5
cy = 235.5
fx = 570.3422241210938
fy = 570.3422241210938
depth_scale = 1000.0

def getdict(filename=None):
    '''
    输入json文件名
    返回字典对象
    '''
    try:
        if filename:
            f=open(filename)
            dic=json.load(f)
            return dic
        else:
            return{}
    except Exception as e:
        print('getdict error',e)
        return {}


def createdepthfile(inputfile,outputpath=None):
    _dic=getdict(inputfile)
    if len(_dic)>0:
        for k,v in _dic.items():
            #print('k:%s,v: %s'%(k,v))
            _x,_y=k.split('_')
            _x = float(_x)
            _y = float(_y)
            pointdata=[]#伪代码
            for _k,_v in v.items():
                print("process image")
                _theta=float(_k)
                #_x _y _theta 就是当前点云数据的坐标和航向
                #print('depthfile=',_v)
                #print('x=%s,y=%s,theta=%s'%(_x,_y,_theta))
                _data=getdepthfile(_v,_theta)
                pointdata.append(_data)
                #_data就是对应的位姿观察的点云
                #pointdata.append(tf(None,None))
                #点云转换到世界坐标系，增加到文件（列表）中
                pass
            print(len(pointdata))
            points_num = 0
            for img_points in pointdata:
                points_num = points_num + len(img_points)
            print(points_num)

            num_2D_img = len(high_list)
            layer_max_x=[float("-inf")]*num_2D_img
            layer_min_x=[float("inf")]*num_2D_img
            layer_max_y=[float("-inf")]*num_2D_img
            layer_min_y=[float("inf")]*num_2D_img
            point_2D = {}
            for i in range(num_2D_img):
                point_2D[i]=[]
            print(len(layer_max_x))

            test_i =0
            for img_points in pointdata:
                for point_w in img_points:
                    #test_i=test_i+1
                    #if test_i<500000 and test_i%50000==0:
                        #print(point_w)
                    for i in range(num_2D_img):                       
                        if (point_w[2]+1.48)>=high_list[i] and (point_w[2]+1.48)<=(high_list[i]+high_thre):
                            if(point_w[0]>layer_max_x[i]):
                                layer_max_x[i]=point_w[0]
                            if(point_w[0]<layer_min_x[i]):
                                layer_min_x[i]=point_w[0]
                            if(point_w[1]>layer_max_y[i]):
                                layer_max_y[i]=point_w[1]
                            if(point_w[1]<layer_min_y[i]):
                                layer_min_y[i]=point_w[1]
                            point_2D[i].append([point_w[0],point_w[1]])
                            if point_w[0]!=point_2D[i][-1][0] or point_w[1]!=point_2D[i][-1][1]:
                                print("error")
            
            
            path = outputpath + k + "_"
            #for i in range(num_2D_img):
                #print(layer_max_x[i])
                #print(layer_min_x[i])
                #print(layer_max_y[i])
                #print(layer_min_y[i])
                #print(len(point_2D[i]))
                #print(point_2D[i][1:20])

            for i in range(num_2D_img):
                img_out=np.zeros((480,640),dtype=np.uint8)
                for row in range(img_out.shape[0]):
                    for col in range(img_out.shape[1]):
                        img_out[row,col] = 255
                detal_x = layer_max_x[i] - layer_min_x[i]
                detal_y = layer_max_y[i] - layer_min_y[i]
                if detal_x > detal_y:       
                    scale_factor=min((img_out.shape[1]-100)/detal_x,(img_out.shape[0]-100)/detal_y)
                    ori_flag = 1
                else:
                    scale_factor=min((img_out.shape[1]-100)/detal_y,(img_out.shape[0]-100)/detal_x)
                    ori_flag = 0
                
                print(scale_factor)
                for point in point_2D[i]:
                    if ori_flag==1:
                        #if int(scale_factor*(point[0]-layer_min_x[i]))+40>=640:
                            #print(point[0])
                            #print(layer_min_x[i])
                        img_out[int(scale_factor*(layer_max_y[i]-point[1]))+50,int(scale_factor*(point[0]-layer_min_x[i]))+50] = 0
                    else:
                        img_out[int(scale_factor*(layer_max_x[i]-point[0]))+50,int(scale_factor*(layer_max_y[i]-point[1]))+50] = 0
                path1 = path + str(high_list[i]) + "_" + str(high_list[i]+high_thre) + "_" + str(scale_factor) +".jpg"
                print(path1)
                cv2.imwrite(path1,img_out)


            


            #for i in range(len(high_list)):
                #根据上下阈值截取点云 输出到文件
                #pointdata 每一个位置的全部数据在这里 
                #pass
                #如果outputpath is None 则输出到当前目录，否则输出到制定目录路
    else:
        print('len of dic is 0')


# theta:camera to world
def raw_to_Rwc(theta):
    R_wc = np.zeros((3,3))
    R_wc[0][0] = np.cos(theta)
    R_wc[0][1] = np.sin(theta)
    R_wc[1][0] = -np.sin(theta)
    R_wc[1][1] = np.cos(theta)
    R_wc[2][2] = 1
    return R_wc

    

def getdepthfile(filename,theta):
    #读入cv或numpy
    img=cv2.imread(filename,cv2.IMREAD_ANYDEPTH)
    R_wc = raw_to_Rwc(theta)
    pointdata_k = []
    #print(img.shape[0])
    #print(img.shape[1])
    for row in range(img.shape[0]):
        for col in range(img.shape[1]):
            depth = img[row,col]
            
            if depth >= 10 and depth <= 60000:
                p_c = []
                depth = depth/depth_scale               
                p_c.append((col-cx)*depth/fx)   # x            
                p_c.append(depth)              # z
                p_c.append((cy-row)*depth/fy)   # -y
                p_w = list(np.dot(R_wc,np.array(p_c)))
                pointdata_k.append(p_w)
    return pointdata_k


def tf(m1,m2):
    '''
    #m1 转换矩阵
    #m2 机器坐标系点云
    return 世界坐标系 点云
    '''
    print('坐标转换')

def add2img(point):
    pass


def test(args):
    print('args',args)
    if len(args)>2:
        createdepthfile(args[1],args[2])
    elif len(args)>1:
        createdepthfile(args[1])
    else:
        print('args error')

if __name__=='__main__':
    print('''
            ---demo---
            python3 depth.py [inputpath][outputpath]
            ''')
    test(sys.argv)
    pass
