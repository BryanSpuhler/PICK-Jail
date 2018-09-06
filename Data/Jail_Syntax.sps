* Encoding: UTF-8.
GET
GET FILE="D:\Box Sync\Extension Research\Current Projects\Inmate Research\PICK_Jail.sav".


*Get the demographics of the sample

DESCRIPTIVES VARIABLES=Age TotalChildren Income 
  /STATISTICS=MEAN STDDEV MIN MAX.

FREQUENCIES VARIABLES=Gender Ethnicity RelationshipStatusA Education DivorcedYou Religious FinancialWorry RelationshipEducation 
  /STATISTICS=STDDEV MEAN MEDIAN 
  /ORDER=ANALYSIS.

*recode FreedomAndFlexibility to numerical values 

RECODE FreedomAndFlexibility (MISSING=SYSMIS) ('a'=1) ('A'=1) ('b'=2) ('B'=2) ('c'=3) ('C'=3) ('d'=4) ('D'=4) ('e'=5) ('E'=5) ('f'=6) ('F'=6) INTO FreeAndFlex_Coded. 
EXECUTE.

*recode OQ-10 items to reflect original scale

RECODE HappyPerson SatisfiedLife SatisfiedRelationship FeelLovedWanted RelationshipsFullComplete (SYSMIS=SYSMIS) (1=4) (2=3) (3=2) (4=1) (5=0). 
EXECUTE.


VALUE LABELS
HappyPerson
0 'Strongly Agree'
1 'Agree'
2 'Mixed'
3 'Disagree'
4 'Strongly Disagree'.
EXECUTE.
 

VALUE LABELS
SatisfiedLife
0 'Strongly Agree'
1 'Agree'
2 'Mixed'
3 'Disagree'
4 'Strongly Disagree'.
EXECUTE.


VALUE LABELS
SatisfiedRelationship
0 'Strongly Agree'
1 'Agree'
2 'Mixed'
3 'Disagree'
4 'Strongly Disagree'.
EXECUTE.


VALUE LABELS
FeelLovedWanted
0 'Strongly Agree'
1 'Agree'
2 'Mixed'
3 'Disagree'
4 'Strongly Disagree'.
EXECUTE.


VALUE LABELS
RelationshipsFullComplete
0 'Strongly Agree'
1 'Agree'
2 'Mixed'
3 'Disagree'
4 'Strongly Disagree'.
EXECUTE.

*Compute the pre and post scale scores for the derived factors.

COMPUTE WAI_Scale=Mean.3(AppreciatesMe, CaresLikesMe, Trustfacilitator).
EXECUTE.  
COMPUTE PWB_Scale=Mean.5(HappyPerson,SatisfiedLife,SatisfiedRelationship,FeelLovedWanted,RelationshipsFullComplete). 
EXECUTE.  
COMPUTE BL_Scale_T1=Mean.3(LoveSufficientMarriage_T1,LoveEnoughSustain_T1,FoolWalksAway_T1). 
EXECUTE.  
COMPUTE BL_Scale_T2=Mean.3(LoveSufficientMarriage_T2,LoveEnoughSustain_T2,FoolWalksAway_T2). 
EXECUTE.  
COMPUTE VF_Scale_T1=Mean.3(PaceRelationshipSafe,SpotWarningSigns,WeighProsCons). 
EXECUTE.  
COMPUTE VF_Scale_T2=Mean.3(PaceRelationshipSafe_After,SpotWarningSigns_After,WeighProsCons_After). 
EXECUTE.  
COMPUTE VF_Scale_Before=Mean.3(PaceRelationshipSafe_Before,SpotWarningSigns_Before,WeighProsCons_Before). 
EXECUTE. 
COMPUTE Control_Scale_T1=Mean.3(KeepPartnerDoing_T1,ForbidPartnerTalking_T1,WouldNotStay_T1). 
EXECUTE.  
COMPUTE Control_Scale_T2=Mean.3(KeepPartnerDoing_T2,ForbidPartnerTalking_T2,WouldNotStay_T2). 
EXECUTE.  

COMPUTE PWB_Summed=SUM.5(HappyPerson,SatisfiedLife,SatisfiedRelationship,FeelLovedWanted,RelationshipsFullComplete). 
EXECUTE.

*Chreate a dichotomous cut off point for the OQ10 items.
RECODE PWB_Summed (SYSMIS=SYSMIS) (0 thru 8=0) (9 thru 20=1) INTO PWB_Dich. 
EXECUTE.

