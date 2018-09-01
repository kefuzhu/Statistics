option nodate;
ods pdf file='C:\440\hw8\kefuzhu2_HW8.pdf' ;
libname hw8 'C:\440\hw8';
title1 STAT 440 Homework 8;
title2 April 5, 2016;
footnote Kefu Zhu;

title3 Exercise 1 (a);
/* Exercise 1 (a)*/
data discount_ret (keep = Customer_ID Customer_Name TotSales)
	 discount_cat (keep = Customer_ID Customer_Name TotSales Customer_Gender)
	 discount_int (keep = Customer_ID Customer_Name TotSales Customer_BirthDate);
	set hw8.Orders;
	TotSales = Quantity*Total_Retail_Price;
	select (Order_Type);
		when (1) do;
			if Quantity*Total_Retail_Price >= 250 then output discount_ret;
		end;
		when (2) do;
			if Quantity*Total_Retail_Price >= 100 then output discount_cat;
		end;
		otherwise do;
			if Quantity*Total_Retail_Price >= 100 then output discount_int;
		end;
	end;
run;

title3 Exercise 1 (b);
/* Exercise 1 (b)*/
ods text = 'Data portion of discount_ret';
proc print data = discount_ret label;
	label TotSales = 'Total Sales';
	format TotSales:dollar10.2;
run;
ods text = 'Data portion of discount_cat';
proc print data = discount_cat label;
	label TotSales = 'Total Sales';
	format TotSales:dollar10.2;
run;
ods text = 'Data portion of discount_int';
proc print data = discount_int label;
	label TotSales = 'Total Sales';
	format TotSales:dollar10.2;
run;

title3 Exercise 2 (a);
/* Exercise 2 (a)*/
data trade_kefuzhu2;
	infile 'C:\440\hw8\importexport87-15.dat' dlm = '09'x;
	input Begin_Date:$50. Export Import @@;
	Balance = Export - Import;
	format Balance Export Import dollar10.2;
run;

title3 Exercise 2 (b);
/* Exercise 2 (b)*/
proc print data = trade_kefuzhu2 (obs = 24) noobs;
run;

title3 Exercise 2 (c);
/* Exercise 2 (c)*/
data tmp (drop = Begin_Date);
	infile 'C:\440\hw8\importexport87-15.dat' dlm = '09'x;
	input Begin_Date:$50. Export Import @@;
	Year = substr(Begin_Date,length(Begin_Date)-3,4);
run;
proc sort data = tmp;
	by Year;
run;
data yearlyimports_kefuzhu2 (keep = Year YearTotal YearAvg);
	set tmp;
	by Year;
	if First.Year then YearTotal = 0;
	YearTotal + Import;
	if Last.Year;
	YearAvg = YearTotal/12;
run;

title3 Exercise 2 (d);
/* Exercise 2 (d)*/
proc contents data = yearlyimports_kefuzhu2;
run;

title3 Exercise 2 (e);
/* Exercise 2 (e)*/
proc print data = yearlyimports_kefuzhu2;
run;

title3 Exercise 2 (f);
/* Exercise 2 (f)*/
data tmp;
	set yearlyimports_kefuzhu2;
	Decade = substr(Year,length(Year)-1,1);
	haha = 1;
run;
proc sort data = tmp;
	by Decade;
run;
data tmp1;
	set tmp;
	by Decade;
	if First.Decade then do;
		DecadeTotal = 0;
		Count = 0;
	end;
	DecadeTotal + YearTotal;
	Count + haha;
	if Last.Decade then DecadeAvg = DecadeTotal/Count;
run;
data decade;
	set tmp1(keep = Decade DecadeAvg);
	where DecadeAvg ~=.;
	if Decade = 0 then Decade = "00's";
	else if Decade = 1 then Decade = "10's";
	else if Decade = 8 then Decade = "80's";
	else Decade = "90's";
run;
proc print data = decade;
run;

title;
footnote;
ods pdf close;
