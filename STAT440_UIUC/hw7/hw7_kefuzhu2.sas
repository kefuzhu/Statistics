option nodate;
ods rtf file='C:\440\hw7\kefuzhu2_HW7.rtf' ;
libname hw7 'C:\440\hw7';
title1 STAT 440 Homework 7;
title2 March 28, 2016;
footnote Kefu Zhu;

title3 Exercise 1 (a);
/* Exercise 1 (a)*/
proc contents data = hw7.fmli141 noprint;
run;
proc contents data = hw7.fmli142 noprint;
run;
proc contents data = hw7.fmli143 noprint;
run;
proc contents data = hw7.fmli144 noprint;
run;

proc contents data = hw7.memi141 noprint;
run;
proc contents data = hw7.memi142 noprint;
run;
proc contents data = hw7.memi143 noprint;
run;
proc contents data = hw7.memi144 noprint;
run;


/*          Number of Observations          Number of Variables
  fmli141   1734							30
  fmli142	3319							30
  fmli143	4879							30
  fmli144	6280							30

  memi141	4251							9
  memi142	8252							9
  memi143   12032							9
  memi144	15512							9
*/

title3 Exercise 1 (b);
/* Exercise 1 (b)*/
/*self-defined format*/
proc format;
	value $edufmt	'00' = 'Never attended school'
					'10' = 'First through eighth grade'
					'11' = 'Ninth through twelfth grade (no H.S. diploma)'
					'12' = 'High school graduate'
					'13' = 'Some college, less than college graduate'
					'14' = "Associate's degree (occupational/vocational or academic)"
					'15' = "Bachelor's degree"
					'16' = "Master's degree, (professional/Doctorate degree)*"
					other = 'Miscoded';
run;
proc format;
	value $maritfmt	'1' = 'Married'
					'2' = 'Widowed'
					'3' = 'Divorced'
					'4' = 'Separated'
					'5' = 'Never married'
					other = 'Miscoded';
run;
proc format;
	value $urbnfmt	'1' = 'Urban'
					'2' = 'Rural'
					other = 'Miscoded';
run;
proc format;
	value $racefmt	'1' = 'White'
					'2' = 'Black'
					'3' = 'Native American'
					'4' = 'Asian'
					'5' = 'Pacific Islander'
					'6' = 'Multi-race'
					other = 'Miscoded';
run;
proc format;
	value $regfmt	'1' = 'Northeast'
 				    '2' = 'Midwest'
                  	'3' = 'South'
                  	'4' = 'West';
run;
proc format;
	value $sexfmt	'1' = 'Male'
					'2' = 'Female'
					other = 'Miscoded';
run;
proc format;
	value $incomefmt	'01' = 'Less than $5,000'
 				   		'02' = '$5,000 to $9,999'
  				   		'03' = '$10,000 to $14,999'
				   		'04' = '$15,000 to $19,999'
 				   		'05' = '$20,000 to $29,999'
                   		'06' = '$30,000 to $39,999'
                   		'07' = '$40,000 to $49,999'
                   		'08' = '$50,000 to $69,999'
                   		'09' = '$70,000 and over'
						other = 'Miscoded';
run; 
proc format;
	value $statefmt		'01'='Alabama'
				 		'02'='Alaska' 
			     		'04'='Arizona' 
				 		'05'='Arkansas' 
				 		'06'='California' 
				 		'08'='Colorado' 
                 		'09'='Connecticut' 
				 		'10'='Delaware' 
                 		'11'='District of Columbia' 
                 		'12'='Florida' 
                 		'13'='Georgia' 
                 		'15'='Hawaii' 
                 		'16'='Idaho' 
                 		'17'='Illinois' 
                 		'18'='Indiana' 
                 		'20'='Kansas' 
                 		'21'='Kentucky' 
                 		'22'='Louisiana' 
                 		'23'='Maine' 
                 		'24'='Maryland' 
                 		'25'='Massachuse'
				 		'29'='Missouri'
				 		'30'='Montana'
				 		'31'='Nebraska'
				 		'32'='Nevada'
				 		'33'='New Hampshire'
				 		'34'='New Jersey'
				 		'36'='New York'
				 		'37'='North Carolina'
				 		'39'='Ohio'
				 		'40'='Oklahoma'
				 		'41'='Oregon'
				 		'42'='Pennsylvania'
				 		'44'='Rhode Island'
				 		'45'='South Carolina'
				 		'46'='South Dakota'
				 		'47'='Tennessee'
				 		'48'='Texas'
				 		'49'='Utah'
				 		'51'='Virginia'
				 		'53'='Washington'
						other = 'Miscoded';
run;       
proc format;
	value $incomeb   '1'='Less than 0.1667'
                     '2'='0.1667 – 0.3333'
                     '3'='0.3334 – 0.4999'
                     '4'='0.5000 – 0.6666'
                     '5'='0.6667 – 0.8333'
                     '6'='0.8334 – 1.0000'
					 '7' = 'Miscoded';
