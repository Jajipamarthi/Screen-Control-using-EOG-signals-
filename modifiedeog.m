clc;clear;
M = xlsread('C:\Users\jyoth\OneDrive\Documents\MATLAB\bio-project\bio-project\refer.xlsx');
%fc = 250;
%fs = 1000;
%[b,a] = butter(6,fc/(fs/2));
%temp1=filter(b,a,M(:,2));
temp1=M(:,2);
 k=1;
       for j=1:8:8192
           if(j+7<8192 && k<(8192/8))
             symbol(k,:)=temp1(j:j+7);
             k=k+1;
           end
       end
       
    temp2=symbol;

for i=1:1023
    %[Maxima(i),MaxIdx(i)] = findpeaks(temp1(i,:));
     %DataInv(i,:)= 1.01*max(temp1(i,:)) - temp1(i,:);
     %[Minima(i),MinIdx(i)] = findpeaks(DataInv(i,:));
    
    Features(i,1)=mean(temp2(i,:));
    Features(i,2)=min(temp2(i,:));
    Features(i,3)=max(temp2(i,:));
    %Features(i,4)=trapz(length(temp2(i,:)),temp2(i,:));
    Features(i,5)=var(temp2(i,:));
     Features(i,4)=std(temp2(i,:));
    %Features(i,6)=kurtosis(temp1(i,:));
   % Q(1) = median(y(find(y<median(y))));
    Features(i,8)=median(temp2(i,(find(temp2(i,:)<median(temp2(i,:))))));%first quartile
     Features(i,9)=median(temp2(i,(find(temp2(i,:)>median(temp2(i,:))))));%third quartile
    Features(i,6)=median(temp2(i,:));
    Features(i,7)=mode(temp1(i,:));
end




k=1;
                               
for j=1:8:8192
     if(k<(8192/8))
        Features(k,10)=M(j,1);
   
         k=k+1;
     end
end