VALUE LABELS
PWD_Dich
0 'Not-Distressed'
1 'Distressed'.
EXECUTE.

*Create a series of groups for the OQ10 items.
RECODE PWB_Summed (SYSMIS=SYSMIS) (Lowest thru 4=1) (5 thru 8=2) (9 thru 14=3) (15 thru 20=4) INTO PWB_Groups. 
EXECUTE.

RECODE PWB_Summed (SYSMIS=SYSMIS) (Lowest thru 5=1) (6 thru 14=2) (15 thru 20=3) INTO PWB_Groups2. 
EXECUTE.

*recode variables into groups before running Anovas

RECODE Age (SYSMIS=SYSMIS) (18 thru 30=1) (31 thru 40=2) (41 thru 50=3) (51 thru Highest=4) INTO Age_Groups. 
EXECUTE.

RECODE Ethnicity (SYSMIS=SYSMIS) (1=1) (ELSE=2) INTO Ethnicity_Dich. 
EXECUTE.

RECODE Education (SYSMIS=SYSMIS) (3=2) (1 thru 2=1) (4 thru 6=3) INTO Ed_Recoded. 
EXECUTE.

RECODE FinancialWorry (SYSMIS=SYSMIS) (3=2) (1 thru 2=1) (4 thru 5=3) INTO FinWorry_Recoded. 
EXECUTE.


VALUE LABELS
Age_Groups
1 '18-30'
2 '31-40'
3 '41-50'
4 '51+'.
EXECUTE.
 

VALUE LABELS
Ethnicity_Dich
1 'Caucasian'
2 'Else'.
EXECUTE.


VALUE LABELS
Ed_Recoded
1 'Less than HS'
2 'HS or GED'
3 'Some College or more'.
EXECUTE.


VALUE LABELS
FinWorry_Recoded
1 'Never/Hardly  Ever'
2 'Once In A While'
3 'Often/ Almost All the Time'.
EXECUTE.


*Compute pre to post difference scores

COMPUTE BL_Diff=(BL_Scale_T2 - BL_Scale_T1). 
EXECUTE.

COMPUTE VF_Diff=(VF_Scale_T2 - VF_Scale_T1). 
EXECUTE. 

COMPUTE Control_Diff=(Control_Scale_T2 - Control_Scale_T1). 
EXECUTE.


*Create Married_Dich variable and look for differences between married and "else" participants.

RECODE RelationshipStatusB (SYSMIS=SYSMIS) (1=1) (ELSE=2) INTO Married_Dich. 
EXECUTE.

VALUE LABELS
Married_Dich
1 'Married'
2 'Else'.
EXECUTE.

* This is what constitutes the file "PICK_Jail_Recoded.sav" in the PICK_Jail_R -> Data folder


DELETE VARIABLES
COID
Grant
Language
Modality
Curriculum
TotalHoursPossible
Days
Weeks
AgencyNumber
EthnicityOther
LiveWithOther
MostImportantGained
LikedMost
LikedLeast
BiggestConcern_T1
BiggestConcern_T2.


* This is what constitutes the file "PICK_Jail_Trimmed.sav" in the PICK_Jail_R -> Data folder



T-TEST GROUPS=Married_Dich(1 2) 
  /MISSING=ANALYSIS 
  /VARIABLES=WAI_Scale FreeAndFlex_Coded PWB_Summed BL_Scale_T1 BL_Scale_T2 BL_Diff VF_Scale_T1 
    VF_Scale_T2 VF_Diff Control_Scale_T1 Control_Scale_T2 Control_Diff 
  /CRITERIA=CI(.95).

*Look for significant differences from pre to post for each scale.

T-TEST PAIRS=BL_Scale_T1 VF_Scale_T1 Control_Scale_T1 WITH BL_Scale_T2 VF_Scale_T2 Control_Scale_T2 (PAIRED) 
  /CRITERIA=CI(.9500) 
  /MISSING=ANALYSIS.


*This is the initial factor analysis using the PICK measures which did not factor well. Skip down to the factor analysis where thes items have been removed. 

FACTOR
/VARIABLES= TimeTogethernessTalk_T1 LoveEmotionalRational_T1
IdentifyImportantThings_T1 PatternsRepeat_T1 FamilyExperienceImpact_T1
HappyPerson SatisfiedLife SatisfiedRelationship FeelLovedWanted
RelationshipsFullComplete LoveSufficientMarriage_T1 LoveEnoughSustain_T1
FoolWalksAway_T1 PaceRelationshipSafe SpotWarningSigns WeighProsCons
KeepPartnerDoing_T1 ForbidPartnerTalking_T1 WouldNotStay_T1
/CRITERIA = MINEIGEN (1) ITERATE (25)
/EXTRACTION =PC
/METHOD = CORRELATION
/PLOT = EIGEN
/PRINT = INITIAL EXTRACTION ROTATION
/CRITERIA = ITERATE (25)
/ROTATION = VARIMAX.


