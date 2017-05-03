function errorRate = clafic(d, imgsize)
addpath ../../../TensorMachine/TN_CLAFIC/src
% kappa = 

Ntrain = 60000;
Nvarid = 0;
Ntest = 10000;
classmap = containers.Map(0:9, 1:10);
[ Xtrain, Xvarid, Xtest, ytrain, yvarid, ytest ] = prepareMNIST( imgsize, Ntrain, Nvarid, Ntest, classmap );

Hs = cell(10,1);
for c = 1:10
    ind = find( ytrain == c );
    Hs{c} = Xtrain(ind,:)' * Xtrain(ind,:);
end

for c = 1:10
    Hs{c} = Hs{c} / sum( ytrain == c );
end

Ps = cell(10,1);
for c = 1:10
    [V, D] = eig(Hs{c});
    V = fliplr(V);
    lambda = fliplr( diag(D)' );
    P = V(:,1:d) * V(:,1:d)' ;
    a = sum( lambda(1:d) );
    disp(['c:',num2str(a)]);
    Ps{c} = P;
end

ypred = zeros(Ntest,1);
for i = 1:Ntest
    score = zeros(10,1);
    x = Xtest(i,:)';
    for c = 1:10
        score(c) = (x' * Ps{c} * x) / (x' * x);
    end
    [~, y] = max(score) ; 
    ypred(i) = y;
end

errorRate = sum(ypred ~= ytest) / Ntest;
disp(['Error:', num2str(errorRate)]);
end