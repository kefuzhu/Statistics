option nodate;
ods rtf file='C:\440\hw10\kefuzhu2_HW10.rtf' ;
libname hw10 'C:\440\hw10';
title1 STAT 440 Homework 10;
title2 April 17, 2016;
footnote Kefu Zhu;

title3 Exercise 1 (a);
/* Exercise 1 (a)*/
data money;
	input Option $ Deposit:dollar8. Rate:percent8. Frequency:$12. Times;
	datalines;
A $1000 8.00% Yearly 1
B $1700 4.00% Quarterly 4
C $2000 3.50% Quarterly 4
D $2200 2.25% Monthly 12
E $2500 1.25% Monthly 12
F $2700 1.00% Weekly 52
;
run;

data mostmoney_kefuzhu2 (drop = i j);
	set money;
	Balance = 0;
	do i = 1 to 25;
		Balance + Deposit;
		do j = 1 to Times;
			Balance + (Balance*(Rate/Times));
		end;
	end;
	label Balance = 'Total after 25 years';
run;

title3 Exercise 1 (b);
/* Exercise 1 (b)*/
proc print data = mostmoney_kefuzhu2 label;
	format Rate percent8.2
		   Balance dollar25.2
		   Deposit dollar8.;
run;

title3 Exercise 1 (c);
/* Exercise 1 (c)*/
data save30_kefuzhu2 (keep = Option Year Amount);
	set money;
	Amount = 0;
	Year = 0;
	do while (Amount < 30000);
		Amount + Deposit;
		do j = 1 to Times;
			Amount + (Amount*(Rate/Times));
		end;
		Year + 1;
	end;
	label Year = 'Years until $30K';
run;

title3 Exercise 1 (d);
/* Exercise 1 (d)*/
proc print data = save30_kefuzhu2 label;
	format Amount dollar12.2;
run;

title3 Exercise 2 (a);
/* Exercise 2 (a)*/
data hw10.chicago_kefuzhu2;
	infile 'C:\440\hw10\chicago_avg_temps 12-15.txt';
	input Temp @@;
	Date = MDY(1,1,2012);
	if _N_ > 1 then Date+(_N_-1);
	Weekday = Date;
	format Weekday DOWNAME.
		   Date WORDDATE.;
run;

title3 Exercise 2 (b);
/* Exercise 2 (b)*/
proc print data = hw10.chicago_kefuzhu2;
	where Date >= mdy(12,01,2014);
run;

title3 Exercise 2 (c);
/* Exercise 2 (c)*/
data hw10.hotdays_kefuzhu2;
	infile 'C:\440\hw10\hourly_temps.txt';
	input Temp @@;
	if _N_ <= 24 then do;
		Day = 1;
		Hour = _N_;
	end;
	else do;
		Day = 2;
		Hour = (_N_-24);
	end; 
run;

title3 Exercise 2 (d);
/* Exercise 2 (d)*/
proc means data = hw10.hotdays_kefuzhu2 n median mean std;
	var Temp;
	by Day;
run;

title;
footnote;
ods rtf close;
