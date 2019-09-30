%{ 
    FMDS  -  Fast multidimensional scaling solver

    Description:

     An Accelerated Multidimensional scaling solver. 

    Input: 

     surface - A struct representing a triangular mesh. 
     N       - Number of samples (typically 10 - 100).

    Output: 

     Z       - the 3D canonical form.

    Reference:

    [1] Shamai, Gil, Yonathan Aflalo, Michael Zibulevsky, and Ron kimmel.
    "Classical Scaling Revisited." In Proceedings of the IEEE 
    International Conference on Computer Vision, pp. 2255-2263. 2015.

    FOR ACADEMIC USE ONLY.
    ANY ACADEMIC USE OF THIS CODE MUST CITE THE ABOVE REFERENCE. 
    FOR ANY OTHER USE PLEASE CONTACT THE AUTHORS.
%}

function Z = FMDS(surface, N)

nv = length(surface.X);
miu = 50; 

% Compute the Laplace Beltrami operator L = inv(A)*W
G=metric_scale(surface.X, surface.Y, surface.Z, surface.TRIV,0); 
G_mat_tmp = cell2mat(G');
G_mat_tmp_left = G_mat_tmp(1:2:end,:);
G_mat_tmp_right = G_mat_tmp(2:2:end,:);
G_mat = [G_mat_tmp_left G_mat_tmp_right];    
[W, A]=laplace_beltrami_from_grad(surface.TRIV,G_mat');
A=spdiags(A,0,nv,nv);  

% farthest point sampling (SubSection 3.2 in [1])
[D_ext, sample2] = FPS(surface, N);    
R = D_ext.^2;

% compute the matrix M (Equation 7 in [1])
M = get_M(W, A, sample2, miu);

% compute the canonical form (Section 4 in [1])
Z = mds_get_X_5(M, R);      
