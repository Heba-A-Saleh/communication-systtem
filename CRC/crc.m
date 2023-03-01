% Cyclic redundancy Check, CRC - 8 module that detects up to 3 errors and
% correct up single, duoble and burst errors

clear all;
close all;
clc;
G = [1 1 1 0 1 0 1 0 1];     %%%generator polynomial x8+x5+x3+x2+x+1    
LG = length(G); frame = 8; message = randi([0 1],1,frame); remainder_size = 8;
msg_in = message; len_msg = length(msg_in);                              
msg_in(len_msg+remainder_size) = 0;  % Padding zeros  
disp (message)
%%  Transmitter   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    remainder = zeros;
    Lmsg = length(msg_in);

for k=1:(Lmsg-8)   %Division of the input message by the generator
  if msg_in(k)== 1
     msg_in(k:k+8)=mod(msg_in(k:k+8)+G,2); %mod 2, (XOR)               
  end
end
msg_tx = [message msg_in(k+1:end)];     %Codeword
disp (msg_tx)
%% creating Lookup table %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
e0 = zeros(1,16); error_remainder  = []; errors_Location = [e0]; le = length(e0);
for err = 1:8                   % Error Generator matrix
    e0(1:(le-err))=0; e0((le-err) : end ) = 1 ;
    for line = 1:(14*2*err)    %to cover all possibility
        repeated=0; Error = e0; 
        e0 = randerr(1,16,err);     
        for i = 1:size(errors_Location ) %check for repeatition 
            if  all (mod(Error + errors_Location(i,:) , 2) ==0)
                repeated = 1; break              
            end
        end
        if repeated == 0
            for i = 1:16                         %shifter
                Error = circshift(Error,[0 -1]); 
                errors_Location = [errors_Location; Error];  % error indexes matrix
            end
        end 
    end
end
for i = 1 : length(errors_Location)    % To obtain the remainders for each error
    Error = errors_Location(i,:);
    for k=1:(Lmsg-8) 
       if Error(k)== 1
           Error(k:k+8)=mod(Error(k:k+8)+G,2);  
       end
    end
    error_remainder = [error_remainder; Error];
end 
%% Introducing Error %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    msg_tx=mod(msg_tx+randerr(1,16,3),2);   
    %msg_tx(4:6) = ~msg_tx(4:6);    
%% Receiver    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
msg_rx = msg_tx;incoming_msg = msg_tx;out =0;
disp (incoming_msg)
for k=1:(Lmsg-8)  
    if msg_rx(k)== 1
       msg_rx(k:k+8)=mod(msg_rx(k:k+8)+G,2);                 
    end
end
error_free_data = [];error_count = 0;              % remainder checker  
disp (msg_rx)
if all (msg_rx == 0)==0 
    for j = 1:length(errors_Location)
        if msg_rx == error_remainder(j,:)   % Lookup table    
            for i = 1:length(error_remainder) 
                if all (mod(errors_Location(j,:) + error_remainder(j,:) , 2) ==0)
                    error_free_data = incoming_msg;
                    error_count = sum(errors_Location(j,:) == 1); %detects number of errors
                    out =1;break                      
                end
             end
          if out == 0
                msg_output = mod(incoming_msg+errors_Location(j,:),2);
                for k=1:(Lmsg-8)  
                    if msg_output(k)== 1
                         msg_output(k:k+8)=mod(msg_output(k:k+8)+G,2);                 
                    end
                end
                if all (msg_output == 0)  
                      error_free_data = mod(incoming_msg+errors_Location(j,:),2);
                      error_count = sum(errors_Location(j,:) == 1); %detects number of errors
                         break                
                end
          end
        end
    end
end
disp(error_free_data(1:8))
fprintf('Errors detected  = %d \n ',error_count);