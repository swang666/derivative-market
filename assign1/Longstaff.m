function [price, cashflow, path,c, b] = Longstaff(N, T, K, S0, r, sigma, num)

    paths = zeros(num, N+1);
    rnorm = randn(num, N);
    CF = zeros(num, N);
    dt = T/N;
    paths(:, 1) = S0;
    for i = 1:N
        paths(:,i+1) = paths(:, i).*exp( (r-sigma^2/2)*dt +  sigma* rnorm(:, i) * sqrt(dt));
    end
    CF(:, N) = max([K - paths(:, N+1) zeros(num,1)],[],2);
    for i = (N-1):-1:1
        temp = (paths(:,i+1) < K);
        x = paths(:, i+1).* temp;
        y = zeros(num, 1);
        for j = 1: num
            [M,I] = max(CF(j, i+1:N));
            if M > 0
                y(j) = CF(j, i+I) * exp(-r*dt*I);
            end
        end
        y = y.* temp;
        X = [ones(length(x),1).* temp x x.^2];
        b = X\y;
        continuoation = X*b;
        newCF = max([K - paths(:,i+1) zeros(num, 1)], [], 2);
        ngc = (continuoation < newCF);
        for j = 1: length(ngc)
            if ngc(j) == 1
                CF(j, : ) = zeros(1, N);
                CF(j, i) = newCF(j);
            end    
        end
    end
    
    B = transpose(exp(-r*dt:-r*dt:-N*r*dt));
    b = B;
    cashflow = CF;
    price = mean(CF * B);
    path = paths;
    c = continuoation;
end