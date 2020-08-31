% trim.m
function y = trif(F,x)
    f = feval(F,x);
    y = f+f.^2;
end