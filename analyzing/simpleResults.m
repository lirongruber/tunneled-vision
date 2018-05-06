% simple results:

subNames={'SM', 'LS' ,'LB' , 'RW' , 'AS'};

B= 1:3;
S= 1:5;

chance=1/5+1/4;
SM_B=[30/30];
SM_S=[30/50];

LB_B=[27/30];
LB_S=[28/50];

LS_B=[29/30];
LS_S=[31/50];

RW_B=[30/30];
RW_S=[30/50];

AS_B=[25/30];
AS_S=[30/50];

B=[SM_B LB_B LS_B RW_B AS_B];
S=[SM_S LB_S LS_S RW_S AS_S];
meanB=mean(B)
stdB=std(B)
meanS=mean(S)
stdS=std(S)