RELIABILITY
/VARIABLES= TimeTogethernessTalk_T1 LoveEmotionalRational_T1
/MODEL=ALPHA
/SUMMARY = TOTAL.

RELIABILITY
/VARIABLES= PatternsRepeat_T1 FamilyExperienceImpact_T1
/MODEL=ALPHA
/SUMMARY = TOTAL.

RELIABILITY
/VARIABLES= HappyPerson SatisfiedLife SatisfiedRelationship
FeelLovedWanted RelationshipsFullComplete
/MODEL=ALPHA
/SUMMARY = TOTAL.

RELIABILITY
/VARIABLES= LoveSufficientMarriage_T1 LoveEnoughSustain_T1
FoolWalksAway_T1
/MODEL=ALPHA
/SUMMARY = TOTAL.

RELIABILITY
/VARIABLES= PaceRelationshipSafe SpotWarningSigns WeighProsCons IdentifyImportantThings_T1
 /SCALE('ALL VARIABLES') ALL
/MODEL=ALPHA
/SUMMARY = TOTAL.

RELIABILITY
/VARIABLES= KeepPartnerDoing_T1 ForbidPartnerTalking_T1
WouldNotStay_T1
/MODEL=ALPHA
/SUMMARY = TOTAL.

FACTOR
/VARIABLES= TimeTogethernessTalk_T2 LoveEmotionalRational_T2
IdentifyImportantThings_T2 PatternsRepeat_T2 FamilyExperienceImpact_T2
LoveSufficientMarriage_T2 LoveEnoughSustain_T2 FoolWalksAway_T2
PaceRelationshipSafe_After SpotWarningSigns_After WeighProsCons_After
KeepPartnerDoing_T2 ForbidPartnerTalking_T2 WouldNotStay_T2
/CRITERIA = MINEIGEN (1) ITERATE (25)
/EXTRACTION =PC
/METHOD = CORRELATION
/PLOT = EIGEN
/PRINT = INITIAL EXTRACTION ROTATION
/CRITERIA = ITERATE (25)
/ROTATION = VARIMAX.

RELIABILITY
/VARIABLES= TimeTogethernessTalk_T2 LoveEmotionalRational_T2
/MODEL=ALPHA
/SUMMARY = TOTAL.

RELIABILITY
/VARIABLES= PatternsRepeat_T2 FamilyExperienceImpact_T2
/MODEL=ALPHA
/SUMMARY = TOTAL.

RELIABILITY
/VARIABLES= LoveSufficientMarriage_T2 LoveEnoughSustain_T2
FoolWalksAway_T2
/MODEL=ALPHA
/SUMMARY = TOTAL.

RELIABILITY
/VARIABLES= PaceRelationshipSafe_After SpotWarningSigns_After
WeighProsCons_After IdentifyImportantThings_T2
/MODEL=ALPHA
/SUMMARY = TOTAL.

RELIABILITY
/VARIABLES= KeepPartnerDoing_T2 ForbidPartnerTalking_T2
WouldNotStay_T2
/MODEL=ALPHA
/SUMMARY = TOTAL.

*after removing first five variables

FACTOR
/VARIABLES= HappyPerson SatisfiedLife SatisfiedRelationship FeelLovedWanted
RelationshipsFullComplete LoveSufficientMarriage_T1 LoveEnoughSustain_T1
FoolWalksAway_T1 PaceRelationshipSafe SpotWarningSigns WeighProsCons
KeepPartnerDoing_T1 ForbidPartnerTalking_T1 WouldNotStay_T1
/CRITERIA = MINEIGEN (1) ITERATE (25)
/EXTRACTION =PC
/METHOD = CORRELATION
/PLOT = EIGEN
/PRINT = INITIAL EXTRACTION ROTATION
/CRITERIA = ITERATE (25)
/ROTATION = VARIMAX.

