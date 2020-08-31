function dy=right(t,y)
    dy=zeros(3,1);
    dy(1)=y(2)*y(3);
    dy(2)=-y(1)*y(3);
    dy(3)=-2*y(1)*y(2);
end