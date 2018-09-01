option nodate;
ods rtf file='C:\440\hw11\kefuzhu2_HW11.rtf' ;
libname hw11 'C:\440\hw11';
title1 STAT 440 Homework 11;
title2 April 24, 2016;
footnote Kefu Zhu;

title3 Exercise 1 (a);
/* Exercise 1 (a)*/
proc sql;
	describe table hw11.batting;
quit;
/*!!!!!!!!!!!!!!!!!!!!!!!!!!Copy the LOG!!!!!!!!!!!!!!!!!!!!!!!!!!!*/

title3 Exercise 1 (b);
/* Exercise 1 (b)*/
proc sql;
		select PlayerID, YearID, TeamID, H
		from hw11.batting	
		where H > 245;
quit;

title3 Exercise 1 (c);
/* Exercise 1 (c)*/
proc sql;
	select LgID, 
		   min(YearID) 'First Year', 
		   max(YearID) 'Last Year'
	from hw11.batting
	group by LgID
	;
quit;

title3 Exercise 1 (d);
/* Exercise 1 (d)*/
proc sql;
	select PlayerID, YearID, HR
	from hw11.batting
	where HR > 50
	group by YearID
	having HR = max(HR)	
	;
quit;

title3 Exercise 2 (a);
/* Exercise 2 (a)*/
proc sql;
	create table purchase_price_kefuzhu2 as 
		select CustNumber, purchase.Model, Price, Quantity, Price * Quantity as TotalCost format = dollar8.2 
		from hw11.inventory, hw11.purchase
		where purchase.Model = inventory.Model
	;
quit;

title3 Exercise 2 (b);
/* Exercise 2 (b)*/
proc print data = purchase_price_kefuzhu2 noobs;
run;

title3 Exercise 2 (c);
/* Exercise 2 (c)*/
proc sql;
	create table hw11.not_purchased_kefuzhu2 as
		select inventory.Model, Price
			from hw11.inventory
			where not exists(
				select *
					from hw11.purchase
					where purchase.Model = inventory.Model
			)
	;
quit;

title3 Exercise 2 (d);
/* Exercise 2 (d)*/
proc print data = hw11.not_purchased_kefuzhu2 noobs;
run;

title;
footnote;
ods rtf close;
