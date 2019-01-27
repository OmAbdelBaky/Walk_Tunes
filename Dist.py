import math
def dist (lat1,lon1,lat2,lon2):
    radius = 6371000
    lat1_rad = lat1 * math.pi / 180
    lat2_rad = lat2 * math.pi / 180
    lon1_rad = lon1 * math.pi / 180
    lon2_rad = lon2 * math.pi / 180
    de_lat = lat1_rad - lat2_rad
    de_lon = lon1_rad - lon2_rad
    a = math.pow(math.sin(de_lat / 2), 2) + math.cos(lat1_rad) * math.cos(lat2_rad) * math.pow(math.sin(de_lon / 2),2)
    b = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
    return radius * b
