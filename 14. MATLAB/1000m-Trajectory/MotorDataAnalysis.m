md = readmatrix('MotorDataPrepared.xlsx');
format long
mthrust = mean(md(:,2));
th = md(:,2);
t = md(:,1);
isp = mthrust/ (9.81*(1.09/4));
l = length(md(:,2));
dm= zeros(l,1);
dm(1)=1.3;

for i=2:l
dm(i) = dm(i-1) - (th(i) .* (t(i) - t(i-1)) ./ (9.82*isp));
end

isp
mthrust

md = [md(:,1:2),dm]
writematrix(md, "MotorDataPrepared.xlsx")


