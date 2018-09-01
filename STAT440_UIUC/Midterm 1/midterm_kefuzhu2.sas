/*This is the code aims for 100% correction :D*/
/*Set up*/
ods pdf file='C:\440\midterm\midterm_kefuzhu2.pdf' ;
libname midterm 'C:\440\midterm';
title1 STAT 440 Midterm # 1;
title2 March 3, 2016;

footnote Kefu Zhu;
/*Part (a)*/
title3 Part (a);
data illinifb_kefuzhu2;
	infile 'C:\440\midterm\illinifb.dat' dsd missover;
	input Obs Season Conf $ W L T Pct SRS SOS AP_pre AP_high AP_post Coach:$50. Record:$25. Bowl:$25. BowlResult $;
	label Obs = 'Observation Number'
		  Season = 'Season'
		  Conf = 'Conference'
		  W = 'Wins'
		  L = 'Loses'
		  T = 'Ties'
		  Pct = 'Win Percentage'
		  SRS = 'Simple Rating System'
		  SOS = 'Strength of Schedule'
		  AP_pre = 'Rank in pre-season AP poll'
		  AP_high = 'Highest rank of the team in AP poll'
		  AP_post = 'Rank in final AP poll'
		  Coach = 'Head Coach'
		  Record = "Coach's Record"
		  Bowl = 'Post-season Bowl Game'
		  BowlResult = 'Result of Bowl Game';
	format Pct percent8.1;
	drop Obs;
run;

/*Part (b)*/
title3 Part (b);
proc contents data = illinifb_kefuzhu2;
run;

/*Part (c)*/
title3 Part (c);
proc freq data = illinifb_kefuzhu2 nlevels;
	tables Season;
	ods select NLevels;
run;
ods text = 'Since the total number of observation is 124 and Season variable has 124 unique values, each value of Season is unique.';

/*Part (d)*/
title3 Part (d);
proc means data = illinifb_kefuzhu2 n nmiss min max;
	var W L T Pct;
run;

/*Part (e)*/
title3 Part (e);
proc print data = illinifb_kefuzhu2;
	var Season W L T Pct Record;
	where Pct~= round(W/sum(W,L,T),0.001);
run;

/*Part (f)*/
title3 Part (f);
proc freq data = illinifb_kefuzhu2;
	tables Coach;;
run;
ods text = 'Robert Zuppake presided as head coach for the most seasons.';

/*Part (g)*/
title3 Part (g);
data illinifb_clean_kefuzhu2;
	set illinifb_kefuzhu2;
/*	Fix the missing value in L variable*/
	if L = . then L = 0;
/*	Fix the problem of more than one coach is listed for a season*/
	if Season = 1991 then do; Coach='John Mackovic'; Record='(6-5)';end;
	else if Season = 2011 then do; Coach = 'Ron Zook'; Record = '(6-6)'; end;	
/*	Fix the missing coach variable*/
	else if Season = 1904 then do; Coach = 'Arthur R. Hall'; Record = '(9𣇻)'; end;
/*	Fix the rest of values for W, L and T that are not consistent with Records*/
	else if Season = 1911 then do; W = 4; L = 2; T = 1; end;
	else if Season = 1892 then do; W = 9; L = 3; T = 2; end;
	else if Season = 1894 then do; W = 5; L = 3; T = 0; end;
/*	Fix wrong calculation of percentage variable*/
	if Pct~= round(W/sum(W,L,T),0.001) then Pct = round(W/sum(W,L,T),0.001);
run;
	
/*Part (h)*/
title3 Part (h);
proc print data = illinifb_clean_kefuzhu2;
	var Season W L T Pct Record;
	where Pct~= round(W/sum(W,L,T),0.001);
run;
/*Since no violation, print observation from 2015*/
proc print data = illinifb_clean_kefuzhu2;
	var Season W L T Pct Record;
	where Season = 2015;
run;

/*Part (i)*/
title3 Part (i);
proc freq data = illinifb_clean_kefuzhu2;
	tables Coach;;
run;

title;
footnote;
ods pdf close;
