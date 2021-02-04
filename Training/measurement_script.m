% Cleanup
try
    stop(osci);
    delete(osci);
end
try
    instrfind
    fclose(ans)
    delete(ans)
end
clear all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SETUP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Pick your Parameters for this experiment
basename = 'low-latency-aes-2020-06-03-'; % Pick a UNIQUE name for this experiment (instruction will be included automatically)
nrofframes  = 23946; % = fastframe parameter, should match that of oscilloscope
pntsperframe = 10000; % should match oscilloscope

% 2. Pick Instruction for Control
FIXvsFIXmaskOff = 1;  % 
FIXvsRNDmaskOff = 2;  % 
RNDvsRNDmaskOff = 3;  % 
FIXvsFIXmaskOn = 4;   % 
FIXvsRNDmaskOn = 5;   % 
RNDvsRNDmaskOn = 6;   % 
instruction = uint8(FIXvsRNDmaskOn); 

% 3. Pick Your Fixes
Group1 = uint8(hex2dec(['32';'88';'31'; 'e0'; '43'; '5a'; '31'; '37'; 'f6'; '30'; '98'; '07'; 'a8'; '8d'; 'a2'; '34'])');
Group2 = Group1;
Key = uint8(hex2dec(['2b'; '28';'ab';'09';'7e';'ae';'f7';'cf';'15';'d2';'15'; '4f';'16';'a6';'88';'3c'])');

% 4. Change this when you change your setup!!!
path_to_curves = '/media/jbod_storage/varribas/LLAES_traces/'; % Change to proper directory
oscip = '192.168.0.85'; % DEFINITELY pick the right oscilloscope IP address
serialport='/dev/ttyUSB1'; 
trace_channel = 4;
trigger_channel = 2;
baudrate = 19200; % baud 19200 -> clock 3.072 MHz

% 5. Extras
picfreq = 5; % Pick how often a pic is generated. 1 means all the time
mailfreq = 60; % Pick how often a mail is sent. 
emails = {'zhenda.zhang@esat.kuleuven.be','thiphuong.nguyen@esat.kuleuven.be','varribas@esat.kuleuven.be', 'lauren.demeyer@esat.kuleuven.be'};
forreal = 1; % if output will not be correct (because of debugging), set to 0
bivariate = 0; % if you want to save traces to files for bivariate analysis, set to 1 and fix parameters below 
% but make sure pntsperframe is at most 1000!!
header = '/media/jbod_storage/varribas/LLAES_traces/'; % Pick a folder in raid0 storage for the traces to be stored

% 6. Make sure the test code (line 122 etc) matches the functionality of the FPGA  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


inputmat    = zeros(nrofframes,1);
indexmat    = zeros(nrofframes,1);

instr_str = {'FIXvsFIXmaskOff','FIXvsRNDmaskOff','RNDvsRNDmaskOff','FIXvsFIXmaskOn','FIXvsRNDmaskOn','RNDvsRNDmaskOn'};

s = serial(serialport);
set(s,'baudrate',baudrate);
set(s,'parity','none');
set(s,'DataBits',8);
set(s,'StopBits',1);
fopen(s);

% Number of measurements to take
nr_of_meas = 10000*nrofframes; % multiple of nrofframes by preference
disp(['We will take ',num2str(nr_of_meas),' measurements']);

instructionname = instr_str{instruction};
name = strcat(basename,instructionname);
t=continuous_ttest_1to3o_mex(name);

osci       = tek7254_pnet(oscip);
clearOsc(osci);
disp('Oscilloscope objects created');

makeSettingsFile(osci,[trigger_channel trace_channel],['settings_tek_' date '.txt'],path_to_curves);

setpref('Internet','SMTP_Server','mailserv.esat.kuleuven.be');
setpref('Internet','E_mail','cosic-lab@cosic.esat.kuleuven.be');

%%


% The measurement loop
index = 0;
oldindex = 0;
frameindex = 0;
arm(osci); % make this run when using fastframe
pause(2);
disp('Starting the measurements');

filecount=0; % for bivariate only

while index < nr_of_meas
    if (mod(index,1000) == 0)
        fclose(s)
        delete(s)
        clear s
        stop(osci)
        delete(osci)
        pause(1)
        
        
        s = serial(serialport);
        set(s,'baudrate',baudrate);
        set(s,'parity','none');
        set(s,'DataBits',8);
        set(s,'StopBits',1);
        fopen(s);

        osci       = tek7254_pnet(oscip);
        clearOsc(osci);
        arm(osci)
        pause(2)
    end    
    

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLUG YOUR MATLAB TEST HERE &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    
    Group2out = [];
    Group1out = [];
    
    if ((instruction == FIXvsFIXmaskOff) || (instruction == FIXvsRNDmaskOff) || (instruction == RNDvsRNDmaskOff))
        rng_input(1:16) = uint8(hex2dec(['34'; 'a2'; '8d'; 'a8'; '07'; '98'; '30'; 'f6'; '37'; '31'; '5a'; '43'; 'e0'; '31'; '88'; '32'])');
    elseif ((instruction == FIXvsFIXmaskOn) || (instruction == FIXvsRNDmaskOn) || (instruction == RNDvsRNDmaskOn))
        rng_input(1:16)=uint8(floor(rand(1,16)*256));
    else
        assert(0);
    end
    
    rng_key(1:16) = uint8([0  1  2  3 4 5 6 7 8 9 10  11 12  13  14   15]);
    
    howmany(1:4) = uint8([0 mod(floor(nrofframes/(256*256)),256) mod(floor(nrofframes/256),256) mod(nrofframes,256)]);
    
    how_many=(double(howmany(1))*(256*256*256))+(double(howmany(2))*(256*256))+(double(howmany(3))*(256))+(double(howmany(4)));
    assert(nrofframes==how_many)
    
    Group1 = [Group1(1); Group1(5); Group1(9); Group1(13); Group1(2); Group1(6); Group1(10); Group1(14); Group1(3); Group1(7); Group1(11); Group1(15); Group1(4); Group1(8); Group1(12); Group1(16)]';
    Group2 = [Group2(1); Group2(5); Group2(9); Group2(13); Group2(2); Group2(6); Group2(10); Group2(14); Group2(3); Group2(7); Group2(11); Group2(15); Group2(4); Group2(8); Group2(12); Group2(16)]';
    Key = [Key(1); Key(5); Key(9); Key(13); Key(2); Key(6); Key(10); Key(14); Key(3); Key(7); Key(11); Key(15); Key(4); Key(8); Key(12); Key(16)]';

    %%
    ok = ~forreal; 
    
    while (ok ~= forreal)
        
        arm(osci);
        
        fwrite(s,instruction,'uint8');

        for byte = 1:16
            fwrite(s,rng_input(byte),'uint8'); % send in weird order
        end
        for byte = 1:16
                fwrite(s,Group1(byte),'uint8'); 
        end
        for byte = 1:16
                fwrite(s,Group2(byte),'uint8'); 
        end
        for byte = 1:16
                fwrite(s,Key(byte),'uint8'); 
        end
        for byte = 1:1:4
            fwrite(s,howmany(byte),'uint8');
        end
        
        %pause(60)
        pause(8.5 / 10000 * nrofframes);

        try 
        
            dataout = fread(s,32,'uint8');
        
            outputG1 = dataout(1:16);
            outputG2 = dataout(17:32);
        catch 
            disp 'catching serial port error'
            fclose(s)
            delete(s)
            clear s 
            pause(1)
            s = serial(serialport);
            set(s,'baudrate',baudrate);
            set(s,'parity','none');
            set(s,'DataBits',8);
            set(s,'StopBits',1);
            fopen(s);

            pause(3) 
            continue 
        end

        %%
        Group1in(1:16)=Group1;
        Group2in(1:16)=Group2;
        Keyin(1:16)=Key;

        % we are transforming to other order (which is weird i dont know?)
        rng_input = [rng_input(1); rng_input(5); rng_input(9); rng_input(13); rng_input(2); rng_input(6); rng_input(10); rng_input(14); rng_input(3); rng_input(7); rng_input(11); rng_input(15); rng_input(4); rng_input(8); rng_input(12); rng_input(16)]';
        
        groups = zeros(1,how_many);
        for i = 1:how_many
            
            rng_input=aes128_enc_mex(rng_input,rng_key); %1 for  coin
            gr = bitget(rng_input(1),8);
            
            groups(i) = gr; % DON'T FORGET TO ADD THIS

            rng_input=aes128_enc_mex(rng_input,rng_key); %2 for group 1
            if((instruction==3)||(instruction==6))
                Group1in = [rng_input(1); rng_input(5); rng_input(9); rng_input(13); rng_input(2); rng_input(6); rng_input(10); rng_input(14); rng_input(3); rng_input(7); rng_input(11); rng_input(15); rng_input(4); rng_input(8); rng_input(12); rng_input(16)]';
            end
            rng_input=aes128_enc_mex(rng_input,rng_key); %3 for group 2
            if((instruction==2)||(instruction==3)||(instruction==5)||(instruction==6))
                Group2in = [rng_input(1); rng_input(5); rng_input(9); rng_input(13); rng_input(2); rng_input(6); rng_input(10); rng_input(14); rng_input(3); rng_input(7); rng_input(11); rng_input(15); rng_input(4); rng_input(8); rng_input(12); rng_input(16)]';

            end


            if (gr)
                Group2out = aes128_enc_mex(Group2in,Keyin);
            else
                Group1out = aes128_enc_mex(Group1in,Keyin);

            end

            for i = 1:11
                rng_input=aes128_enc_mex(rng_input,rng_key); % + 11 for resharing
            end

            

        end
        
        %%
        ok = bitand(isequal(outputG1,Group1out'),isequal(outputG2,Group2out'));

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        if(ok ~= forreal)
            disp 'Wrong output!'
        end

    % The power measurement
    if ((ok==forreal) && (mod(frameindex,nrofframes)==0))
        stop(osci);
        pause(15) % fastframe
        %pause(0.3);
        fprintf('\nReading measurements\n');
        ground = readChan(osci, trace_channel);
        fprintf('Done reading\n');
        
        if (length(ground)~=nrofframes*pntsperframe)
            fprintf('\nThrowing measurements away due to ground, godverdoeme\n'); 
            % If this happened, best check that your matlab fastframe parameters match those of the oscilloscope
            index = oldindex;
            stop(osci);
            clearOsc(osci);
            
        else
            fprintf('\nWriting measurements to file\n');
            tic
            assert(nrofframes>3)
            
            % ADD SOME FILTER HERE IF NECESSARY
            %if (index == 0)
            %    normaltrace = ground(5*pntsperframe+1:6*pntsperframe);
            %end
            for index2 = 6:nrofframes % ignore the first mini traces, get rid of the DC bump
                trace = ground((index2-1)*pntsperframe+1:index2*pntsperframe);
                %if(max(abs(trace-normaltrace))<60)
                    t = add_trace(t,trace, groups(index2));
                %end
            end

            toc
             
            if (index == 0)
                fprintf('Reading trigger\n');
                trig = readChan(osci, trigger_channel);
                fprintf('Done reading\n');

                trigger = trig(1:pntsperframe);
            end
        end
        
        
        %% Save traces for bivariate analysis
        if(bivariate == 1)
            filename = sprintf('%straces-%s-%04d',header,name,filecount);
            curves = reshape(ground,pntsperframe,nrofframes)';
            save(filename,'curves','groups','index','Group1','Key');
            filecount = filecount + 1;
        end
        %%
        
        frameindex = 0;
        run(osci);
        pause(1); % fastframe
        %pause(0.3);
        
        if (mod(index,picfreq*nrofframes)==0)
            
            close all
            ttest = compute_ttest(t);
            figure;
            subplot(4,1,1);
            plot(ground(1:pntsperframe));
            hold off
            subplot(4,1,2);plot(ttest(1,:));
            hold on; plot(5*single(trigger)./max(single(trigger)),'r')
            title_str = sprintf('t test with no of traces %d',t.trace_counter);
            title(title_str)
            hold off
            subplot(4,1,3); plot(ttest(2,:));
            hold on; plot(5*single(trigger)./max(single(trigger)),'r')
            hold off
            subplot(4,1,4); plot(ttest(5,:));
            hold on; plot(5*single(trigger)./max(single(trigger)),'r')
            hold off

            
            % send email
            if mod(index,nrofframes*mailfreq) == 0
                close all
                ttest = compute_ttest(t);
                figure;
                subplot(4,1,1);
                plot(ground(1:pntsperframe));
                hold off
                subplot(4,1,2);plot(ttest(1,:));
                hold on; plot(5*single(trigger)./max(single(trigger)),'r')
                title_str = sprintf('t test with no of traces %d',t.trace_counter);
                title(title_str)
                hold off
                subplot(4,1,3); plot(ttest(2,:));
                hold on; plot(5*single(trigger)./max(single(trigger)),'r')
                hold off
                subplot(4,1,4); plot(ttest(5,:));
                hold on; plot(5*single(trigger)./max(single(trigger)),'r')
                hold off
                print -dpng t.png
                %pause(1)
                %close all
                title(sprintf('meas = %d', t.trace_counter));
                try 
                    sendmail(emails,['Re: t-test result: ' t.name], ...
                        sprintf('measurements = %d',t.trace_counter),'t.png');
                end
            end
            
        end
    end 
    
    index = index + how_many
end
end

%%

fclose(s);
delete(s);
clear s;


stop(osci);
delete(osci);
disp('done');

%%