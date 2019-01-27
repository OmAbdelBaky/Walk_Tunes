file = open("data.txt","r")
import math
def dist (lat1,lat2,lon1,lon2):
    radius = 6371000
    lat1_rad = lat1 * math.pi / 180
    lat2_rad = lat2 * math.pi / 180
    lon1_rad = lon1 * math.pi / 180
    lon2_rad = lon2 * math.pi / 180
    
    de_lat = lat1_rad - lat2_rad
    de_lon = lon1_rad - lon2_rad
    
    a = math.pow(math.sin(de_lat / 2), 2) + math.cos(lat1_rad) * math.cos(lat2_rad) * math.pow(math.sin(de_lon / 2),2)
    b = 2 * math.atan2(math.sqrt(a), math.sqrt(a))
    return a*b

def findPlaysByRadius (radius, lat, long):
    temp_array=[]
    for i in file:
        x=i.split(", ")
        if (dist(float(x[3]),lat,float(x[4]),long)<radius):
            temp_array.append(x)
            print(x)
        
    

findPlaysByRadius(2,-89,39)
