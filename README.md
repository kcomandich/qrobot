
qrobot
=======

About
-----

Toy Robot Simulator


Requirements
------------

Tested with Ruby 2.6.1. Should work with Ruby 2.3.0+


Use
---

```
bin/qrobot
```

Options are shown at the start of the program:

```
Toy Robot Simulator
A simulation of a toy robot moving on a square 5x5 board
Type 'QUIT' to exit at any time

(0,0) is the southwest-most corner
Options:
  * PLACE X,Y,F
  PLACE will put the robot on the board in position X,Y and facing (F) NORTH, SOUTH, EAST, or WEST
  * MOVE will move the robot one unit forward in the direction it is currently facing
  * LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the posion of the robot
  * REPORT will announce the X, Y and F of the robot
> PLACE 0,0,NORTH
> MOVE
> LEFT
> REPORT
> X: 0 Y: 1, Facing: WEST

```


Developing
----------

First, install bundler:

```
gem install bundler
```

Then get the dependencies:

```
bundle install
```


Author
------

Kirsten Comandich <kcomandich@gmail.com>


License
-------

This program is provided under an MIT open source license, read the [MIT-LICENSE.txt](MIT-LICENSE.txt) file for details.


Copyright
---------

Copyright (c) 2019 by Kirsten Comandich

