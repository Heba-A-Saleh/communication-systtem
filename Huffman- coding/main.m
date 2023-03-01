%Defining Variables.
prob = [];                     
information = [];               
Entropy_VLC = 0;
Entropy_FVC = 0;
ACL = 0;
Efficiency = 0;

for i = 1:10
    %Part 1:- Calculate Probability, thus compute Information 
    n = sum(prove(:) == (i-1));     %To count the number of times variable i exists in prove
    
    
    p = n/483;                      %probability = number of i in prove/total array size
    prob = [prob; (i-1), p];        %store in array [variable probability]
    
    info = log2(1/p);                
    information = [information; (i-1),info];
    
    %part 2:- The Entropy summation of Variable length coding (VLC) 
    Entropy_VLC = Entropy_VLC + (p*info);
    
    %part 2:- Fixed length coding, would use 4 bits to represent digits from 0 to 9.
    Entropy_FVC = Entropy_FVC + (4*p);
end

%Part1:- information
fprintf('\nThe information :\n',information);

%Part 2:- Comparing Fixed and Variable Length Coding
fprintf('\nThe lowest average Binary Digits used in encoding( Entropy )=\n');
fprintf ('Fixed Length Coding : %.2f \n', Entropy_FVC);
fprintf ('Variable length Coding(Huffman code): %.4f \n', Entropy_VLC);
disp('Thus, Variable in this case provide the optimum coding methode as encoder a shorter encoder');

disp(prove)
%Part 3:-Huffman coding for the digits
DecToBinary = ["0","0111"; 
                "1","0110";
                "2","0010"; 
                "3","0001"; 
                "4","0011"; 
                "5","111";
                "6","0000"; 
                "7","010"; 
                "8","110"; 
                "9","10"];
%working in the eord document


%Part 4:- The expected length of bits 
ACL = (0.0518*4)+(0.0683*4)+(0.0787*4)+(0.0807*4)+(0.0766*4)+(0.0911*3)+(0.0828*4)+(0.1449*3)+(0.1077*3)+(0.2174*2);
fprintf('\n\nThe expected length of bits:%.5f\n', ACL);
fprintf('Which is higher than the entropy(%.5f) minimum bits to be sent), thus our message and data would be send successfully \n\n',Entropy_VLC )


%Part5:- Huffman_Encoding function to encode the digits
prove = Huffman_Encoding(string(prove),DecToBinary );
disp(prove);

fprintf('\n\nThe Average Code Length (ACL):%.5f\n', ACL);                      %Average bits used
fprintf('The Efficiency of the system is :%.5f\n', Entropy_VLC/ACL)
disp('Therefore, Huffman coding system in this case is proven to result to the most efficient and minimum redundancy')



%Part6:- Huffman_Dncoding function decode the encoded message
y = Huffman_Dncoding(prove,DecToBinary );
disp(y); 
   
            
