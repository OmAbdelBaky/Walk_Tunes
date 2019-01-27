file = open("data.txt","r")
import math
def dist (lat1,lat2,lon1,lon2):
    return math.sqrt((lat1-lat2)**2+(lon1-lon2)**2)

def findPlaysByRadius (radius, lat, long):
    temp_array=[]
    for i in file:
        x=i.split(", ")
        if (dist(float(x[3]),lat,float(x[4]),long)<radius):
            temp_array.append(x)
            print(x)
        
    

findPlaysByRadius(2,-89,39)
