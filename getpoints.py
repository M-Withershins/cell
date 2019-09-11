import json
import sys

def getpoints(fname):
    file = open(fname, 'r')
    s = json.load(file)
    if len(s['shapes']) == 2:
        points = s['shapes'][0]['points']+s['shapes'][1]['points']
    else:
        points = s['shapes'][0]['points']
    a = "".join(map(str,points))
    match = a.replace('][',',')
    b = ""
    print match 

if __name__ == '__main__':
    getpoints(sys.argv[1])


