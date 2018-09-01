option nodate;
ods rtf file='C:\440\hw6\kefuzhu2_HW6.rtf' ;
libname hw6 'C:\440\hw6';
title1 STAT 440 Homework 5;
title2 March 15, 2016;
footnote Kefu Zhu;

title3 Exercise 1 (a);
/* Exercise 1 (a)*/
data inventory;
	set hw6.inventory;
run;
data purchase;
	set hw6.purchase;
run;

proc sort data=inventory;	
	by model;
run;

proc sort data=purchase;
	by model;
run;

data purchase_price_kefuzhu2 purchase(drop = Total);
	merge inventory(in=inI) purchase(in=inP);
	by model;
	Total = Quantity*Price;
	if inI=1 and inP=1 then do;
		output purchase_price_kefuzhu2;
		output purchase;
	end;
run;

title3 Exercise 1 (b);
/* Exercise 1 (b)*/
proc print data=purchase_price_kefuzhu2 noobs;
run;

title3 Exercise 1 (c);
/* Exercise 1 (c)*/
data not_purchased_kefuzhu2;
	merge inventory(in=inI) purchase(in=inP);
	by model;
	if inI=1 and inP=0
		then output not_purchased_kefuzhu2;
	keep Model Price;
run;

title3 Exercise 1 (d);
/* Exercise 1 (d)*/
proc print data=not_purchased_kefuzhu2 noobs;
run;

title3 Exercise 1 (e);
/* Exercise 1 (e)*/
data purchase_price_kefuzhu2 not_purchased_kefuzhu2;
	merge inventory(in=inI) purchase(in=inP);
	by model;
	TotalCost = Quantity*Price;
	if inI=1 and inP=1
		then output purchase_price_kefuzhu2;
	if inI=1 and inP=0
		then output not_purchased_kefuzhu2;
		keep Model Price;
run;

proc print data=purchase_price_kefuzhu2 noobs;
run;

proc print data=not_purchased_kefuzhu2 noobs;
run;

title3 Exercise 2 (a);
/* Exercise 2 (a)*/
data bat_AL;
	set hw6.bat_AL;
run;
data bat_NL;
	set hw6.bat_NL;
run;
data bat_earlyyears;
	set hw6.bat_earlyyears;
run;
proc means data=bat_AL min max;
	var YearID;
run;
proc means data=bat_NL min max;
	var YearID;
run;
proc means data=bat_earlyyears min max;
	var YearID;
run;

title3 Exercise 2 (b);
/* Exercise 2 (b)*/
data batting_kefuzhu2;
	set bat_AL bat_NL bat_earlyyears;
	keep PlayerID YearID TeamID G AB R H RBI;
run;

title3 Exercise 2 (c);
/* Exercise 2 (c)*/
proc contents data=batting_kefuzhu2;
run;

ods text = 'The result meets my expectation because the number of observations is the sum of the number of observations in the three data sets';

title3 Exercise 2 (d);
/* Exercise 2 (d)*/
/*Sort each data set by PlayerID first*/
proc sort data = bat_AL;
	by PlayerID;
run;
proc sort data = bat_NL;
	by PlayerID;
run;
proc sort data = bat_earlyyears;
	by PlayerID;
run;

data bothleagues_kefuzhu2;
	merge bat_AL(in=inAL) bat_NL(in=inNL) bat_earlyyears;
	by PlayerID;
	where 1970 <= YearID <= 1989;
	if inAL=1 and inNL=1
		then output bothleagues_kefuzhu2;	
run;

title3 Exercise 2 (e);
/* Exercise 2 (e)*/
proc contents data = bothleagues_kefuzhu2;
run;

title3 Exercise 2 (f);
/* Exercise 2 (f)*/
data MostHits_kefuzhu2;
 	set batting_kefuzhu2;
	where H>200;
	keep PlayerID YearID TeamID H;
run;

title3 Exercise 2 (g);
/* Exercise 2 (g)*/
proc print data = MostHits_kefuzhu2;
run;

title;
ods rtf close;
