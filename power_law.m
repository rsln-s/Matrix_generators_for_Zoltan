alp = 5;
% p(x)=(alpha-1)*x^(-alpha) 

N=1000;

pow_law = zeros(1, N);

for i=1:N
    k=rand ;
    pow_law(1, i) = (1-k)^(1/(-alp+1));
end

histogram(pow_law)