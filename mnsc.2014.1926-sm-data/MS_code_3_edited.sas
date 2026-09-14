
libname xxx 'C:YYY';

%LET start_year = 1993;
%LET end_year = 2008;

%LET dependent = investment;
%LET independent =  cash_flow ME_BE_lag1 log_AT_lag1 book_leverage investment_lag1 firm_age
					Single
					age age_Single tenure tenure_Single
					CEO_prominence firm_prominence
					held_pct held_pct_Single
					year_93 year_94 year_95 year_96 year_97 year_98 year_99 year_00 year_01 year_02 year_03 year_04 year_05 year_06 year_07
					FF_1 FF_2 FF_3 FF_4 FF_5 FF_6 FF_7 FF_8 FF_9 FF_10 FF_11
					FF_12 FF_13 FF_14 FF_15 FF_16 FF_17 FF_18 FF_19 FF_20
					FF_21 FF_22 FF_23 FF_24 FF_25 FF_26 FF_27 FF_28 FF_29 FF_30
					FF_31 FF_32 FF_33 FF_34 FF_35 FF_36 FF_37 FF_38 FF_39 FF_40
					FF_41 FF_42 FF_43 FF_44 FF_45 FF_46 FF_47 FF_48;

%LET dependent_ID = investment;
%LET independent_ID = cash_flow ME_BE_lag1 log_AT_lag1 book_leverage investment_lag1 firm_age
					  Single
					  age age_Single tenure tenure_Single
					  CEO_prominence firm_prominence
					  held_pct held_pct_Single
					  year_94 year_95 year_96 year_97 year_98 year_99 year_00 year_01 year_02 year_03 year_04 year_05 year_06 year_07
					  FF_1 FF_2 FF_3 FF_4 FF_5 FF_6 FF_7 FF_8 FF_9 FF_10 FF_11
					  FF_12 FF_13 FF_14 FF_15 FF_16 FF_17 FF_18 FF_19 FF_20
					  FF_21 FF_22 FF_23 FF_24 FF_25 FF_26 FF_27 FF_28 FF_29 FF_30
					  FF_31 FF_32 FF_33 FF_34 FF_35 FF_36 FF_37 FF_38 FF_39 FF_40
					  FF_41 FF_42 FF_43 FF_44 FF_45 FF_46 FF_47 FF_48;


DATA all;
SET XXX.MS_data1;
m=1;
held_pct_Single=held_pct*Single;


/*  Winsorize ratio variables - Petersen RFS 2009 does this. */
PROC SORT DATA=all;
BY m Single;

PROC MEANS DATA=all NOPRINT;
BY m Single;
VAR investment cash_flow ME_BE_lag1 book_leverage vol;
OUTPUT OUT=trim P1(investment cash_flow ME_BE_lag1 book_leverage vol investment_lag1 vol_lag1 payout payout_lag1 book_leverage_lag1 
				   CapEx R_and_D1 advertising1 net_acq CapEx_lag1 R_and_D1_lag1 advertising1_lag1 net_acq_lag1)=
				   investment_p1 cash_flow_p1 ME_BE_lag1_p1 book_leverage_p1 vol_p1 investment_lag1_p1 vol_lag1_p1 payout_p1 payout_lag1_p1 book_leverage_lag1_p1 
				   CapEx_p1 R_and_D1_p1 advertising1_p1 net_acq_p1 CapEx_lag1_p1 R_and_D1_lag1_p1 advertising1_lag1_p1 net_acq_lag1_p1
			    P99(investment cash_flow ME_BE_lag1 book_leverage vol investment_lag1 vol_lag1 payout payout_lag1 book_leverage_lag1
					CapEx R_and_D1 advertising1 net_acq CapEx_lag1 R_and_D1_lag1 advertising1_lag1 net_acq_lag1)=
					investment_p99 cash_flow_p99 ME_BE_lag1_p99 book_leverage_p99 vol_p99 investment_lag1_p99 vol_lag1_p99 payout_p99 payout_lag1_p99 book_leverage_lag1_p99
					CapEx_p99 R_and_D1_p99 advertising1_p99 net_acq_p99 CapEx_lag1_p99 R_and_D1_lag1_p99 advertising1_lag1_p99 net_acq_lag1_p99;

