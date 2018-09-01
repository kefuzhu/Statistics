/*Assign libname*/
libname project 'C:\440';

/*Load raw data file for 2009 housing data*/
data raw_h2009 (keep = CONTROL VACANCY BEDRMS NUNITS BUILT STRUCTURETYPE BURDEN AGE1 ZINC2 ZSMHC VALUE UTILITY PER REGION);
	infile 'C:\440\h2009.txt' dlm = ',' firstobs = 2 missover;
	input CONTROL:$20. AGE1 BEDRMS PER REGION:$20. METRO3:$20. LMED FMR L30 L50 L80 IPOV BUILT STATUS:$20. TYPE VCHRMOV:$20. VALUE VACANCY TENURE:$20. NUNITS ZINC2 ROOMS ZADEQ:$20. ZSMHC
		  WEIGHT STRUCTURETYPE:$20. OWNRENT:$20. UTILITY OTHERCOST COST06 COST12 COST08 COSTMED TOTSAL ASSISTED GLMED GL30 GL50 GL80 PLMED ABL30 ABL50 ABL80 ABLMED BURDEN
		  INCRELAMIPCT INCRELAMICAT INCRELPOVPCT INCRELPOVCAT INCRELFMRPCT INCRELFMRCAT COST06RELAMIPCT COST06RELAMICAT COST06RELPOVPCT COST06RELPOVCAT COST06RELFMRPCT COST06RELFMRCAT
		  COST08RELAMIPCT COST08RELAMICAT COST08RELPOVPCT COST08RELPOVCAT COST08RELFMRPCT COST08RELFMRCAT COST12RELAMIPCT COST12RELAMICAT COST12RELPOVPCT COST12RELPOVCAT COST12RELFMRPCT
		  COST12RELFMRCAT COSTMedRELAMIPCT COSTMedRELAMICAT COSTMedRELPOVPCT COSTMedRELPOVCAT COSTMedRELFMRPCT COSTMedRELFMRCAT FMTZADEQ:$20. FMTMETRO3:$20. FMTBUILT:$20. FMTSTRUCTURETYPE:$20. FMTBEDRMS:$20. 
		  FMTOWNRENT:$20. FMTCOST06RELPOVCAT:$20. FMTCOST08RELPOVCAT:$20. FMTCOST12RELPOVCAT:$20. FMTCOSTMEDRELPOVCAT:$20. FMTINCRELPOVCAT:$20. FMTCOST06RELFMRCAT:$20. FMTCOST08RELFMRCAT:$20. FMTCOST12RELFMRCAT:$20. FMTCOSTMEDRELFMRCAT:$20.
		  FMTINCRELFMRCAT:$20. FMTCOST06RELAMICAT:$20. FMTCOST08RELAMICAT:$20. FMTCOST12RELAMICAT:$20. FMTCOSTMEDRELAMICAT:$20. FMTINCRELAMICAT:$20. FMTASSISTED:$20. FMTBURDEN:$20. FMTREGION:$20. FMTSTATUS:$20.;
	/*Recode for Region*/
	select(REGION);
		when ("'1'") REGION = 'Northwest';
		when ("'2'") REGION = 'Midwest';
		when ("'3'") REGION = 'South';
		when ("'4'") REGION = 'West';
		otherwise REGION = 'Miscoded';
	end;

	/*Recode for STRUCTURETYPE*/
	select(STRUCTURETYPE);
		when('1') STRUCTURETYPE = 'Single Family';
		when('2') STRUCTURETYPE = '2-4 units';
		when('3') STRUCTURETYPE = '5-19 units';
		when('4') STRUCTURETYPE = '20-49 units';
		when('5') STRUCTURETYPE = '50+ units';
		when('6') STRUCTURETYPE = 'Mobile Home';
		otherwise STRUCTURETYPE = 'Miscoded';
	end;	
run;

/*Data Validation*/
/*Exploratary Analysis*/
	proc freq data = raw_h2009;
		tables BEDRMS PER NUNITS;
	run;
	/*Reflection: 
	  1. Variable BEDRMS should not have value of zero. But the frequency table shows that 445 observations in 2009 data file have zero bedrooms. 
	  It is worth to print a small portion of those observations to see if they have unreasonable values for other variables.
	  2. Variable PER should not have negative values. But the frequency table shows that 4033 obsevations in 2009 data file have value of -6 for PER.
	*/
	proc print data = raw_h2009 (obs = 10) noobs;
		where BEDRMS = 0;
	run;
