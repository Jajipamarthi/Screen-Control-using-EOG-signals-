import java.awt.Robot;
mouse = Robot;
mouse.mouseMove(0, 0);
pause(5);

screenSize = get(0, 'screensize');
centerx=screenSize(3)/2;
centery=screenSize(4)/2;

mouse.mouseMove(centerx,centery);
pause(5);
mouse.mouseMove(centerx,centery);
C = get(0, 'PointerLocation');
l=[1,3,2,4];
%{
for i=1:4
if(l(i)==1)%right
    
     mouse.mouseMove(centerx+10,centery);
   % mouse.mouseMove(C(1)+20,C(2));
    C = get(0, 'PointerLocation');
    pause(5);
elseif(l(i)==2)%left
    
    mouse.mouseMove(centerx-10,centery);
    %mouse.mouseMove(C(1)-20,C(2));
    C = get(0, 'PointerLocation');
     pause(5);
elseif(l(i)==3)%up
     
     mouse.mouseMove(centerx,centery+10);
     C = get(0, 'PointerLocation');
      pause(5);
else 
         mouse.mouseMove(centerx,centery-10);
       % mouse.mouseMove(C(1),C(2)-20);
        C = get(0, 'PointerLocation');
        pause(5);
end
end
%}