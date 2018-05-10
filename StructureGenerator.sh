#!/usr/bin/env python

import sys
import os
from Parameters import *

def WriteCPVals(CPValue):

	file1 = open("CPValue.dat","w")
	file1.write("%lf" % CPValue)
	file1.close()

CurrentCP = CPMin
Counter = 0

if os.path.exists("CPValue_0"):
	os.system("rm -r CPValue_*")

while CurrentCP <= CPMax:

	DirName = "CPValue_" + str(Counter)
	os.mkdir(DirName)
	CopyString1 = "cp *.exe " + DirName
	CopyString2 = "cp -r src " + DirName
	CopyString3 = "cp -r include " + DirName
	CopyString4 = "cp -r lib " + DirName
	os.system(CopyString1)
	os.system(CopyString2)
	os.system(CopyString3)
	os.system(CopyString4)

	os.chdir(DirName)
	WriteCPVals(CurrentCP)
	os.chdir("..")

	Counter = Counter + 1
	CurrentCP = CurrentCP + dX

os.system("echo")
os.system("echo")
os.system("echo ----- Structure and Compilation Completed -----")
os.system("echo")
os.system("echo")
