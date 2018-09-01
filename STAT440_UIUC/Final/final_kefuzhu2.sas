/*This is the code aims for 100% correction :D*/
/*Set up*/
ods pdf file='C:\440\final\final_kefuzhu2.pdf' ;
libname final 'C:\440\final';
title1 STAT 440 Final Exam;
title2 May 9, 2016;

footnote Kefu Zhu;
/*Part (a)*/
title3 Part(a);
data goalies_kefuzhu2 (drop = v16-v20);
	infile 'C:\440\final\hockey goalies 24FEB15.dat' dsd missover dlm = ',';
	input Player:$30. First Last GP GS W L TOL GA SA SV SV_PCT GAA SO MIN v16-v20 G A PTS PIM;
	label Player = 'NHL Player'
		  First = 'First year of NHL career'
		  Last = 'Last year of NHL career'
		  GP = 'Games Played'
		  GS = 'Games Started'
		  W = 'Wins'
		  L = 'Losses'
		  TOL = 'Ties/Overtime/Shootout Losses'
		  GA = 'Goals Against'
		  SA = 'Shots Against'
		  SV = 'Saves'
		  SV_PCT = 'Save Percentage'
		  GAA = 'Goals Against Average'
		  SO = 'Shutouts'
		  MIN = 'Minutes'
		  G = 'Goals (that the player recorded, not opponents)'
		  A = 'Assists (that the player recorded, not opponents)'
		  PTS = 'Points (that the player recorded, not opponents)'
		  PIM = 'Penalties in Minutes';
run;

/*Part (b)*/
title3 Part(b);
data all_kefuzhu2;
	set final.skaters goalies_kefuzhu2 (rename = (Min = TOI) in = inG);
	if inG then Pos = 'G';
run;

/*Part (c)*/
title3 Part(c);
data hof_kefuzhu2;
	infile 'C:\440\final\hockey HOF.csv' dsd missover dlm = ',';
	input Player:$30. Year First Last GP1 G A PTS PM PIM GP2 W L TOL SV_PCT GAA;
	label Player = 'Player'
		  Year = 'Year that the Player was inducted into HOF'
		  First = 'First year of NHL career'
		  Last = 'Last year of NHL career'
     	  GP1 = 'Games Played as Skater'
		  G = 'Goals'
		  A = 'Assists'
		  PTS = 'Points'
	  	  PM = 'Plus/Minus'
	      PIM = 'Penalties in Minutes'
		  GP2 = 'Games Played as Goalie'
		  W = 'Wins'
		  L = 'Losses'
		  TOL = 'Ties/Overtime/Shootout Losses'
       	  SV_PCT = 'Save Percentage'
		  GAA = 'Goals Against Average';
run;

/*Part (d)*/
title3 Part(d);
proc sort data = all_kefuzhu2;
	by Player;
run;
proc sort data = hof_kefuzhu2;
	by Player;
run;
data NHLhof_kefuzhu2 otherhof_kefuzhu2;
	merge all_kefuzhu2 (in = inA) hof_kefuzhu2 (in = inH);
	if inA = 1 and inH = 1 then output NHLhof_kefuzhu2;
	if inA = 0 and inH = 1 then output otherhof_kefuzhu2;
	by Player;
run;

/*Part (e)*/
title3 Part(e);
title4 Descriptor Portion of NHLhof_kefuzhu2;
proc contents data = NHLhof_kefuzhu2;
	ods select Attributes;
run;
title4 Descriptor Portion of otherhof_kefuzhu2;
proc contents data = otherhof_kefuzhu2;
	ods select Attributes;
run;

/*Part (f)*/
title3 Part(f);
proc print data = NHLhof_kefuzhu2 noobs label;
	where SV > 15000 and Pos = 'G';
	var Player First Last GP SV SV_PCT;
run;

/*Part (g)*/
title3 Part(g);
proc print data = otherhof_kefuzhu2 noobs label;
	where SH > 30;
	var Player First Last GP G SH;
run;

/*Part (h)*/
title3 Part(h);
proc sql;
	create table NHLsql_kefuzhu2 as
	select coalesce(A.Player, H.Player) as Player,
		   coalesce(A.First, H.First) as First,
		   coalesce(A.Last, H.Last) as Last,
		   coalesce(A.G, H.G) as G,
		   coalesce(A.A, H.A) as A,
		   coalesce(A.PTS, H.PTS) as PTS,
		   coalesce(A.PM, H.PM) as PM,
		   coalesce(A.PIM, H.PIM) as PIM,
		   coalesce(A.W, H.W) as W,
		   coalesce(A.L, H.L) as L,
		   coalesce(A.TOL, H.TOL) as TOL,
		   coalesce(A.SV_PCT, H.SV_PCT) as SV_PCT,
		   coalesce(A.GAA, H.GAA) as GAA,
		   Year, Pos, GW, GP, EV, PP, SH, EVA, PPA, SHA, S, TOI, ATOI, GS, GA, SA, SV, SO, GP1, GP2, S_PCT
	from all_kefuzhu2 as A, hof_kefuzhu2 as H
	where A.Player = H.Player
	;
quit;
proc sql;
	select count(*) 'Number of rows in NHLsql'
	from NHLsql_kefuzhu2;
quit;
	

/*Part (i)*/
title3 Part(i);
proc sql;
	create table othersql_kefuzhu2 as
	select coalesce(A.Player, H.Player) as Player,
		   coalesce(A.First, H.First) as First,
		   coalesce(A.Last, H.Last) as Last,
		   coalesce(A.G, H.G) as G,
		   coalesce(A.A, H.A) as A,
		   coalesce(A.PTS, H.PTS) as PTS,
		   coalesce(A.PM, H.PM) as PM,
		   coalesce(A.PIM, H.PIM) as PIM,
		   coalesce(A.W, H.W) as W,
		   coalesce(A.L, H.L) as L,
		   coalesce(A.TOL, H.TOL) as TOL,
		   coalesce(A.SV_PCT, H.SV_PCT) as SV_PCT,
		   coalesce(A.GAA, H.GAA) as GAA,
		   Year, Pos, GW, GP, EV, PP, SH, EVA, PPA, SHA, S, TOI, ATOI, GS, GA, SA, SV, SO, GP1, GP2, S_PCT
	from all_kefuzhu2 as A 
		 right join
		 hof_kefuzhu2 as H
	on A.Player = H.Player

	where not exists
	(select *
		from all_kefuzhu2
	 	where all_kefuzhu2.Player = hof_kefuzhu2.Player)
	;
quit;
proc sql;
	select count(*) 'Number of rows in othersql'
	from othersql_kefuzhu2;
quit;

/*Part (j)*/
title3 Part(j);
proc sql;
	select Player, First, Last, GP, SV, SV_PCT
	from NHLsql_kefuzhu2
	where SV > 15000 and Pos = 'G'
	;
quit;

title;
footnote;
ods pdf close;
