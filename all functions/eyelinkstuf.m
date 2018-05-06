  Eyelink('initialize'); 
Eyelink('Stoprecording');
        pause(1)
        error = Eyelink('CheckRecording');
        pause(1)
        status4 = Eyelink('CloseFile');
        pause(1)
        status5=Eyelink('ReceiveFile');
            Eyelink('Shutdown');

        
        
            Eyelink('command','calibration_type = HV9')
        Eyelink('Command','binocular_enabled=NO')

         Eyelink('command', ['calibration_targets  = ',int2str(points2_L(1,1)),',',int2str(points2_L(1,2)),' ',int2str(points2_L(2,1)),',',int2str(points2_L(2,2)),' ',int2str(points2_L(3,1)),',',int2str(points2_L(3,2)),' ',int2str(points2_L(4,1)),',',int2str(points2_L(4,2)),' ',int2str(points2_L(5,1)),',',int2str(points2_L(5,2)),' ',int2str(points2_L(6,1)),',',int2str(points2_L(6,2)),' ',int2str(points2_L(7,1)),',',int2str(points2_L(7,2)),' ',int2str(points2_L(8,1)),',',int2str(points2_L(8,2)),' ',int2str(points2_L(9,1)),',',int2str(points2_L(9,2))])   %,' ',int2str(points2_L(10,1)),',',int2str(points2_L(10,2)),' ',int2str(points2_L(11,1)),',',int2str(points2_L(11,2)),' ',int2str(points2_L(12,1)),',',int2str(points2_L(12,2)),' ',int2str(points2_L(13,1)),',',int2str(points2_L(13,2))])
        Eyelink('command', ['validation_targets  = ',int2str(points2_L(1,1)),',',int2str(points2_L(1,2)),' ',int2str(points2_L(2,1)),',',int2str(points2_L(2,2)),' ',int2str(points2_L(3,1)),',',int2str(points2_L(3,2)),' ',int2str(points2_L(4,1)),',',int2str(points2_L(4,2)),' ',int2str(points2_L(5,1)),',',int2str(points2_L(5,2)),' ',int2str(points2_L(6,1)),',',int2str(points2_L(6,2)),' ',int2str(points2_L(7,1)),',',int2str(points2_L(7,2)),' ',int2str(points2_L(8,1)),',',int2str(points2_L(8,2)),' ',int2str(points2_L(9,1)),',',int2str(points2_L(9,2))])   %,' ',int2str(points2_L(10,1)),',',int2str(points2_L(10,2)),' ',int2str(points2_L(11,1)),',',int2str(points2_L(11,2)),' ',int2str(points2_L(12,1)),',',int2str(points2_L(12,2)),' ',int2str(points2_L(13,1)),',',int2str(points2_L(13,2))])
        
        Eyelink('command','active_eye=LEFT')
        el.eye = 'l';
        EyelinkDoTrackerSetup(el)