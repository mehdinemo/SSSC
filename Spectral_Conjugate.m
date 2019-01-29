function [f_value, x] = Spectral_Conjugate(L,x_0)

%L is laplacian matrix
%x_k is estimation of eigenvector corresponding to second-smallest eigenvalue

format long;
K = size(L,1);
e = ones(1,K);
rand_x = zeros(K,1);
for i=1:K
    rand_x(i)=i-(K+1)/2;
end

switch nargin
    case 2
        x=x_0;%(jaygasht);
    case 1
        x=rand_x(randperm(K));%x(randperm(K));
end

% x=x(randperm(K));
x_k = x-((e*x/(e*e'))*e)';
rho_k = x_k'*x_k;
y_k = L*x_k;
F_k = x_k'*y_k/rho_k;
g_k = 2/rho_k*(F_k*x_k-y_k);
h_k = g_k;
beta_k = g_k'*g_k;

for k=1:K
    F = F_k;
    x = x_k;
    rho = rho_k;
    g = g_k;
    beta = beta_k;
    h = h_k;
    
    y_k = L*h;
    p_k = rho; q_k = 2*x'*h; r_k = h'*h;
    s_k = rho*F; t_k = 2*x'*y_k; u_k = h'*y_k;
    alpha_k = (-(u_k*p_k-s_k*r_k)+...
               sqrt((u_k*p_k-s_k*r_k)^2-(u_k*q_k-t_k*r_k)*(t_k*p_k-s_k*q_k)))/(u_k*q_k-t_k*r_k);
    F_k = (s_k+t_k*alpha_k+u_k*alpha_k^2)/(p_k+q_k*alpha_k+r_k*alpha_k^2);
    x_k = x+alpha_k*h;
    
    if  norm(g)<10^-6
        sprintf('iteration %d',k);
        break
    end
    
    rho_k = x_k'*x_k;
    g_k = 2/rho_k*(F_k*x_k-F*x+.5*rho*g-alpha_k*y_k);
    beta_k = g_k'*g_k;
    h_k = g_k+(beta_k/beta)*h;
end
x = x_k./norm(x_k);
f_value = x'*L*x;