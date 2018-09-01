option nodate;
ods pdf file='C:\440\hw9\kefuzhu2_HW9.pdf' ;
libname hw9 'C:\440\hw9';
title1 STAT 440 Homework 9;
title2 April 12, 2016;
footnote Kefu Zhu;

title3 Exercise 1 (a);
/* Exercise 1 (a)*/
proc sort data = hw9.demographic;
	by ID;
run;
proc sort data = hw9.survey1;
	by Subj;
run;
data demo1_kefuzhu2;
	merge hw9.demographic hw9.survey1 (rename = (Subj = ID));
	by ID;
run;

title3 Exercise 1 (b);
/* Exercise 1 (b)*/
proc print data = demo1_kefuzhu2;
run;

title3 Exercise 1 (c);
/* Exercise 1 (c)*/
data demo_convert (drop = charID);
	set hw9.demographic(rename = (ID = charID));
	ID = input(charID,3.);
run;
data demo2_kefuzhu2;
	merge demo_convert hw9.survey2;
	by ID;
run;

title3 Exercise 1 (d);
/* Exercise 1 (d)*/
proc print data = demo2_kefuzhu2;
run;

title3 Exercise 2 (a);
/* Exercise 2 (a)*/
data updated_kefuzhu2(drop = charID strPhone Phone1 Phone2 Phone3 Phone4 Height topfractWeight botfractWeight);
	set hw9.fivepeople(rename = (ID = charID Phone = strPhone));
	ID = input(charID,4.);

	Name = scan(Name,2," ")!!', '!!scan(Name,1," ");

	Phone1 = compress(strPhone,'(');
	Phone2 = compress(Phone1,')');
	Phone3 = compress(Phone2,'-');
	Phone4 = compress(Phone3,' ');
	Phone = input(Phone4,10.);

	Height = compress(Height,'.');
	HtSymbol = Tranwrd(upcase(Height),'FT',"'");
	HtSymbol = Tranwrd(upcase(HtSymbol),'IN','"');

	HtInches = sum(12*substr(HtSymbol,1,1),substr(compress(HtSymbol,'"'),4));

	topfractWeight = input(substr(Weight,5,1),1.);
	botfractWeight = input(substr(Weight,7,1),1.);
	WtPounds = round(sum(input(substr(Weight,1,3),3.),topfractWeight/botfractWeight),0.001);
run;

title3 Exercise 2 (b);
/* Exercise 2 (b)*/
proc print data = updated_kefuzhu2;
run;

title3 Exercise 2 (c);
/* Exercise 2 (c)*/
proc contents data = updated_kefuzhu2;
run;

title;
footnote;
ods pdf close;
