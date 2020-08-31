function y1=mainfun(a,s)     %  主函数
    t=(0:a)/a*2*pi;
    y1=subfun(4,s);              % 子函数调用
    who
end

function y2=subfun(a,s)      % 子函数
    t=(0:a)/a*2*pi;
    ss='a*exp(i*t)';
    switch s
        case {'base','caller'}
            y2=evalin(s,ss);
        case 'self'
            y2=eval(ss);
    end
    who
end