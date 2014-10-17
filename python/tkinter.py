from Tkinter import *
from random import randint,uniform
import math
from copy import deepcopy

class Point:
    x = 0
    y = 0

master = Tk()
w = Canvas(master, width=200, height=200)
w.pack()
p = Point()
p.x = 100.0
p.y = 100.0
MIN = Point()
MIN.x = 10
MIN.y = 10
MAX = Point()
MAX.x = 190
MAX.y = 190

def inrange(p):
    return p.x > MIN.x and p.y > MIN.y and p.x < MAX.x and p.y < MAX.y

SIZE = 10
x=0
direction = 0
lastp = Point()

for i in range(34):
    fx = math.sin(direction)
    fy = math.cos(direction)

    while inrange(p):
        lastp = deepcopy(p)
        p.x += uniform(0,2)*fx
        p.y += uniform(0,2)*fy
        w.create_oval(p.x, p.y, p.x+SIZE, p.y+SIZE, fill="red")
    direction = direction+math.pi+uniform(-.1,+.1)
    p = deepcopy(lastp)
mainloop()