/*Reflection: Among 10 printed observations, 9 of them have -6 value in VALUE and 8 of them have -6 value in VACANCY. 
Few observations also have suspicious values in other variables like -9 in AGE1, PER, ZINC2 and ZSMHC, and negative values in BURDEN.*/

/*Continuous Variables*/	
	/*---Age of household (AGE1)---*/
	/*Note: The resonable range for age of household should be between 20 and 90.
	Because adolescents are not likely to become household and only very few of households are likely to be older than 90.*/

	proc freq data = raw_h2009;
		tables AGE1;
		where AGE1 < 20 | AGE1 >90;
	run;
	/*Reflection: In 2009 data file, 4033 observations have age of -9 and 429 observations have age of 93.
	The values of -9 is definitelly impossible in the real life. But since there is no missing values in the frequency table and the number of -9 values are huge (4033), it is reasonable to assume that the system use -9 to represent missing values.
	It is suspicious that all households (429) who are older than 90 are actually recorded as 93. So I decide to investigate those observations further.*/

	proc print data = raw_h2009 (obs = 10) noobs;
		where AGE1 = 93;
	run;
	/*Reflection: It is worth noting that all first ten observations who are 93 years old have value of -6 for VACANCY variable. */
	proc print data = raw_h2009;
		where AGE1 = 93 & VACANCY ~= -6;
	run;
	/*Reflection: Upon further investigation, all observations who are 93 years old have value of -6 for VACANCY variable. 
	Although I don't have more information about the meaning of -6 value of VACANCY variable, this problem should be investigated further in future work.*/

	/*-------------------------------------------------------------------------------------------------------------------------------------*/

	/*---Value of VALUE (Current market value of unit)---*/
	/*Note: The value of VALUE should not be non-positive.*/

	proc freq data = raw_h2009;
		tables VALUE;
		where VALUE <= 0;
	run;
	/*Reflection: Based on the frequency table, all 17610 observations that have negative values have value of -6 for VALUE. 
	Since the number of observation is more than 1/5 of the total data size (49090), it is not quite possible that those values are simply input errors. 
	Because VACANCY variable also contains many -6 values, it is reasonable to speculate that -6 has some special meaning. 
	*/

	/*-------------------------------------------------------------------------------------------------------------------------------------*/

	/*---Value of UTILITY (Monthly utility cost)---*/
	/*Note: The value of UTILITY should not be non-negative, and zero values is worth investigated.*/
	proc freq data = raw_h2009;
		tables UTILITY;
		where UTILITY <= 0;
	run;
	/*Reflection: 2510 observations have zero value of UTILITY. This might indicate that no one is living in those houses. 
	Therefore, I will validate my assumption by obtaining the frequency table of variable VACANCY for those observations.*/

	proc freq data = raw_h2009;
		tables VACANCY;
		where UTILITY <= 0;
	run;
	/*Reflection: About 78.29% (1965 out of 2510) of those observations have value of -6 for VACANCY variable. 
	Although I don't have information on the meaning of -6 value for VACANCY, it is reasonable to guess that -6 might represent "Empty" for VACANCY variable.*/

/*-------------------------------------------------------------------------------------------------------------------------------------*/

	/*---Value of BURDEN (Housing cost as a fraction of income)---*/
	/*Note: The reasonable range for BURDEN is between 0 and 1*/

	proc freq data = raw_h2009;
		tables BURDEN;
		where BURDEN < 0;
	run;
	/*Reflection: 4033 observations have value of -9 for BURDEN and 550 observations have value of -1 for BURDEN. 
	Negative values might indicate that those people do not have a job and get subsidy from other people or the government. 
	But I still can not explain the situation of having two distinctive negative values for BURDEN. This problem should be investigated in future work.*/
	
	proc means data = raw_h2009 n mean median std min max skew;
		var BURDEN;
		where BURDEN >=1;
	run;

	/*Reflection: 3173 observations have value greater than 1 for BURDEN. Those people might get loans from banks or other financial services for their houses payment.

	However, the median (2.0693) is way smaller than the mean (23.6189), and the value of skewness (22.949) is extremely large compare to the normal threshold of 1. 
	Compared to the minimum, mean and median, the maximum is also too large to be reasonable. 
	All these information indicate that the distribution of BURDEN is extremely right-skewed and those observations that have huge value of BURDEN need to be investigated in future work.

	It is not quite possible for people afford houses that are worth thousands times of their income.*/

/*Check number of observations and variables in each dataset*/
proc contents data = raw_h2009;
run;
proc contents data = raw_h2011;
run;
proc contents data = raw_h203;
run;
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

