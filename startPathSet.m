% start file for updating paths
% % This is the first file to be used

[SavingPath]=whichComp;

% % apply at work ( programming coputer (new)):
if strcmp(SavingPath,'C:\Users\bnapp\Documents\tunnelledVisionPaper_data\')
    cd C:\Users\bnapp\Documents\tunnelledVisionPaper\
    addpath (genpath('C:\Users\bnapp\Documents\tunnelledVisionPaper_data\'))
    addpath (genpath('C:\Users\bnapp\Documents\tunnelledVisionPaper\'))
end

% % apply at work ( experiment computer):
if strcmp(SavingPath,'C:\Users\aslab\Documents\Liron\tunnelledVisionPaper\data\')
    cd C:\Users\aslab\Documents\Liron\tunnelledVisionPaper\
    addpath (genpath('C:\Users\aslab\Documents\Liron\tunnelledVisionPaper\data\'))
    addpath (genpath('C:\Users\aslab\Documents\Liron\tunnelledVisionPaper\'))
end

%%apply at home:
if  strcmp(SavingPath,'C:\Users\lirongruber\Documents\weizmann\tunnelledVisionPaper_data\')
    cd C:\Users\lirongruber\Documents\weizmann\tunnelledVisionPaper\
    addpath (genpath('C:\Users\lirongruber\Documents\weizmann\tunnelledVisionPaper_data\'))
    addpath (genpath('C:\Users\lirongruber\Documents\weizmann\tunnelledVisionPaper\'))
end

% LATEX TEXT is default:
set(0,'DefaultTextInterpreter','Latex')
% FONTS is default:
set(0,'defaultAxesFontName', 'arial')
set(0,'defaultTextFontName', 'arial')















