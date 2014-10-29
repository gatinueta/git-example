from Tkinter import *
from random import randint,uniform
import math
from copy import deepcopy

def point_inside_polygon(p, poly):
    i=0
    j= len(poly)-1
    c = False
    while i < len(poly):
        if ((poly[i].y > p.y) != (poly[j].y > p.y)) and (p.x < (poly[j].x-poly[i].x) * (p.y-poly[i].y) / (poly[j].y-poly[i].y) + poly[i].x) :
            c = not c
        j = i
        i += 1
    return c

def point_inside_polygon2(p,poly):
    n = len(poly)
    inters=0
    p1 = poly[0]
    for i in range(1,n+1):
        p2 = poly[i%n]
        if min(p1.y,p2.y) < p.y and p.y < max(p1.y,p2.y):
            x = p1.x + (p2.x-p1.x)/(p2.y-p1.y) * (p2.y-p.y)
            if x<p.x:
                inters += 1
        p1 = p2
    return inters%2 == 1
    
def addpoint_callback(event):
    p = Point(event.x, event.y)
    print "adding point ", p
    event.widget.bounds.append(p)

def startanim_callback(event):
    anim.set_start(Point(event.x, event.y))
    anim.start_anim()


class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __repr__(self):
        return "[ " + str(self.x) + ", " + str(self.y) + " ]" 

class tkanim:
    def draw_polygon(self, event):
        self.w.create_polygon([ ( p.x, p.y ) for p in self.w.bounds ], fill='', outline='green')

    def start_anim(self):
        self.master.after(100, self.animate)

    def set_start(self, p):
        self.p = self.lastp = p

    def shoot(self,event):
        widget = event.widget
        p = Point(event.x, event.y)
        if point_inside_polygon(p, widget.bounds):
            color = 'blue'
        else:
            color = 'red'
        widget.create_oval(event.x-2, event.y-2, event.x+2, event.y+2, fill=color, outline=color)
 
    def __init__(self):
        self.master = Tk()
        twidth=500
        theight=500
        border = 40
        self.w = Canvas(self.master, width=twidth, height=theight)
        self.w.bind("<Button-1>", addpoint_callback)
        self.w.bind("<Button-2>", startanim_callback)
        self.w.bind("<Control-Button-1>", self.shoot)
        self.w.bind("<Control-Button-2>", self.draw_polygon)
        self.w.pack()
        self.w.bounds = [] 
        self.SIZE = 2
        self.direction = 0

    def inrange(self,p):
        return point_inside_polygon(p, self.w.bounds)

    def animate(self):
        fx = math.sin(self.direction)
        fy = math.cos(self.direction)
        steps=0
        while self.inrange(self.p):
            self.lastp = deepcopy(self.p)
            self.p.x += uniform(0,2)*fx
            self.p.y += uniform(0,2)*fy
            self.w.create_oval(self.p.x, self.p.y, self.p.x+self.SIZE, self.p.y+self.SIZE, fill="red", outline="red")
            steps += 1
        #self.w.create_oval(self.p.x, self.p.y, self.p.x+5*self.SIZE, self.p.y+5*self.SIZE, fill="blue", outline="blue")
        self.direction = self.direction + math.pi + uniform(-.5,+.5)
        if self.direction > 2*math.pi:
            self.direction -= 2*math.pi
        #print "changing direction after ", steps, " steps"
        self.p = deepcopy(self.lastp)
        self.master.after(100, self.animate)


anim = tkanim()
mainloop()
