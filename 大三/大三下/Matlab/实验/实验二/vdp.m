function dy = vpd(t, y, flag, ps)
    dy = zeros(2, 1);
    dy(1) = y(2);
    dy(2) = ps * ( 1- y(1)^2) * y(2) - y(1);
end