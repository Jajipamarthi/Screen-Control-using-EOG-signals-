function [f, t] = preProcess_EOG(data,freqs)
    [b,a] = butter(4,[59/(freqs/2) 61/(freqs/2)],'stop');

    %figure

    %freqz(b,a)

    for j=1:size(data,1)

        m1 = mean (data(j,:));

        for i = 1:size(data,2)            

            %m2 = mean (data(2,:));

            r1(j,i) = data(j,i) - m1;

            %r(2,i) = data(2,i) - m2;  

        end

    end

    d1f=[];d2f=[];

    d1t=[];d2t=[];f1=[];

    for k = 1:size(data,1)

        f_temp=fft(r1(k,:));

        f1=[f1;f_temp];

        %f(j).f2=fft(r(j).r2);

        f1_temp=f1(k,:);

        d1f = [d1f;abs(filter(b,a,f1_temp))];

        %d2f = [d2f;abs(filter(b,a,f(j).f2))];

    end

    d1t = abs(ifft(d1f));

    %d2t = abs(ifft(d2f));

 

    f = d1f;

    t = d1t;

end