/*Data Cleaning*/
	/*Housing data from 2009*/
	data h2009;
		set raw_h2009;
		where BEDRMS > 0 & 
			  PER > 0 &
			  20 <= AGE1 <= 90 &
		  	  VALUE > 0 &
		  	  UTILITY >= 0 &
			  NUNITS > 0 &
		  	  0 < BURDEN < 10;
		  	  /*Include the reference to interpret why choos range between 0 and 10*/
		      Year = 2009;
	run;

		/*Housing data from 2011*/
	/*Load sas data file for 2011 housing data*/
	data raw_h2011 (drop = numSTR);
		/*Make sure variables have the same length*/
		length CONTROL $ 20 VACANCY 8 BEDRMS 8 NUNITS 8 BUILT 8 STRUCTURETYPE $ 20 BURDEN 8 AGE1 8 ZINC2 8 ZSMHC 8 VALUE 8 UTILITY 8 PER 8 REGION $ 20;
		set project.h2011 (keep = CONTROL VACANCY BEDRMS NUNITS BUILT STRUCTURETYPE BURDEN AGE1 ZINC2 ZSMHC VALUE UTILITY PER REGION 
						   rename = (STRUCTURETYPE = numSTR));
		/*Recode for Region*/
		select(REGION);
			when ('1') REGION = 'Northwest';
			when ('2') REGION = 'Midwest';
			when ('3') REGION = 'South';
			when ('4') REGION = 'West';
			otherwise REGION = 'Miscoded';
		end;

		/*Recode for STRUCTURETYPE*/
		select(numSTR);
			when(1) STRUCTURETYPE = 'Single Family';
			when(2) STRUCTURETYPE = '2-4 units';
			when(3) STRUCTURETYPE = '5-19 units';
			when(4) STRUCTURETYPE = '20-49 units';
			when(5) STRUCTURETYPE = '50+ units';
			when(6) STRUCTURETYPE = 'Mobile Home';
			otherwise STRUCTURETYPE = 'Miscoded';
		end;

		/*Label*/
		label STRUCTURETYPE = 'Recoded structure type';
	run;

	/*Cleaning*/
	data h2011;
		set raw_h2011;
		where BEDRMS > 0 & 
			  PER > 0 &
			  20 <= AGE1 <= 90 &
			  VALUE > 0 &
			  UTILITY >= 0 &
			  NUNITS > 0 &
			  0 < BURDEN < 10;
			  /*Include the reference to interpret why choos range between 0 and 10*/
		Year = 2011;
	run;
	/*Housing data from 2013*/
	/*Load raw data file for 2013 housing data*/
	data raw_h2013 (keep = CONTROL VACANCY BEDRMS NUNITS BUILT STRUCTURETYPE BURDEN AGE1 ZINC2 ZSMHC VALUE UTILITY PER REGION);
		infile 'C:\440\h2013.txt' dlm = ',' firstobs = 2 missover;
		input CONTROL:$20. AGE1 METRO3:$20. REGION:$20. LMED FMR L30 L50 L80 IPOV BEDRMS BUILT STATUS:$20. TYPE VALUE VACANCY TENURE:$20. NUNITS ROOMS WEIGHT PER ZINC2 ZADEQ:$20. ZSMHC STRUCTURETYPE
		      OWNRENT:$20. UTILITY OTHERCOST COST06 COST12 COST08 COSTMED TOTSAL ASSISTED GLMED GL30 GL50 GL80 APLMED ABL30 ABL50 ABL80 ABLMED BURDEN INCRELAMIPCT INCRELAMICAT 
     	      INCRELPOVPCT INCRELPOVCAT INCRELFMRPCT INCRELFMRCAT COST06RELAMIPCT COST06RELAMICAT COST06RELPOVPCT COST06RELPOVCAT COST06RELFMRPCT COST06RELFMRCAT COST08RELAMIPCT
    	      COST08RELAMICAT COST08RELPOVPCT COST08RELPOVCAT COST08RELFMRPCT COST08RELFMRCAT COST12RELAMIPCT COST12RELAMICAT COST12RELPOVPCT COST12RELPOVCAT COST12RELFMRPCT 
    	      COST12RELFMRCAT COSTMedRELAMIPCT COSTMedRELAMICAT COSTMedRELPOVPCT COSTMedRELPOVCAT COSTMedRELFMRPCT COSTMedRELFMRCAT FMTZADEQ:$20. FMTMETRO3:$20. FMTBUILT:$20. FMTSTRUCTURETYPE:$20. 
    	      FMTBEDRMS:$20. FMTOWNRENT:$20. FMTCOST06RELPOVCAT:$20. FMTCOST08RELPOVCAT:$20. FMTCOST12RELPOVCAT:$20. FMTCOSTMEDRELPOVCAT:$20. FMTINCRELPOVCAT:$20. FMTCOST06RELFMRCAT:$20. FMTCOST08RELFMRCAT:$20. 
     	      FMTCOST12RELFMRCAT:$20. FMTCOSTMEDRELFMRCAT:$20. FMTINCRELFMRCAT:$20. FMTCOST06RELAMICAT:$20. FMTCOST08RELAMICAT:$20. FMTCOST12RELAMICAT:$20. FMTCOSTMEDRELAMICAT:$20. FMTINCRELAMICAT:$20. FMTASSISTED:$20. 
      	      FMTBURDEN:$20. FMTREGION:$20. FMTSTATUS:$20.;
		/*Recode for Region*/
		select(REGION);
			when ("'1'") REGION = 'Northwest';
			when ("'2'") REGION = 'Midwest';
			when ("'3'") REGION = 'South';
			when ("'4'") REGION = 'West';
			otherwise REGION = 'Miscoded';
		end;
	run;

	/*Cleaning*/
	data h2013 (drop = numSTR);
		set raw_h2013 (rename = (STRUCTURETYPE = numSTR));
		/*Make sure variables have the same length*/
		length STRUCTURETYPE $ 20;
		where BEDRMS > 0 & 
			  PER > 0 &
			  20 <= AGE1 <= 90 &
			  VALUE > 0 &
			  UTILITY >= 0 &
			  NUNITS > 0 &
			  0 < BURDEN < 10;
			  /*Include the reference to interpret why choos range between 0 and 10*/
		Year = 2013;
		select(numSTR);
			when(1) STRUCTURETYPE = 'Single Family';
			when(2) STRUCTURETYPE = '2-4 units';
			when(3) STRUCTURETYPE = '5-19 units';
			when(4) STRUCTURETYPE = '20-49 units';
			when(5) STRUCTURETYPE = '50+ units';
			when(6) STRUCTURETYPE = 'Mobile Home';
			otherwise STRUCTURETYPE = 'Miscoded';
		end;
	run;
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*Check number of observations and variables in each dataset*/
proc contents data = h2009;
run;
proc contents data = h2011;
run;
proc contents data = h2013;
run;
/*Merging Data*/
	/*Sort all datasets by control number to prepare for merging*/
	proc sort data = h2009;
		by CONTROL;
	run;
	proc sort data = h2011;
		by CONTROL;
	run;
	proc sort data = h2013;
		by CONTROL;
	run;

	/*Merge three datasets into one*/
	data merged;
		merge h2009 h2011 h2013;
		by CONTROL;
	run;
	/*Reflection: Because the sum of number of observations in each dataset does not equal to the number of observations in the merged dataset, 
	I suspect there are duplicated CONTROL ID across dataset for each year.*/

	/*Investigation on duplicated Control ID*/

	/*Append all data into a temporary dataset to check duplicated ID*/
	proc append base = tmp data = h2009;
	run; 
	proc append base = tmp data = h2011;
	run; 
	proc append base = tmp data = h2013;
	run; 

	/*Check the duplicated ID*/
	proc freq data = tmp;
		tables CONTROL / noprint out = check_duplicateID;
	run;
	/*Write observations that have the same ID to duplicate_ID dataset*/
	data duplicate_ID;
		set check_duplicateID;
		where count > 1;
	run;
	/*Reflection: Because there are a lot of observations that have the same control ID, 
	I decide to just include the observation that has the latest information (The Year value associated with that observation is the greatest among the Year values of other duplicated observations).*/

	/*Interleave three datasets and create permanent dataset called merged, which only include the observation that has the latest information*/
	data project.merged;
		set h2009 h2011 h2013;
		by CONTROL;
		if Last.CONTROL ~= 1 then delete;
	run;

/*Check number of observations and variables in each dataset*/
proc contents data = project.merged;
run;
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*Meaningful Subset*/

	/*Create permanent dataset called luxury that contains subjects who is living in a house that cost more than his/her income.*/
	data project.luxury;
		set merged;
		where BURDEN > 1;
	run;

	/*Create permanent dataset called young that contains only young people (20 <= age <= 40)*/
	data project.young;
		set merged;
		where 20 <= AGE1 <= 40;
	run;
	/*Create permanent dataset called middle_age that contains only middle age people (40 < age <= 65)*/
	data project.middle_age;
		set merged;
		where 40 < AGE1 <= 65;
	run;
	/*Create permanent dataset called old that contains only old people (age > 65)*/
	data project.old;
		set merged;
		where AGE1 > 65;
	run;
