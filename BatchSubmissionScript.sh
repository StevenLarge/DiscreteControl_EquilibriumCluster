#!/usr/bin/env python

import sys
import os
from Parameters import *

CurrentCP = CPMin
Counter = 0

os.chdir("Data")

while CurrentCP <= CPMax:

	DirName = "CPValue_" + str(Counter)
	os.chdir(DirName)

	sbatch SlurmSubmission.sh

	os.chdir("..")

	CurrentCP = CurrentCP + dX

os.system("echo")
os.system("echo")
os.system("echo ----- Submission Script Finished -----")
os.system("echo")
os.system("echo")