DATA all;
MERGE all (IN=V1) trim;
BY m Single;
IF cash_flow<cash_flow_p1 THEN cash_flow=cash_flow_p1;
IF cash_flow>cash_flow_p99 THEN cash_flow=cash_flow_p99;
IF investment<investment_p1 THEN investment=investment_p1;
IF investment>investment_p99 THEN investment=investment_p99;
IF investment_lag1<investment_lag1_p1 THEN investment_lag1=investment_lag1_p1;
IF investment_lag1>investment_lag1_p99 THEN investment_lag1=investment_lag1_p99;
IF ME_BE_lag1<ME_BE_lag1_p1 THEN ME_BE_lag1=ME_BE_lag1_p1;
IF ME_BE_lag1>ME_BE_lag1_p99 THEN ME_BE_lag1=ME_BE_lag1_p99;
IF book_leverage<book_leverage_p1 THEN book_leverage=book_leverage_p1;
IF book_leverage>book_leverage_p99 THEN book_leverage=book_leverage_p99;
IF book_leverage_lag1<book_leverage_lag1_p1 THEN book_leverage_lag1=book_leverage_lag1_p1;
IF book_leverage_lag1>book_leverage_lag1_p99 THEN book_leverage_lag1=book_leverage_lag1_p99;
IF CapEx<CapEx_p1 THEN CapEx=CapEx_p1;
IF CapEx>CapEx_p99 THEN CapEx=CapEx_p99;
IF CapEx_lag1<CapEx_lag1_p1 THEN CapEx_lag1=CapEx_lag1_p1;
IF CapEx_lag1>CapEx_lag1_p99 THEN CapEx_lag1=CapEx_lag1_p99;
IF R_and_D1<R_and_D1_p1 THEN R_and_D1=R_and_D1_p1;
IF R_and_D1>R_and_D1_p99 THEN R_and_D1=R_and_D1_p99;
IF R_and_D1_lag1<R_and_D1_lag1_p1 THEN R_and_D1_lag1=R_and_D1_lag1_p1;
IF R_and_D1_lag1>R_and_D1_lag1_p99 THEN R_and_D1_lag1=R_and_D1_lag1_p99;
IF advertising1<advertising1_p1 THEN advertising1=advertising1_p1;
IF advertising1>advertising1_p99 THEN advertising1=advertising1_p99;
IF advertising1_lag1<advertising1_lag1_p1 THEN advertising1_lag1=advertising1_lag1_p1;
IF advertising1_lag1>advertising1_lag1_p99 THEN advertising1_lag1=advertising1_lag1_p99;
IF net_acq<net_acq_p1 THEN net_acq=net_acq_p1;
IF net_acq>net_acq_p99 THEN net_acq=net_acq_p99;
IF net_acq_lag1<net_acq_lag1_p1 THEN net_acq_lag1=net_acq_lag1_p1;
IF net_acq_lag1>net_acq_lag1_p99 THEN net_acq_lag1=net_acq_lag1_p99;
IF payout<payout_p1 THEN payout=payout_p1;
IF payout>payout_p99 THEN payout=payout_p99;
IF payout_lag1<payout_lag1_p1 THEN payout_lag1=payout_lag1_p1;
IF payout_lag1>payout_lag1_p99 THEN payout_lag1=payout_lag1_p99;


/* Get year-industry fixed effects dummy variables. */
DATA all;
SET all;
year_ind=year*100+FF_Ind;

DATA all1;
SET all;

PROC SORT DATA=all1 NODUPKEY;
BY year_ind;

DATA all1;
SET all1;
ID1=_N_;
KEEP year_ind ID1;

PROC SORT DATA=all;
BY year_ind;

DATA all;
MERGE all (IN=V1) all1;
BY year_ind;
IF V1;

DATA all;
SET all;
ARRAY dummys {*} ID1_1 - ID1_769;
DO i=1 TO 769;			      
    dummys(i) = 0;
END;
dummys(ID1) = 1;


/* Get demeaned interaction terms. */
PROC MEANS MEAN MEDIAN MIN MAX N DATA=all NOPRINT;
BY m;
VAR log_AT_lag1 ME_BE_lag1 cash_flow book_leverage 
	Investment CapEx R_and_D1 advertising1 net_acq 
	vol id_vol firm_age
	age tenure CEO_tot_hold_lag1 CEO_prominence Firm_prominence held_pct;
ods output Summary=Parms;
OUTPUT OUT=Means MEAN(log_AT_lag1 ME_BE_lag1 cash_flow book_leverage 
					  Investment CapEx R_and_D1 advertising1 net_acq 
					  vol id_vol id_vol_lag1 firm_age
					  age tenure CEO_tot_hold_lag1 CEO_prominence Firm_prominence held_pct GDP log_GDP) =
					  log_AT_lag1_mean ME_BE_lag1_mean cash_flow_mean book_leverage_mean 
					  Investment_mean CapEx_mean R_and_D1_mean advertising1_mean net_acq_mean 
					  vol_mean id_vol_mean id_vol_lag1_mean firm_age_mean
					  age_mean tenure_mean CEO_tot_hold_lag1_mean CEO_prominence_mean Firm_prominence_mean held_pct_mean GDP_mean log_GDP_mean;

DATA all;
MERGE all (IN=V1) Means;
BY m;
IF held_pct=. THEN held_pct=held_pct_mean;
age_Single=(age-age_mean)*Single;
tenure_Single =(tenure-tenure_mean)*Single;
held_pct_Single=(held_pct-held_pct_mean)*Single;


/* Get investment and id_vol as of previous CEOs. */
PROC SORT DATA=all;
BY gvkey CEO_ID year;

DATA alls;
SET all (KEEP=gvkey CEO_ID investment_lag1 id_vol_lag1);
BY gvkey CEO_ID;
IF first.CEO_ID;

DATA alls;
SET alls;
RENAME investment_lag1=investment_previous id_vol_lag1=id_vol_previous;

PROC SORT DATA=alls NODUPKEY;
BY gvkey CEO_ID;

DATA all;
MERGE all (IN=V1) alls;
BY gvkey CEO_ID;
IF V1;


/* Main reg. */
PROC REG DATA=all;
MODEL &dependent = &independent / EDF;
ods output FitStatistics=Fit;

PROC SURVEYREG DATA=all;
CLUSTER gvkey;
class gvkey;
MODEL &dependent = &independent / solution;
  ods output ParameterEstimates=Parms;


/* Idiosyncratic vol on investment reg. */
DATA all1;
SET all;
inter=Single*(id_vol_lag1-id_vol_lag1_mean);

proc glm DATA=all1;
 absorb gvkey;
 model investment = &independent_ID id_vol_lag1 inter / solution noint;


RUN;
