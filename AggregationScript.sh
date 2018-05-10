#!/usr/bin/env python

import os
import sys

from Parameters import *

CurrentCP = CPMin
Counter = 0

WriteDir = "AggregateData"

os.chdir("Data")

os.mkdir(WriteDir)

while CurrentCP <= CPMax:

	DirName = "CPValue_" + str(Counter)
	CopyString = "cp " + DirName + "/BistableCorrelation_CP_.dat"
	WriteName = WriteDir + "/BistableCorrelation_CP_" + str(Counter) + ".dat"

	CopyCommand = CopyString + " " + WriteName 

os.system("tar -cvf FromCluster.tar AggregateData/*.dat")

os.system("echo")
os.system("echo")
os.system("echo ----- Finished Aggregating Data -----")
os.system("echo")
os.system("echo")








