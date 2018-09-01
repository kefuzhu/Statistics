ods rtf file='C:\440\hw5\kefuzhu2_HW5.rtf' ;
libname hw5 'C:\440\hw5';
title1 STAT 440 Homework 5;
title2 March 9, 2016;
footnote Kefu Zhu;

title3 Exercise 1 (a);
/* Exercise 1 (a)*/
data blood_with_errors;
	infile 'C:\440\hw5\blood_with_errors.txt' missover;
	input Subject Gender $ BloodType $ AgeGroup $ WBC RBC Chol;
	label Subject = 'Subject ID'
		  Gender = 'Gender'
		  BloodType = 'Blood Type'
		  AgeGroup = 'Age Group'
		  WBC = 'White blood cell count per microliter'
		  RBC = 'Red blood cell count per microliter'
		  Chol = 'Total cholesterol';
run;
title3 Exercise 1 (b);
/* Exercise 1 (b)*/
proc contents data = blood_with_errors;
run;

title3 Exercise 1 (c);
/* Exercise 1 (c) */

/*RULE:     ----+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+---*/
/*80        g0   Male   A  Old   6370   4.05 225 36*/
/*Subject=. Gender=Male BloodType=A AgeGroup=Old WBC=6370 RBC=4.05 Chol=225 _ERROR_=1 _N_=80*/
/*NOTE: Invalid data for RBC in line 595 29-32.*/
/*595       595  Male   AB Old   .      5.o8 158 36*/
/*Subject=595 Gender=Male BloodType=AB AgeGroup=Old WBC=. RBC=. Chol=158 _ERROR_=1 _N_=595*/



title3 Exercise 1 (d);
/* Exercise 1 (d) */
proc freq data = blood_with_errors nlevels;
	table Subject;
	ods select NLevels;
run;
/*Answer: Subject has missing value and duplicate values.*/

proc freq data = blood_with_errors;
	table Gender;
run;
/*Answer: Gender has inconsistent input value.*/

proc freq data = blood_with_errors;
	table BloodType;
run;
/*Answer: BloodType has inconsistent input value.*/

proc freq data = blood_with_errors;
	table AgeGroup;
run;
/*Answer: AgeGroup has inconsistent input value.*/

proc means data = blood_with_errors n nmiss min max;
	var WBC;
run;
/*Answer: WBC has missing values and at least one observation out of range.*/

proc means data = blood_with_errors n nmiss min max;
	var RBC;
run;
/*Answer: RBC has missing values and at least one observation out of range.*/

proc means data = blood_with_errors n nmiss min max;
	var Chol;
run;
/*Answer: Chol has missing values and at least one observation out of range.*/

title3 Exercise 1 (e);
/* Exercise 1 (e) */
data hw5.blood_fixed_kefuzhu2;
	set blood_with_errors;

/*	Correct invalid Subject ID*/
	if _N_ ~= Subject then Subject = _N_;

/*	Correct WBC invalid values*/
	if WBC = 99999 then WBC =.;
	else if WBC = 0.00 then WBC = .;
	else if WBC = 7.70 then WBC = 7700;
	else if WBC = 6.64 then WBC = 6640;

/* 	Correct RBC invalid values*/
	if RBC = 999.0 then RBC =.;
	else if RBC = 0.441 then RBC = 4.41;
	else if RBC = 0.668 then RBC = 6.68;
	else if RBC = 77.2 then RBC = 7.72;
	else if RBC = 532.0 then RBC = 5.32;
	else if RBC = 53.0 then RBC = 5.3;
	else if RBC = 63.1 then RBC = 6.31;

/*	Correct Chol invalid values*/
	if Chol = 999 then Chol =.;
	else if Chol = 3.09 then Chol = 309;
	else if Chol = 2.42 then Chol = 242;

	/*Correct Gender invalid values*/
	if Gender =: 'F' then Gender = 'Female';
	else if Gender =: 'f' then Gender = 'Female';
	else if Gender =: 'W' then Gender = 'Female';

	if Gender =: 'M' then Gender = 'Male';
	else if Gender =: 'm' then Gender = 'Male';	

	/*Correct Age Group invalid values*/
	if AgeGroup =: '0' then AgeGroup = 'Old';
	else if AgeGroup =: 'O' then AgeGroup = 'Old';
	else if AgeGroup =: 'o' then AgeGroup = 'Old';

	if AgeGroup =: 'Y' then AgeGroup = 'Young';
	else if AgeGroup =: 'y' then AgeGroup = 'Young';

	/*Correct Blood Type invalid values*/
	BloodType = upcase(BloodType);
run;

title3 Exercise 1 (f);
/* Exercise 1 (f) */
/*Revalidate*/
proc freq data = hw5.blood_fixed_kefuzhu2 nlevels;
	table Subject;
	ods select NLevels;
run;

proc freq data = hw5.blood_fixed_kefuzhu2;
	table Gender;
run;

proc freq data = hw5.blood_fixed_kefuzhu2;
	table BloodType;
run;

proc freq data = hw5.blood_fixed_kefuzhu2;
	table AgeGroup;
run;

proc means data = hw5.blood_fixed_kefuzhu2 n nmiss min max;
	var WBC;
run;

proc means data = hw5.blood_fixed_kefuzhu2 n nmiss min max;
	var RBC;
run;

proc means data = hw5.blood_fixed_kefuzhu2 n nmiss min max;
	var Chol;
run;

title;
footnote;
ods rtf close;
