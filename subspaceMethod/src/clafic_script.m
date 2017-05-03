dmax = 30;
imgsize = 28^2;
errorRate_l = [];
for d = 1:dmax
    errorRate = clafic(d, imgsize);
    errorRate_l = [errorRate_l, errorRate];
end
plot(1:dmax, errorRate_l);