/*Masterpiece from Kefu Zhu*/
/*Set up*/
ods pdf file='C:\440\hw4\HW4_kefuzhu2.pdf' ;
libname hw4 'C:\440\hw4';
title1 STAT 440 Homework;
title2 February 19, 2016;

footnote Kefu Zhu;

/*Exercise 1*/
/*(a)*/
title3 Exercise 1 (a);
data allpatients_kefuzhu2;
	infile 'C:\440\hw3\allergy.dat';
	length ID_Number $ 5 Last_Name $ 9 First_Name $ 11 Plan_Type $ 1 Blood_Type $ 3 Allergy_Code $ 1;
	input ID_Number $ Last_Name $ First_Name $ Plan_Type $ Blood_Type $ Allergy_Code $ @;
	if Allergy_Code = "Y" then 
		input Allergy_Type $ Number_of_Dependents;
	else
		input Number_of_Dependents;
	label ID_Number = 'ID Number'
		  Last_Name = 'Last Name'
		  First_Name = 'First Name'
		  Plan_Type = 'Plan Type'
	      Blood_Type = 'Blood Type'
		  Allergy_Code = 'Allergy Code'
		  Allergy_Type = 'Allergy Type'
		  Number_of_Dependents = 'Number of Dependents';
run;
/*(b)*/
title3 Exercise 1 (b);
proc print data = allpatients_kefuzhu2(drop=ID_Number Plan_Type) label;
run;

/*Exercise 2*/
/*(a)*/
title3 Exercise 2 (a);
data low_earners4_kefuzhu2;
	infile 'C:\440\hw3\employee_roster4.dat' dlm = '**' missover;
	input ID Name:$30. Country:$2.
		 /Company:$20. Department:$20. Section:$20. Organization_Group:$20. Job_Title:$30. Gender:$1.
		 /Salary:dollar9. Birth_Date Hire_Date Termination_Date;
	format Salary dollar9. Birth_Date Hire_Date Termination_Date mmddyy10.;
	if Salary < 25500 & Department = 'Sales';
	label ID = 'ID'
		  Name = 'Name'
		  Country = 'Country'
		  Department = 'Department'
		  Section = 'Section'
		  Organization_Group = 'Organization Group'
		  Job_Title = 'Job Title'
		  Gender = 'Gender'
		  Salary = 'Salary'
		  Birth_Date = 'Birth Date'
		  Hire_Date = 'Hire Date'
		  Termination_Date = 'Termination Date';
run;
/*(b)*/
title3 Exercise 2 (b);
proc contents data = low_earners4_kefuzhu2;
run;
/*(c)*/
title3 Exercise 2 (c);
proc print data = low_earners4_kefuzhu2 label;
	var Name Gender Department Job_Title Salary;
run;

ods pdf close;


