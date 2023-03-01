%Part 1:- The Coding Parameter (15,11,2)where 
%k = number of data(message) bits = 11
%n = codeword bits = n + check bits = 15
%d = hamming distance of 6  as the minimum bits change between two parity
%checks are 6
%It is a good code as it has minimum hamming distance of 6 it detects
%5 error and correct 2

%Part 2:- sub matrix A = Parity checks
A = [0 1 1 0;1 0 1 0;0 1 0 1;0 0 1 1;0 1 1 1;0 0 1 1;0 1 0 1;1 1 0 0;1 0 0 1;1 1 1 1;1 1 1 0];
G = [A eye(11)];

%Part 3:- H martix from G 
H = [eye(4) A'];

    %creating eroor matrix
e0 = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
e = [];
e = e0;
for i = 2:15
    Error=zeros(size(e0));
    Error(i:end) = e0(1:(end-(i-1)));
    e = [e; Error];  
end
    %Syndrom = eH'
S = H*e';


%Part 4:- convert char to ASCII (from 65 - 122) to binary (7 bits for each letter)
%Expected number of bits = number of input bits / code rate = (55 x 7) / 11/15 = 525 bits
Text = 'Basic Digital Communication with Networking';
x = dec2bin(double(Text));
message=[];

for i = 1:size(x)
    message = [message x(i,:)];%Message vector
end

while mod(length(message),11)>0
    message = horzcat(message,'0');
end

bits = reshape(message,11,length(message)/11);%Message block vector-change to matrix

data = mod(bits'*G,2);        %encoded message


%Part 5:-Interleaving
splitmats1 = mat2cell(data, [16, 16,3], 15); %split the data matrix to 16x15 submatrices
interleaving_bits = [reshape(splitmats1{1,1},1,240),reshape(splitmats1{2,1},1,240),reshape(splitmats1{3,1},1,45)]; %joined into one vector
 
%Part 6:-

random_variable = mod((dec2bin(randi([10 1000],1))),2);
Frame_start = [1 0 0 0 0 0 1 0];
Transmitted_code = [random_variable Frame_start interleaving_bits]; %code sent via a channel

%Part 7:- introduced errors

Transmitted_code(125 : 139) = ~ Transmitted_code(125 : 139);

%Part 8:- Deframing

I = 1;
J = 8;
while (I~=length(Transmitted_code))
    temp = Transmitted_code (1,I:J);
    if isequal(temp,Frame_start) == 1  
        Transmitted_code (1:J)=[];
        break
    else
       I=I+1;
       J = J+1;
    end   
end

%Part 9:- De-Interleaving: due to interleaving 1 bit error would be
%corrected as there would be no consecutive bit errors 
recieved_code = [reshape(Transmitted_code(1, 1:240),16, 15);reshape(Transmitted_code(1, 241:480),16, 15);reshape(Transmitted_code(1, 481:end),3, 15)];

%Part 10:- Decoding 
I = 1;
RX =[];
for i = 1:length(recieved_code)
    for j = 1:length(e)
        if  isequal((H*e(j,:)'),mod(H*recieved_code(i,:)',2))== 1  %if syndrome is not equal to zero it will look up the error position in the syndrom table 
            t = mod((e(j,:)+ recieved_code(i,:)),2); %adds the error to the recieved code to recover the original codeword
            break
        else       
            t = recieved_code(i,:);
        end 
    end 
     RX = [RX; t(5:end)]; 
end 
  R_Text=[];
  mat = [];
  
 for i = 1:size(RX)
    mat = [mat RX(i,:)] ;%Message vector
 end
c = 7;
i = 1;
 while (c <= length(mat)) % from binary to characters
     R_Text = [ R_Text char(bin2dec(num2str(mat(1,i:c))))];
     i=c+1;
     c=c+7;
 end
 
 disp (R_Text) 



    




 