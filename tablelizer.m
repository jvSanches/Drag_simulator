Ax = transpose(timespan);
Bx =(S_log);
Cx = (V_log);

for i = 2:101
    Ax(i) = Ax(10*(i-1) + 1);
    Bx(i) = Bx(10*(i-1) + 1);
    Cx(i) = Cx(10*(i-1) + 1);
end
Ax = Ax(1:101);
Bx = Bx(1:101);
Cx = Cx(1:101);
Dx = [Ax Cx Bx];