*Factor for Retro-Pre instead of True-Pre.
FACTOR
/VARIABLES= HappyPerson SatisfiedLife SatisfiedRelationship FeelLovedWanted
RelationshipsFullComplete LoveSufficientMarriage_T1 LoveEnoughSustain_T1
FoolWalksAway_T1 PaceRelationshipSafe_Before SpotWarningSigns_Before WeighProsCons_Before
KeepPartnerDoing_T1 ForbidPartnerTalking_T1 WouldNotStay_T1
/CRITERIA = MINEIGEN (1) ITERATE (25)
/EXTRACTION =PC
/METHOD = CORRELATION
/PLOT = EIGEN
/PRINT = INITIAL EXTRACTION ROTATION
/CRITERIA = ITERATE (25)
/ROTATION = VARIMAX.

RELIABILITY
/VARIABLES= HappyPerson SatisfiedLife SatisfiedRelationship
FeelLovedWanted RelationshipsFullComplete
 /SCALE('ALL VARIABLES') ALL
/MODEL=ALPHA
/SUMMARY = TOTAL.

RELIABILITY
/VARIABLES= LoveSufficientMarriage_T1 LoveEnoughSustain_T1
FoolWalksAway_T1
 /SCALE('ALL VARIABLES') ALL
/MODEL=ALPHA
/SUMMARY = TOTAL.

RELIABILITY
/VARIABLES= PaceRelationshipSafe SpotWarningSigns WeighProsCons
 /SCALE('ALL VARIABLES') ALL
/MODEL=ALPHA
/SUMMARY = TOTAL.

RELIABILITY
/VARIABLES= KeepPartnerDoing_T1 ForbidPartnerTalking_T1
WouldNotStay_T1
 /SCALE('ALL VARIABLES') ALL
/MODEL=ALPHA
/SUMMARY = TOTAL.

*Calculate alpha for the Retro-Pre VF items.
RELIABILITY
/VARIABLES= PaceRelationshipSafe_Before SpotWarningSigns_Before WeighProsCons_Before
 /SCALE('ALL VARIABLES') ALL
/MODEL=ALPHA
/SUMMARY = TOTAL.

FACTOR
/VARIABLES= LoveSufficientMarriage_T2 LoveEnoughSustain_T2 FoolWalksAway_T2
PaceRelationshipSafe_After SpotWarningSigns_After WeighProsCons_After
KeepPartnerDoing_T2 ForbidPartnerTalking_T2 WouldNotStay_T2
/CRITERIA = MINEIGEN (1) ITERATE (25)
/EXTRACTION =PC
/METHOD = CORRELATION
/PLOT = EIGEN
/PRINT = INITIAL EXTRACTION ROTATION
/CRITERIA = ITERATE (25)
/ROTATION = VARIMAX.

RELIABILITY
/VARIABLES= LoveSufficientMarriage_T2 LoveEnoughSustain_T2
FoolWalksAway_T2
 /SCALE('ALL VARIABLES') ALL
/MODEL=ALPHA
/SUMMARY = TOTAL.

RELIABILITY
/VARIABLES= PaceRelationshipSafe_After SpotWarningSigns_After
WeighProsCons_After
 /SCALE('ALL VARIABLES') ALL
/MODEL=ALPHA
/SUMMARY = TOTAL.

RELIABILITY
/VARIABLES= KeepPartnerDoing_T2 ForbidPartnerTalking_T2
WouldNotStay_T2
 /SCALE('ALL VARIABLES') ALL
/MODEL=ALPHA
/SUMMARY = TOTAL.


*Working Alliance Inventory alpha's

RELIABILITY
/VARIABLES= AppreciatesMe CaresLikesMe
Trustfacilitator
 /SCALE('ALL VARIABLES') ALL
/MODEL=ALPHA
/SUMMARY = TOTAL.


*Check for covariance between PWB and demographic variables.
*We will need to first decide which use of PWB (dichotomous or continuous)


ONEWAY PWB_Summed BY Gender 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=SCHEFFE ALPHA(0.05).

ONEWAY PWB_Dich BY Gender 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=SCHEFFE ALPHA(0.05).

UNIANOVA PWB_Summed BY Age_Groups 
  /METHOD=SSTYPE(3) 
  /INTERCEPT=INCLUDE 
  /POSTHOC=Age_Groups(SCHEFFE) 
  /EMMEANS=TABLES(Age_Groups) 
  /PRINT=OPOWER ETASQ HOMOGENEITY DESCRIPTIVE 
  /CRITERIA=ALPHA(.05) 
  /DESIGN=Age_Groups.

