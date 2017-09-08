# Analysing localisation based ticketing applications using probabilistic model checking

This software provides a user interface to access a probabilistic model which can be used to analyse possible failures with location based mobile ticketing applications.
The focus is on failure coming from inaccurate localisation of the user.

## Getting Started

Download the files from https://github.com/cri-zrh/ticketing-application

Content:
- model.pm (main PRISM model)
- model-var.pm (same as model.pm but wihout any suggested values for variables, this is accessed by user interface.)
- properties.pctl (property checking for probability if zone 2 was not recorded, this is accessed by user interface.)
- properties-long.pctl (additional porperties to check if zone 1 and zone 3 weren't recorded.)
- js.js (JavaScript logic for user interface)
- style.css (style for user interface)
- ticketing-system-implementation.hta (application. CLICK TO START USER INTERFACE)
- readme.md


### Prerequisites

You need to have a working copy of PRISM installed.
http://www.prismmodelchecker.org/download.php

A requirement for PRISM is an installation of Java.


### Set up

There is no need for installing the program. 

Follow these steps to run the software:
1. Open js.js and adjust the code for var run_prism:
delete "../../../Users/c.gassmann/Desktop/results.txt" and add the path you want to save the results in. Make sure to add an empty txt-file called results.txt.

2. Put all downloaded files into the prism folder. Make sure all downloaded files are in the same folder as prism.exe
.../prism/bin
 
3. Click on ticketing-system-implementation.hta to start the application

### Running Application

Please consider the following rules while running the application:

1. To define the variables only enter numbers between 0 and 100. 
2. The variable "phone_failure" will be mulitplied by the length of the user's journey, which in this case is 15. Therefore the entered value can't be larger than 6.5.
3. There are no checks before checking the model. If the entered values for the variables are invalid, the output will be wrong without any prior notification.

The output is always the probability of not recording zone, tested on a range of accuracy from 20% to 100%. The output will always be in a txt-file.


## Authors

Cristina Gassmann www.github.com/cri-zrh

06.09.2017

