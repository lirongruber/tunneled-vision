% CORRELATIONS

function [corrMatrix]=corrSMS(SMA,SMV,DMA,DMV,SSS,SSD,DSS,DSD)

% SMA=SM_value(1,:)'; % saccase motor amplitude
% SMV=SM_value(2,:)'; % saccade motor velocity
% DMA=SM_value(3,:)'; % drift motor amplitude
% DMV=SM_value(4,:)'; % drift motor velocity
% SSS=SM_value(5,:)'; % saccade senosory sum
% SSD=SM_value(6,:)'; % saccade senosory dif
% DSS=SM_value(7,:)'; % drift senosory sum
% DSD=SM_value(8,:)'; % drift senosory dif

moved_SMA=[ nan ; SMA];
moved_SMV=[ nan ; SMV];
moved_DSD=[ DSD ; nan ];
moved_DSS=[ DSS ;nan ];

[saccadeAmp_saccadeSum,PVAL1]=corr(SMA(SSS~=0),SSS(SSS~=0),'type','Spearman');
[saccadeVel_saccadeSum,PVAL2]=corr(SMV(SSS~=0),SSS(SSS~=0),'type','Spearman');
[fixationAmp_fixationSum,PVAL3]=corr(DMA(DSS~=0),DSS(DSS~=0),'type','Spearman');
[fixationVel_fixationSum,PVAL4]=corr(DMV(DSS~=0),DSS(DSS~=0),'type','Spearman');

[saccadeAmp_saccadeDif,PVAL5]=corr(SMA(SSD~=0),SSD(SSD~=0),'type','Spearman');
[saccadeVel_saccadeDif,PVAL6]=corr(SMV(SSD~=0),SSD(SSD~=0),'type','Spearman');
[fixationAmp_fixationDif,PVAL7]=corr(DMA(DSD~=0),DSD(DSD~=0),'type','Spearman');
[fixationVel_fixationDif,PVAL8]=corr(DMV(DSD~=0),DSD(DSD~=0),'type','Spearman');

[saccadeAmp_fixationSum,PVAL9]=corr(SMA(DSS~=0),DSS(DSS~=0),'type','Spearman');
[saccadeAmp_fixationDif,PVAL10]=corr(SMA(DSD~=0),DSD(DSD~=0),'type','Spearman');
[saccadeVel_fixationSum,PVAL11]=corr(SMV(DSS~=0),DSS(DSS~=0),'type','Spearman');
[saccadeVel_fixationDif,PVAL12]=corr(SMV(DSD~=0),DSD(DSD~=0),'type','Spearman');

[fixationAmp_saccadeSum,PVAL13]=corr(DMA(SSS~=0),SSS(SSS~=0),'type','Spearman');
[fixationAmp_saccadeDif,PVAL14]=corr(DMA(SSD~=0),SSD(SSD~=0),'type','Spearman');
[fixationVel_saccadeSum,PVAL15]=corr(DMV(SSS~=0),SSS(SSS~=0),'type','Spearman');
[fixationVel_saccadeDif,PVAL16]=corr(DMV(SSD~=0),SSD(SSD~=0),'type','Spearman');

[saccadeAmp_nextfixationSum,PVAL17]=corr(moved_SMA(moved_DSS~=0),moved_DSS(moved_DSS~=0), 'rows','complete','type','Spearman');
[saccadeAmp_nextfixationDif,PVAL18]=corr(moved_SMA(moved_DSD~=0),moved_DSD(moved_DSD~=0),'rows','complete','type','Spearman');
[saccadeVel_nextfixationSum,PVAL19]=corr(moved_SMV(moved_DSS~=0),moved_DSS(moved_DSS~=0),'rows','complete','type','Spearman');
[saccadeVel_nextfixationDif,PVAL20]=corr(moved_SMV(moved_DSD~=0),moved_DSD(moved_DSD~=0),'rows','complete','type','Spearman');



corrMatrix{2,1}=saccadeAmp_saccadeSum; corrMatrix{1,1}='saccadeAmp_saccadeSum'; corrMatrix{3,1}=PVAL1;
corrMatrix{2,2}=saccadeVel_saccadeSum; corrMatrix{1,2}= 'saccadeVel_saccadeSum'; corrMatrix{3,2}=PVAL2;
corrMatrix{2,3}=fixationAmp_fixationSum; corrMatrix{1,3}= 'fixationAmp_fixationSum'; corrMatrix{3,3}=PVAL3;
corrMatrix{2,4}=fixationVel_fixationSum; corrMatrix{1,4}= 'fixationVel_fixationSum'; corrMatrix{3,4}=PVAL4;

corrMatrix{2,5}=saccadeAmp_saccadeDif; corrMatrix{1,5}= 'saccadeAmp_saccadeDif'; corrMatrix{3,5}=PVAL5;
corrMatrix{2,6}=saccadeVel_saccadeDif; corrMatrix{1,6}= 'saccadeVel_saccadeDif'; corrMatrix{3,6}=PVAL6;
corrMatrix{2,7}=fixationAmp_fixationDif; corrMatrix{1,7}= 'fixationAmp_fixationDif'; corrMatrix{3,7}=PVAL7;
corrMatrix{2,8}=fixationVel_fixationDif; corrMatrix{1,8}= 'fixationVel_fixationDif'; corrMatrix{3,8}=PVAL8;

corrMatrix{2,9}=saccadeAmp_fixationSum; corrMatrix{1,9}= 'saccadeAmp_fixationSum'; corrMatrix{3,9}=PVAL9;
corrMatrix{2,10}=saccadeAmp_fixationDif; corrMatrix{1,10}= 'saccadeAmp_fixationDif'; corrMatrix{3,10}=PVAL10;
corrMatrix{2,11}=saccadeVel_fixationSum; corrMatrix{1,11}= 'saccadeVel_fixationSum'; corrMatrix{3,11}=PVAL11;
corrMatrix{2,12}=saccadeVel_fixationDif; corrMatrix{1,12}= 'saccadeVel_fixationDif'; corrMatrix{3,12}=PVAL12;

corrMatrix{2,13}=fixationAmp_saccadeSum; corrMatrix{1,13}= 'fixationAmp_saccadeSum'; corrMatrix{3,13}=PVAL13;
corrMatrix{2,14}=fixationAmp_saccadeDif; corrMatrix{1,14}= 'fixationAmp_saccadeDif'; corrMatrix{3,14}=PVAL14;
corrMatrix{2,15}=fixationVel_saccadeSum; corrMatrix{1,15}= 'fixationVel_saccadeSum'; corrMatrix{3,15}=PVAL15;
corrMatrix{2,16}=fixationVel_saccadeDif; corrMatrix{1,16}= 'fixationVel_saccadeDif'; corrMatrix{3,16}=PVAL16;

corrMatrix{2,17}=saccadeAmp_nextfixationSum; corrMatrix{1,17}= 'saccadeAmp_lastfixationSum'; corrMatrix{3,17}=PVAL17;
corrMatrix{2,18}=saccadeAmp_nextfixationDif; corrMatrix{1,18}= 'saccadeAmp_lastfixationDif'; corrMatrix{3,18}=PVAL18;
corrMatrix{2,19}=saccadeVel_nextfixationSum; corrMatrix{1,19}= 'saccadeVel_lastfixationSum'; corrMatrix{3,19}=PVAL19;
corrMatrix{2,20}=saccadeVel_nextfixationDif; corrMatrix{1,20}= 'saccadeVel_lastfixationDif'; corrMatrix{3,20}=PVAL20;


end