UNIANOVA PWB_Dich BY Age_Groups 
  /METHOD=SSTYPE(3) 
  /INTERCEPT=INCLUDE 
  /POSTHOC=Age_Groups(SCHEFFE) 
  /EMMEANS=TABLES(Age_Groups) 
  /PRINT=OPOWER ETASQ HOMOGENEITY DESCRIPTIVE 
  /CRITERIA=ALPHA(.05) 
  /DESIGN=Age_Groups.

UNIANOVA PWB_Summed BY Ed_Recoded 
  /METHOD=SSTYPE(3) 
  /INTERCEPT=INCLUDE 
  /POSTHOC=Ed_Recoded(SCHEFFE) 
  /EMMEANS=TABLES(Ed_Recoded) 
  /PRINT=OPOWER ETASQ HOMOGENEITY DESCRIPTIVE 
  /CRITERIA=ALPHA(.05) 
  /DESIGN=Ed_Recoded.

UNIANOVA PWB_Dich BY Ed_Recoded 
  /METHOD=SSTYPE(3) 
  /INTERCEPT=INCLUDE 
  /POSTHOC=Ed_Recoded(SCHEFFE) 
  /EMMEANS=TABLES(Ed_Recoded) 
  /PRINT=OPOWER ETASQ HOMOGENEITY DESCRIPTIVE 
  /CRITERIA=ALPHA(.05) 
  /DESIGN=Ed_Recoded.

UNIANOVA PWB_Summed BY Ethnicity_Recoded 
  /METHOD=SSTYPE(3) 
  /INTERCEPT=INCLUDE 
  /POSTHOC=Ethnicity_Recoded(SCHEFFE) 
  /EMMEANS=TABLES(Ethnicity_Recoded) 
  /PRINT=OPOWER ETASQ HOMOGENEITY DESCRIPTIVE 
  /CRITERIA=ALPHA(.05) 
  /DESIGN=Ethnicity_Recoded.

UNIANOVA PWB_Dich BY Ethnicity_Recoded 
  /METHOD=SSTYPE(3) 
  /INTERCEPT=INCLUDE 
  /POSTHOC=Ethnicity_Recoded(SCHEFFE) 
  /EMMEANS=TABLES(Ethnicity_Recoded) 
  /PRINT=OPOWER ETASQ HOMOGENEITY DESCRIPTIVE 
  /CRITERIA=ALPHA(.05) 
  /DESIGN=Ethnicity_Recoded.

UNIANOVA PWB_Summed BY Div_Dich 
  /METHOD=SSTYPE(3) 
  /INTERCEPT=INCLUDE 
  /POSTHOC=Div_Dich(SCHEFFE) 
  /EMMEANS=TABLES(Div_Dich) 
  /PRINT=OPOWER ETASQ HOMOGENEITY DESCRIPTIVE 
  /CRITERIA=ALPHA(.05) 
  /DESIGN=Div_Dich.

UNIANOVA PWB_Dich BY Div_Dich 
  /METHOD=SSTYPE(3) 
  /INTERCEPT=INCLUDE 
  /POSTHOC=Div_Dich(SCHEFFE) 
  /EMMEANS=TABLES(Div_Dich) 
  /PRINT=OPOWER ETASQ HOMOGENEITY DESCRIPTIVE 
  /CRITERIA=ALPHA(.05) 
  /DESIGN=Div_Dich.

UNIANOVA PWB_Summed BY FinWorry_Recoded 
  /METHOD=SSTYPE(3) 
  /INTERCEPT=INCLUDE 
  /POSTHOC=FinWorry_Recoded(SCHEFFE) 
  /EMMEANS=TABLES(FinWorry_Recoded) 
  /PRINT=OPOWER ETASQ HOMOGENEITY DESCRIPTIVE 
  /CRITERIA=ALPHA(.05) 
  /DESIGN=FinWorry_Recoded.

UNIANOVA PWB_Dich BY FinWorry_Recoded 
  /METHOD=SSTYPE(3) 
  /INTERCEPT=INCLUDE 
  /POSTHOC=FinWorry_Recoded(SCHEFFE) 
  /EMMEANS=TABLES(FinWorry_Recoded) 
  /PRINT=OPOWER ETASQ HOMOGENEITY DESCRIPTIVE 
  /CRITERIA=ALPHA(.05) 
  /DESIGN=FinWorry_Recoded.

UNIANOVA PWB_Summed BY RelationshipEducation 
  /METHOD=SSTYPE(3) 
  /INTERCEPT=INCLUDE 
  /POSTHOC=RelationshipEducation(SCHEFFE) 
  /EMMEANS=TABLES(RelationshipEducation) 
  /PRINT=OPOWER ETASQ HOMOGENEITY DESCRIPTIVE 
  /CRITERIA=ALPHA(.05) 
  /DESIGN=RelationshipEducation.

