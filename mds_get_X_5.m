% B=[M F]
% P - used as B*P, swaps column of B(first and second half)
% 2*D_interp = MF+F'M' = B*P*B'
% D_interp = 0.5*B*P*B'
% XX' = -0.5*J*D_interp*J = -0.25*J*B*P*B'*J
% QR for J*B -> Q*R
% XX' = -0.25*Q*R*P*R'*Q'
% decompose -0.25*R*P*R' -> V*L*V' (first 3 cols of largest eigs)
% X = Q*V*sqrt(L)

function X = mds_get_X_5(M, F)
[n,k] = size(M);
F = F';

% F2 = F.^2; 
F2 = F;

B = [M F2];
B = full(B);
J_B=B-1/n*repmat(sum(B),n,1);
% J = eye(n) - 1/n;
% J_B = J*B;
[Q,R] = qr(J_B, 0);
P = [zeros(k) eye(k) ; eye(k) zeros(k)];
[V, L] = eigs(-0.25*R*P*R', 3, 'lr');

X = Q*(V*sqrt(L));