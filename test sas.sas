
data prec_pot;
  input run $ resp;
	datalines;
Run1	1.007
Run1	1.023
Run1	0.947
Run2	0.947
Run2	0.905
Run2	0.897
Run3	1.049
Run3	1.044
Run3	1.041
run;

data prec_pot;
	set prec_pot;
	logresp = log(resp);
run;

ods html;
proc mixed data=prec_pot covtest nobound method=type3;
	class run;
	model logresp = /cl solution;
	random run/g;
	ods output CovParms=CovParms_pot;
run;
ods html close;

data CovParms_pot;
	set CovParms_pot;
	format estimate 15.10;
run;
