function Binary_Representation = Huffman_Encoding(digitalarray,DecToBinary)
%Function used to convert decimal values in an array to binary using
%huffdman coding
         
           
            for i = 1:length(digitalarray)
                for j = 1:10
                    if string(digitalarray(i)) == DecToBinary(j,1)
                        digitalarray(i) = DecToBinary(j,2);
                    end
                end
            end
            
            Binary_Representation  = digitalarray;
          

            
            
          
end
