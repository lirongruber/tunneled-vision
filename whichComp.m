
function [SavingPath]=whichComp
% looking for the experiment directory-and deciding on which computer
%Im working on . output=where to save the data.

%ADD FOR EACH COMPUTER!!!


    
if exist('C:\Users\lirongruber\Documents\weizmann\tunnelledVisionPaper\','dir')
    SavingPath='C:\Users\lirongruber\Documents\weizmann\tunnelledVisionPaper_data\';
    
else if exist('C:\Users\aslab\Documents\Liron\tunnelledVisionPaper\','dir')
        SavingPath='C:\Users\aslab\Documents\Liron\tunnelledVisionPaper\data\';
        
    else if exist('C:\Users\bnapp\Documents\tunnelledVisionPaper\','dir')
            SavingPath='C:\Users\bnapp\Documents\tunnelledVisionPaper_data\';
            
        end
    end
end