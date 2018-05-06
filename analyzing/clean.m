% cleaning -all- the gazes..........(only used "once" - all analysis on cleaned data)
clear
clc

savePath='C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\cleanedData\';
trialNum=10;
maxerror=0.005;
count=0;
totalTrials=0;
E=[];

for name={'SM' ,'RW', 'LS', 'LB' , 'AS'};%,subjects
    n=cell2mat(name);
    for analog={'B', 'S', 'N'} % big or small
        sz=cell2mat(analog);
        if strcmp(analog,'S')
            sessionNum=6;
        else if strcmp(analog,'B')
                sessionNum=3;
            else if strcmp(analog,'N')
                    sessionNum=4;
                end
            end
        end
        for s=1:sessionNum; %session number
            for t=1:trialNum %trial number
                fileName=[n , '_'  sz num2str(s)];
                disp(fileName)
                [dataLens,times,calLens,gazesX,gazesY,fixs,pds,myimgfiles,imdatas,gazesX_cal,gazesY_cal,answers,iscorrects,missedSampless]=loadAndFix(fileName,t);
                [~ ,c ,val ]=find(missedSampless{1,1});
                totalTrials=totalTrials+length(gazesX{1,1});
                
                maxError=max(val);
                if maxError>maxerror
                    error=val(val>maxerror);
                    count=count+length(error);
                    E=[E error];
                end
                
                gazeX=gazesX{1,1};
                gazeX_cal=gazesX_cal{1,1};
                gazeY=gazesY{1,1};
                gazeY_cal=gazesY_cal{1,1};
                
                p=pds{1,1};
%                 figure(1); plot(p) ; hold on
                p(abs(gazeX)>5000)=nan;
                p(abs(gazeY)>5000)=nan;
%                 plot(p)
                p(p<nanmean(p)-2*nanstd(p))=nan;
%                 plot(p)
                d=diff(p);
%                 figure(2); plot(d) ; hold on
                d(abs(d)>2*nanstd(d))=nan;
%                 plot(d)
                p(isnan(d))=nan;
%                 figure(1); plot(p)
                
                gazeX(abs(gazeX)>5000)=nan;
                gazeX_cal(abs(gazeX_cal)>5000)=nan;
                gazeY(abs(gazeY)>5000)=nan;
                gazeY_cal(abs(gazeY_cal)>5000)=nan;
                %                 figure(1); plot(gazeX,gazeY,'.')
                
                numVar=0;
                for currVar={gazeX,gazeX_cal,gazeY,gazeY_cal}
                    currVar=currVar{1,1};
                    numVar=numVar+1;
                    while  max(isnan(currVar))> 0
                        nans=isnan(currVar);
                        i=find(nans);
                        if i(1)==1
                            i=i(2:end);
                            currVar(1)=0;
                        end
                        currVar(i)=currVar(i-1);
                    end
                    if numVar==1
                        gazeX=currVar;
                    else if numVar==2
                            gazeX_cal=currVar;
                        else if numVar==3
                                gazeY=currVar;
                            else if numVar==4
                                    gazeY_cal=currVar;
                                end
                            end
                        end
                    end
                end
                
                %%for pd cleaning there is a need for some more work on before
                %%and after:
                nans=isnan(p);
                i=find(nans);
                if size(i,2)~=size(p,2)
                    while isnan(p(1))
                        i=i(2:end);
                        p(1)=nanmean(p);
                    end
                    while isnan(p(end))
                        i=i(1:end-1);
                        p(end)=nanmean(p);
                    end
                    
                    before_nans=p(i-1);
                    after_nans=p(i+1);
                    before=nan;
                    b=1;
                    after=nan;
                    a=1;
                    for curr=1:length(i)
                        before=before_nans(curr);
                        b=curr;
                        while isnan(before)
                            b=b-1;
                            before=before_nans(b);
                        end
                        after=after_nans(curr);
                        a=curr;
                        while isnan(after)
                            a=a+1;
                            after=after_nans(a);
                        end
                        p(i(b):i(a))=linspace(before,after,a-b+1);
                        curr=a+1;
                    end
                end
                p=zscore(p);
                %                 plot(p)
                
                SavingFile=[savePath n '\' n '_'  sz num2str(s) '_' num2str(t)   '.mat'];
                save(SavingFile, '-regexp', '^(?!(a|b|d|c|counts|E|error|i|n|s|sz|t|val|trialNum|totalTrials|sessionNum|savePath)$).')
            end
        end
    end
end

% count
% totalTrials


