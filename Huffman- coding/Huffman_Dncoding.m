function Digital_Representation = Huffman_Dncoding(Binaryarray,DecToBinary)
%{
Function used to convert binary values in an array to decimal using
huffman coding and detect/correct errors
%}

Code = '';
for i = 1 : length(Binaryarray)
    Code = Code + string(Binaryarray(i));
    
end


cells= num2cell(char(Code));
d = string(cells(1));

c=1;

       
            for i = 1:length(cells)
                t=0;
                for j = 1:10
                    if d ==  DecToBinary(j,2)
                        Binaryarray(c) = str2double(DecToBinary(j,1));
                        c=c+1;
                        t = 1;
                        
                        
                    end
                end
                if t == 0
                    d = d + string(cells(i));
                    
                else 
                    d = string(cells(i));
                    
                end
            end
       
            
       Digital_Representation =Binaryarray
end