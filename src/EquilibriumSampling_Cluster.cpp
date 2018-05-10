/* Equilibrium Sampling Driver Implementation written in C++ with a Correlation function calculator built in */

#include <fstream>
#include <iostream>
#include <random>
#include <cmath>
#include <string>
#include <ctime>

#include <sstream>

#include "include/DiscreteControl.h"
#include "include/DiscreteControl_Eq.h"

using namespace std;

/* Main Routine */


int main(){

	double dt = 0.1;
	double CPMax = 1.0;
	double CP;
	int MAXLAG = 1000;
	double EqTime = 500;
	int TotalStats = 1000000000;

	int Counter = 0;

	std::ifstream Readfile;

	Readfile.open("CPValue.dat");
	Readfile >> CP; 
	Readfile.close();

	string WriteNameCorr = "BistableCorrelation_CP_.dat";

	int ArrayLength = int(MAXLAG/dt) + 1;

	double * Corr;
	Corr = new double [ArrayLength];
	double * LagTime;
	LagTime = new double [ArrayLength];
	int Accumulator = 0;


	double * ForceWindow;
	ForceWindow = new double [ArrayLength];
	double ForceAccumulator = 0;
	double ForceMean;

	double time = 0;
	double position = CP;
	double velocity = 0;

	double * timePointer = &time;
	double * positionPointer = &position;
	double * velocityPointer = &velocity;

	/* Run Langevin integrator to equilibrate sytem at CP */

	while(time <= EqTime) {
		LangevinBistable(positionPointer, velocityPointer, timePointer, CP);
	}

	time = 0;


	/* Initialize the ForceWindow and LagTime arrays */

	LagTime[0] = time;
	ForceWindow[0] = ForceParticleBistableTrap(position,CP);

	ForceAccumulator += ForceWindow[0];

	for(int k = 1 ; k < ArrayLength ; k++) {
		LangevinBistable(positionPointer, velocityPointer, timePointer, CP);
		ForceWindow[k] = ForceParticleBistableTrap(position,CP);
		LagTime[k] = time;
		ForceAccumulator += ForceWindow[k];
	}


	/* Calculate the first entries in the Correlation array */

	for(int k = 0 ; k < ArrayLength ; k++) {
		Corr[k] = ForceWindow[0]*ForceWindow[k];
	}
	

	/* Calculate the Correlation array with TotalStats number of entries at each position */

	for(int k = 0 ; k < TotalStats ; k++) {
		LangevinBistable(positionPointer, velocityPointer, timePointer, CP);

		for(int i = 0 ; i < ArrayLength-1 ; i++) {
			ForceWindow[i] = ForceWindow[i+1];
		}

		ForceWindow[ArrayLength-1] = ForceParticleBistableTrap(position,CP);
		ForceAccumulator += ForceWindow[ArrayLength-1];

		for(int j = 0 ; j < ArrayLength ; j++) {
			Corr[j] += ForceWindow[0]*ForceWindow[j];
		}
	}

	/* Average Correlation array entries and Subtract off the Force Variance */
	
	ForceMean = ForceAccumulator/(TotalStats + 1);

	for(int k = 0 ; k < ArrayLength ; k++){
		Corr[k] = (Corr[k]/double(TotalStats + 1)) - ForceMean*ForceMean;
	}

	/* Write Data to the Output File */

	std::ofstream Writefile;

	Writefile.open(WriteNameCorr);
	Writefile << "LagTime\tCorrelation\n\n";
	for(int k = 0 ; k < ArrayLength ; k++){
		Writefile << LagTime[k] << "\t" << Corr[k] << "\n";
	}
	Writefile.close();

	CP = CP + dX;
	Counter = Counter + 1;

	delete Corr;
	delete LagTime;
	delete ForceWindow;

}