UNIANOVA PWB_Summed BY Religious 
  /METHOD=SSTYPE(3) 
  /INTERCEPT=INCLUDE 
  /POSTHOC=Religious(SCHEFFE) 
  /EMMEANS=TABLES(Religious) 
  /PRINT=OPOWER ETASQ HOMOGENEITY DESCRIPTIVE 
  /CRITERIA=ALPHA(.05) 
  /DESIGN=Religious.

UNIANOVA PWB_Dich BY RelationshipEducation 
  /METHOD=SSTYPE(3) 
  /INTERCEPT=INCLUDE 
  /POSTHOC=RelationshipEducation(SCHEFFE) 
  /EMMEANS=TABLES(RelationshipEducation) 
  /PRINT=OPOWER ETASQ HOMOGENEITY DESCRIPTIVE 
  /CRITERIA=ALPHA(.05) 
  /DESIGN=RelationshipEducation.

*Check for covariance between BL, VF, and Control factor scores and demographic variables.

ONEWAY BL_Diff VF_Diff Control_Diff BY WAI_Scale 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Scale_T1 BL_Scale_T2 VF_Scale_T1 VF_Scale_T2 Control_Scale_T1 Control_Scale_T2 BY WAI_Scale 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Diff VF_Diff Control_Diff BY Age_Groups 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Scale_T1 BL_Scale_T2 VF_Scale_T1 VF_Scale_T2 Control_Scale_T1 Control_Scale_T2 BY Age_Groups 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Diff VF_Diff Control_Diff BY Gender 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Scale_T1 BL_Scale_T2 VF_Scale_T1 VF_Scale_T2 Control_Scale_T1 Control_Scale_T2 BY Gender 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Diff VF_Diff Control_Diff BY Ethnicity_Recoded 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Scale_T1 BL_Scale_T2 VF_Scale_T1 VF_Scale_T2 Control_Scale_T1 Control_Scale_T2 BY Ethnicity_Recoded 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Diff VF_Diff Control_Diff BY Ed_Recoded 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Scale_T1 BL_Scale_T2 VF_Scale_T1 VF_Scale_T2 Control_Scale_T1 Control_Scale_T2 BY Ed_Recoded 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Diff VF_Diff Control_Diff BY Div_Dich 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Scale_T1 BL_Scale_T2 VF_Scale_T1 VF_Scale_T2 Control_Scale_T1 Control_Scale_T2 BY Div_Dich 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Diff VF_Diff Control_Diff BY Religious 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Scale_T1 BL_Scale_T2 VF_Scale_T1 VF_Scale_T2 Control_Scale_T1 Control_Scale_T2 BY Religious 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Diff VF_Diff Control_Diff BY FinWorry_Recoded 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Scale_T1 BL_Scale_T2 VF_Scale_T1 VF_Scale_T2 Control_Scale_T1 Control_Scale_T2 BY FinWorry_Recoded 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Diff VF_Diff Control_Diff BY RelationshipEducation 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Scale_T1 BL_Scale_T2 VF_Scale_T1 VF_Scale_T2 Control_Scale_T1 Control_Scale_T2 BY RelationshipEducation 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Diff VF_Diff Control_Diff BY PWB_Summed 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Scale_T1 BL_Scale_T2 VF_Scale_T1 VF_Scale_T2 Control_Scale_T1 Control_Scale_T2 BY PWB_Summed 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Diff VF_Diff Control_Diff BY PWB_Dich 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Scale_T1 BL_Scale_T2 VF_Scale_T1 VF_Scale_T2 Control_Scale_T1 Control_Scale_T2 BY PWB_Dich 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Diff VF_Diff Control_Diff BY PWB_Groups 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Scale_T1 BL_Scale_T2 VF_Scale_T1 VF_Scale_T2 Control_Scale_T1 Control_Scale_T2 BY PWB_Groups 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Diff VF_Diff Control_Diff BY PWB_Groups2 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).

ONEWAY BL_Scale_T1 BL_Scale_T2 VF_Scale_T1 VF_Scale_T2 Control_Scale_T1 Control_Scale_T2 BY PWB_Groups2 
  /STATISTICS DESCRIPTIVES 
  /PLOT MEANS 
  /MISSING ANALYSIS 
  /POSTHOC=TUKEY ALPHA(0.05).
