clc;clear;
M = load_xdf('C:\Users\jyoth\OneDrive\Documents\MATLAB\bio-project\bio-project\Data.xdf');
M1=M{1,1}.time_series;
M2=M{1,2}.time_series;
fc = 250;
fs = 1000;
[b,a] = butter(6,fc/(fs/2));
temp1=filter(b,a,M(:,2));
temp1=M(:,2);
 k=1;
       for j=1:8:8192
           if(j+7<8192 && k<(8192/8))
             symbol(k,:)=temp1(j:j+7);
             k=k+1;
           end
       end
       
    temp1=symbol;

for i=1:1023
    Features(i,1)=mean(temp1(i,:));
    Features(i,2)=min(temp1(i,:));
    Features(i,3)=max(temp1(i,:));
    Features(i,4)=std(temp1(i,:));
    Features(i,5)=var(temp1(i,:));
    Features(i,6)=kurtosis(temp1(i,:));
    Features(i,7)=skewness(temp1(i,:));
    Features(i,8)=rms(temp1(i,:));
    Features(i,9)=sum(temp1(i,:));
end

 
k=1;
for j=1:8:8192
     if(k<(8192/8))
        Features(k,10)=M(j,1);
   
         k=k+1;
     end
end
