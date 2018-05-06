%% ploting for subData:

function []=vecsForStatForsubData(sub,labeled_saccade_vecs,analog,t,time_of_trial_in_sec,num_of_sacc_per_sec,whiteTimes,saccs_amp_degrees,drifts_dist_degrees,drifts_amp_degrees,saccs_vel_deg2sec,saccs_maxvel_deg2sec,drifts_vel_deg2sec,saccs_time_ms,drifts_time_ms)


typeOfSacc=labeled_saccade_vecs{1,1}(5,:);
typeOfDrift=labeled_saccade_vecs{1,1}(4,:);

for i=2:t
typeOfSacc=[typeOfSacc labeled_saccade_vecs{1,i}(5,:)];
typeOfDrift=[typeOfDrift labeled_saccade_vecs{1,i}(4,:)];
end


timeOftrial=time_of_trial_in_sec{1};
for i=2:t
    timeOftrial=[timeOftrial time_of_trial_in_sec{i}];
end


saccPerSec=num_of_sacc_per_sec{1};
for i=2:t
    saccPerSec=[saccPerSec num_of_sacc_per_sec{i}];
end
% saccPerSec=saccPerSec(saccPerSec~=0);


timeNearShape=whiteTimes{1,1}(1,1);
for i=2:t
    if ~isempty(whiteTimes{1,i})
        timeNearShape=[timeNearShape whiteTimes{1,i}(1,1)];
    end
end

%%%%%

saccAmp=saccs_amp_degrees{1};
for i=2:t
    saccAmp=[saccAmp saccs_amp_degrees{i}];
end
% saccAmp=saccAmp(saccAmp~=0);


saccVel=saccs_vel_deg2sec{1};
for i=2:t
    saccVel=[saccVel saccs_vel_deg2sec{i}];
end
% saccVel=saccVel(saccVel~=0);


saccMaxVel=saccs_maxvel_deg2sec{1};
for i=2:t
    saccMaxVel=[saccMaxVel saccs_maxvel_deg2sec{i}];
end
% saccMaxVel=saccMaxVel(saccMaxVel~=0);


driftAmp=drifts_amp_degrees{1};
for i=2:t
    driftAmp=[driftAmp drifts_amp_degrees{i}];
end
% driftAmp=driftAmp(driftAmp~=0);

driftDist=drifts_dist_degrees{1};
for i=2:t
    driftDist=[driftDist drifts_dist_degrees{i}];
end
% driftDist=driftDist(driftDist~=0);


driftAmp_for_cat=drifts_amp_degrees{1};
for i=2:t
    driftAmp_for_cat=[driftAmp_for_cat 0 drifts_amp_degrees{i}];
end
driftAmp_for_cat=[driftAmp_for_cat 0];

driftVel=drifts_vel_deg2sec{1};
for i=2:t
    driftVel=[driftVel drifts_vel_deg2sec{i}];
end
% driftVel=driftVel(driftVel~=0);

driftVel_for_cat=drifts_vel_deg2sec{1};
for i=2:t
    driftVel_for_cat=[driftVel_for_cat 0 drifts_vel_deg2sec{i}];
end
driftVel_for_cat=[driftVel_for_cat 0];


saccTime=saccs_time_ms{1};
for i=2:t
    saccTime=[saccTime saccs_time_ms{i}];
end
% saccTime=saccTime(saccTime~=0);


driftTime=drifts_time_ms{1};
for i=2:t
    driftTime=[driftTime drifts_time_ms{i}];
end
% driftTime=driftTime(driftTime~=0);

driftTime_for_cat=drifts_time_ms{1};
for i=2:t
    driftTime_for_cat=[driftTime_for_cat 0 drifts_time_ms{i}];
end
driftTime_for_cat=[driftTime_for_cat 0];

if strcmp(analog,'S')==1
    save(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\SMALLvectorsForStat'],...
        'typeOfSacc','typeOfDrift','timeOftrial','saccPerSec','timeNearShape','saccAmp','saccVel',...
        'saccMaxVel','driftDist','driftAmp','driftVel','saccTime','driftTime','driftVel_for_cat','driftAmp_for_cat','driftTime_for_cat'...
        );
    
else if strcmp(analog,'n')==1
        save(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\nSMALLvectorsForStat'],...
            'typeOfSacc','typeOfDrift','timeOftrial','saccPerSec','timeNearShape','saccAmp','saccVel',...
            'saccMaxVel','driftDist','driftAmp','driftVel','saccTime','driftTime','driftVel_for_cat','driftAmp_for_cat','driftTime_for_cat'...
            );
    else if strcmp(analog,'B')==1
            save(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\vectorsForStat'],...
                'typeOfSacc','typeOfDrift','timeOftrial','saccPerSec','timeNearShape','saccAmp','saccVel',...
                'saccMaxVel','driftDist','driftAmp','driftVel','saccTime','driftTime','driftVel_for_cat','driftAmp_for_cat','driftTime_for_cat'...
                );
        else if strcmp(analog,'N')==1
                save(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\NvectorsForStat'],...
                    'typeOfSacc','typeOfDrift','timeOftrial','saccPerSec','timeNearShape','saccAmp','saccVel',...
                    'saccMaxVel','driftDist','driftAmp','driftVel','saccTime','driftTime','driftVel_for_cat','driftAmp_for_cat','driftTime_for_cat'...
                    );
            end
        end
    end
    
end

end