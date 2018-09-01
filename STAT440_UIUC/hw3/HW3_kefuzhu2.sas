/*Set up*/
ods pdf file='C:\440\hw3\HW3_kefuzhu2.pdf';
title1 STAT 440 Homework3;
title2 February 12, 2016;

footnote Kefu Zhu;

libname hw3 'C:\440\hw3';

/*Exercise 1 (a)*/
title3 Exercise 1 (a);
data AUaids_kefuzhu2;
	infile 'C:\440\hw3\AUaids.dat' dlm =' ' missover;
	input Observation_Number State_of_Origin $ Sex $ Date_of_Diagnosis Date_of_Death Status $ Transmission_Category $ Age;
	label Observation_Number = 'Observation Number'
		  State_of_Origin = 'State of Origin'
		  Sex = 'Sex'
		  Date_of_Diagnosis = 'Date of Diagnosis'
		  Date_of_Death = 'Date of Death'
		  Status = 'Status'
		  Transmission_Category = 'Transmission Category'
		  Age = 'Age';
	format Date_of_Diagnosis Date_of_Death mmddyy8.;
run;

/*Exercise 1 (b)*/
title3 Exercise 1 (b);
proc print data = AUaids_kefuzhu2 (obs = 10) noobs label;
run;

/*Exercise 1 (c)*/
title3 Exercise 1 (c);
data under20_kefuzhu2;
	infile 'C:\440\hw3\AUaids.dat' dlm =' ' missover;
	input Observation_Number State_of_Origin $ Sex $ Date_of_Diagnosis Date_of_Death Status $ Transmission_Category $ Age;
	label Observation_Number = 'Observation Number'
		  State_of_Origin = 'State of Origin'
		  Sex = 'Sex'
		  Date_of_Diagnosis = 'Date of Diagnosis'
		  Date_of_Death = 'Date of Death'
		  Status = 'Status'
		  Transmission_Category = 'Transmission Category'
		  Age = 'Age';
	format Date_of_Diagnosis Date_of_Death mmddyy8.;
	if sex = 'M' & Age < 20 & Transmission_Category = 'blood';
run;

/*Exercise 1 (d)*/
title3 Exercise 1 (d);
proc print data = under20_kefuzhu2 noobs label;
run;

/*Exercise 2 (a)*/
title3 Exercise 2 (a);
data caloriesA_kefuzhu2;
	infile 'C:\440\hw3\caloriesA.txt' dsd dlm = '09'x missover;
	input Food:$50. Per_gram Per_item Classification:$20.;
	label Food = 'Food'
		  Per_gram = 'Percentage differences of calories between meansured and labled per gram'
		  Per_item = 'Percentage differences of calories between meansured and labled per item'
		  Classification = 'Classification';
	
	if Classification = 'L' then Classification = 'Local';
	else if Classification = 'N' then Classification = 'National';
	else Classification = 'Regional'; 

/*	format Per_gram Per_item percent8.;*/
run;

/*Exercise 2 (b)*/
title3 Exercise 2 (b);
proc contents data = caloriesA_kefuzhu2;
run;

/*Exercise 2 (c)*/
title3 Exercise 2 (c);
proc print data = caloriesA_kefuzhu2 label;
	where Classification = 'Local';
run;

/*Exercise 2 (d)*/
title3 Exercise 2 (d);
data caloriesB_kefuzhu2;
	infile 'C:\440\hw3\caloriesB.txt';
	input @1 Food $35.
		  @36 Per_gram 5. 
		  @42 Per_item 4.
		  @48 Classification $1.;
	label Food = 'Food'
		  Per_gram = 'Percentage differences of calories between meansured and labled per gram'
		  Per_item = 'Percentage differences of calories between meansured and labled per item'
		  Classification = 'Classification';
/*	format Per_gram Per_item percent8.;*/
run;

/*Exercise 2 (e)*/
title3 Exercise 2 (e);
proc contents data = caloriesB_kefuzhu2;
run;

/*Exercise 2 (f)*/
title3 Exercise 2 (f);
proc print data = caloriesB_kefuzhu2 label;
	where Per_gram <0 & Per_item <0;
run;

ods pdf close;
