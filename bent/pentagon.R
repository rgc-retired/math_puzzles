# Question from Bent, Winter 2004
#
#     Assume the Pentagon building,
#     near Washington, DC, is situated on
#     a flat plane with no restrictions in
#     visibility. If you are situated at a
#     random point at ground level exactly
#     6 km from the center of the Pentagon,
#     what is the probability that you
#     can see three sides of the building?
#     Assume the length of a side of the
#     Pentagon is 281 m.
# 
#     -- Paul A. Sabatino, NY M'83

# Let us use polar coordinates to calculation location of points
# on the pentagon.

# Pentagon
# Length of a side: L = 2*R*sin(dtheta/2)
# Need to scale this to 281 meters
#
# So: need R = L/(2*sin(dtheta/2))
#
L=281
nsides = 5
dtheta = 2*pi/nsides
rotation=-pi/2
radius=L/(2*sin(dtheta/2))

theta = (0:4)*dtheta+rotation
x=radius*cos(theta)
y=radius*sin(theta)

# Large circle - polygon approximation
radius2=1500
nsides2=100
theta2=(0:(nsides2-1))*2*pi/nsides2
x2=radius2*cos(theta2)
y2=radius2*sin(theta2)

# Set up the plot view
### For full view, radius2 = 6km
### plot(x2,y2,type='n',asp=1,xlab='X',ylab='Y',main='Full View')
###
### For zoom view, radius2 = 1500m
### For showing two pie slices need to shift the xlim by 500
### in order to see the circle on the right so use limits
### of xlim=c(-500,1500)
plot(x2,y2,type='n',asp=1,xlab='X',ylab='Y',main='Diagram View',
    ylim=c(-500,1500),
    xlim=c(-1000,1000),
    xaxt="n",
    yaxt="n")

### For inifinity - radius2 = 50km
### plot(x2,y2,type='n',asp=1,xlab='X',ylab='Y',main='Infinity View')

# Plot the pentagon and large circle
polygon(x,y,col='red',lwd=3)
polygon(x2,y2)

# Need to calculate extensions on two of the sides of the
# pentagon to project them out to the circle to visualize
# the angle where three walls of pentagon may be seen.
#
# One line starts at x[3],y[3], angle=pi-dtheta
# Another line starts at x[4],y[4], angle=dtheta

# First extension
x3=c(x[3],x[3]+radius2*cos(pi-dtheta))
y3=c(y[3],y[3]+radius2*sin(pi-dtheta))
lines(x3,y3,col='blue')

# Second extension
x4=c(x[4],x[4]+radius2*cos(dtheta))
y4=c(y[4],y[4]+radius2*sin(dtheta))
lines(x4,y4,col='blue')

# Make a second set of projections to show the next region where
# three sides are visible.
# First extension - second side
x5=c(x[3],x[3]+radius2*cos(0))
y5=c(y[3],y[3]+radius2*sin(0))
lines(x5,y5,col='green')

# Second extension - second side
# angle is pi/2-(pi-dtheta)/2 = dtheta/2
x6=c(x[2],x[2]+radius2*cos(dtheta/2))
y6=c(y[2],y[2]+radius2*sin(dtheta/2))
lines(x6,y6,col='green')

#
# Add annotations to show the triangles needed to solve
# the problem.  Unfortunately, I had to solve the problem
# to determine the coordinates for the drawing I wanted
# to use to solve the problem...
r1=radius
p=r1*cos(dtheta/2)+L/2*tan(dtheta)
x7=c(0,0)
y7=c(0,p)
lines(x7,y7,lty='dashed')

text(-50,p,"P")
text(-200,250,"A")
text( 200,250,"B")
text(   0,-50,"O")
text( 200,1430,"C")

# Radial lines inside the pentagon showing one pie slice
lines(c(0,x[3]),c(0,y[3]),lty='dashed')
lines(c(0,x[4]),c(0,y[4]),lty='dashed')


# After solving the problem the central half-angle is known
# and used here to make the plot.  Add a radial line from the center
# to the outside edge of the circle
#
# Unfortunately, this makes for a lousy picture since you can't
# see the angles at the full scale.  Needed to solve this a second
# time for the smaller viewing radius.
r2=radius2
alpha=pi/2+dtheta
beta=asin(p/r2*sin(alpha))
delta=pi-(alpha+beta)
### delta=10.5927/180*pi
x8=c(0,r2*sin(delta))
y8=c(0,r2*cos(delta))
lines(x8,y8,lty='dashed')