run;
proc format;
	value $cufmt	'1' = 'Reference person'
					'2' = 'Spouse'
					'3' = 'Child or adopted child'
					'4' = 'Grandchild'
					'5' = 'In-law'
					'6' = 'Brother or sister'
					'7' = 'Mother or father'
					'8' = 'Other related person'
					'9' = 'Unrelated person'
					'0' = 'Unmarried Partner'
					other = 'Miscoded';
run;
proc format;
	value $educafmt	'1' = 'No schooling completed, or less than 1 year'
					'2' = 'Nursery, kindergarten, and elementary (grades 1-8)'
					'3' = 'High school (grades 9-12, no degree)'
					'4' = 'High school graduate – high school diploma or the equivalent (GED)'
					'5' = 'Some college but no degree'
					'6' = 'Associate’s degree in college'
					'7' = 'Bachelor’s degree (BA, AB, BS, etc.)'
					'8' = 'Master’s professional, or doctorate degree (MA, MS, MBA, MD, JD, PhD, etc.)'
					other = 'Miscoded';
run;

title3 Exercise 1 (c);
/* Exercise 1 (c)*/
data fmli2014_kefuzhu2;
	set hw7.fmli141(IN=fmli1) hw7.fmli142(IN=fmli2) hw7.fmli143(IN=fmli3) hw7.fmli144;
	format BLS_URBN $urbnfmt.
		   EDUC_REF EDUCA2 $edufmt.
		   MARITAL1 $maritfmt.
		   STATE $statefmt.
		   INCLASS $incomefmt.
		   INCLASS2 $incomeb.
		   SEX2 SEX_REF $sexfmt.
		   REGION $regfmt.
	       REF_RACE RACE2 $racefmt.;
    if fmli1=1 then QTR='Q1';
	else if fmli2=1 then QTR='Q2';
	else if fmli3=1 then QTR='Q3';
	else QTR='Q4';
run;

title3 Exercise 1 (d);
/* Exercise 1 (d)*/
proc contents data=fmli2014_kefuzhu2;
run;
ods text="The number of observations is 16212, which is the sum of individual family individual family dataset 1734 + 3319 + 4879 + 6280 = 16212.";

title3 Exercise 1 (e);
/* Exercise 1 (e)*/
proc freq data=fmli2014_kefuzhu2;
	tables EDUC_REF*SEX_REF /norow nocol;
run;

title3 Exercise 1 (f);
/* Exercise 1 (f)*/
proc tabulate data=fmli2014_kfei2;
	class REF_RACE;
	var FINCBTAX;
	table FINCBTAX*REF_RACE*(MEAN MEDIAN STDDEV);
run;

title3 Exercise 1 (g);
/* Exercise 1 (g)*/
data memi2014_kefuzhu2;
	set hw7.memi141(IN=memi1) hw7.memi142(IN=memi2) hw7.memi143(IN=memi3) hw7.memi144;
	format CU_CODE $cufmt.
	       EDUCA $educafmt.
		   SEX $sexfmt.
		   MARITAL $maritfmt.
		   MEMBRACE $racefmt.; 
    if memi1=1 then QTR='Q1';
	else if memi2=1 then QTR='Q2';
	else if memi3=1 then QTR='Q3';
	else QTR='Q4';
run;

title3 Exercise 1 (h);
/* Exercise 1 (h)*/
proc contents data=memi2014_kefuzhu2;
run;
ods text="The number of observations is 40047, which is the sum of individual member dataset 4251 + 8252 + 12032 + 15512 = 40047.";

title3 Exercise 1 (i);
/* Exercise 1 (i)*/
proc sort data= fmli2014_kefuzhu2;
	by NEWID;
run;
proc sort data= memi2014_kefuzhu2;
	by NEWID;
run;
data hw7.ce2014_kefuzhu2;
	merge fmli2014_kefuzhu2 memi2014_kefuzhu2; 
	by NEWID;
run;

title3 Exercise 1 (j);
/* Exercise 1 (j)*/
proc contents data = hw7.ce2014_kefuzhu2;
run;
ods text="The number of observations is 40047, which is the sum of individual member dataset 4251+8252+12032+15512 = 40047.";

title3 Exercise 1 (k);
/* Exercise 1 (k)*/
proc freq data = memi2014_kefuzhu2 noprint;
	tables NEWID/out = memitmp;
run;
data memi;
	set memitmp(drop = Percent);
run;
data famisize;
	set fmli2014_kefuzhu2 (keep = NEWID FAM_SIZE);
run;
proc sort memi;
	by NEWID;
run;
proc sort famisize;
	by NEWID;
run;
data checksize;
	merge memi famisize;
	by NEWID;
run;
proc print data = checksize;
	where count ~= FAM_SIZE;
run;
ods text = 'Because the log of proc print statement shows no observations were selected, all data are valid.';

title;
footnote;
ods rtf close;
