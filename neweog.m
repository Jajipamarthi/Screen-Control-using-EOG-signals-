clc;clear;
[Stream,Header]=load_xdf('C:\Users\Deep_HP\Downloads\BIO-lab\bio-project\train8.xdf');
Keyboard=Stream{1,2}.time_stamps';
Keyboard=Keyboard(2:599,:);
%%
for i=1:598
    Keyboard(i,2)=mod(i,2);
end
Eyedata=Stream{1,1}.time_stamps';
Eyedata=Eyedata(2:593950,:);
temp=Stream{1,1}.time_series(1,:)';
temp=temp(2:593950,:);
temp2=Stream{1,1}.time_series(2,:)';
temp2=temp2(2:593950,:);
fc = 240;
fs = 1000;
[b,a] = butter(6,fc/(fs/2));
temp1=filter(b,a,temp);
temp3=filter(b,a,temp2);
%%
for i=1:299
    timestart=Keyboard(2*i-1,1);
    timestop=Keyboard(2*i,1);
    k=1;
    for j=1:593949
        if Eyedata(j)>timestart && Eyedata(j)<timestop
            symbol(i,k)=temp1(j);
            symbol2(i,k)=temp3(j);
            k=k+1;
        end
    end
    symbol1=symbol';
    [f,t1]=preProcess_EOG(symbol1,480);
        symbol22=symbol2';
    [f2,t2]=preProcess_EOG(symbol22,480);
end
symbolz1=t1;
symbolz11=f;
symbolz2=t2;
symbolz12=f2;
n=Stream{1,2}.time_series';
n=n(2:599);
%%
for i=1:299
    Features(i,1)=mean(symbolz11(i,:));
    Features(i,2)=min(symbolz11(i,:));
    Features(i,3)=max(symbolz11(i,:));
    % Features(i,5)=trapz(length(symbolz1(i,:));
    Features(i,6)=var(symbolz11(i,:));
    Features(i,4)=std(symbolz11(i,:));
    %Features(i,6)=kurtosis(temp1(i,:));
    Features(i,5)= median(symbolz11(i,:));
    Features(i,8)=median(symbolz11(i,(find(symbolz11(i,:)<median(symbolz11(i,:))))));%first quartile
    Features(i,9)=median(symbolz11(i,(find(symbolz11(i,:)>median(symbolz11(i,:))))));%third quartile
    %Features(i,6)=median(symbolz1(i,:));
    Features(i,7)=mode(symbolz11(i,:));
    Feature(i,10)=ZCR(symbolz11(i,:));
     Feature(i,11)=ZCR(symbolz1(i,:));
end
for i=1:299
    Features2(i,1)=mean(symbolz12(i,:));
    Features2(i,2)=min(symbolz12(i,:));
    Features2(i,3)=max(symbolz12(i,:));
    %Features2(i,5)=trapz(length(symbolz2(i,:));
    Features2(i,6)=var(symbolz12(i,:));
    Features2(i,4)=std(symbolz12(i,:));
    %Features(i,6)=kurtosis(temp1(i,:));
    %Q(1) = median(y(find(y<median(y))));
    Features2(i,8)=median(symbolz12(i,(find(symbolz12(i,:)<median(symbolz12(i,:))))));%first quartile
    Features2(i,9)=median(symbolz12(i,(find(symbolz12(i,:)>median(symbolz12(i,:))))));%third quartile
    %Features2(i,6)=median(symbolz12(i,:));
    Features2(i,7)=mode(symbolz12(i,:));
     Features(i,5)= median(symbolz12(i,:));
     Feature(i,10)=ZCR(symbolz12(i,:));
     Feature(i,11)=ZCR(symbolz2(i,:));
end

l={'RIGHT_start','DOWN_start','BLINK_start','UP_start','LEFT_start','NEUTRAL_start'};
k=10 % label column number
for i=1:299
   t=2*i-1;
   g(t)=n(t);
    if (strcmp(g(t),l(1))==1)
        Features(i,k)=1;
    elseif (strcmp(g(t),l(2))==1)
         Features(i,k)=2;
    elseif (strcmp(g(t),l(3))==1)
         Features(i,k)=3;
    elseif (strcmp(g(t),l(4))==1)
         Features(i,k)=4;
    elseif (strcmp(g(t),l(5))==1)
         Features(i,k)=5;
    else
         Features(i,k)=6;
     end
end
Features2(:,k)=Features(:,k);
Features = [Features ; Features2];
%%
Featurestrain=Features(1:400,:);

Featurestest=Features(401:598,:);
x=size(Featurestest)
%{
for i=1:1:9
Featurestest(x(1)+i,:)=Features(i,1:10);
end
%}
testlabel=Featurestest(:,5);
testdata=Featurestest(:,1:4);
[trainedClassifier, validationAccuracy] = trainClassifier1(Featurestrain);
yfit = trainedClassifier.predictFcn(testdata);
con=confusionmat(yfit,testlabel)
accuracy = sum(diag(con))/sum(sum(con))