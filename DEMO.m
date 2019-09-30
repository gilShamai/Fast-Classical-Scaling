%{
    In this demo:
    
    Efficient approximation of non-linear dimensionality reduction by
    classical scaling (also known as multidimensional scaling (MDS) and
    Isomap).
    
    The approximation is deviated by less than ~0.05 from the full
    canonical form computation (see paper).
    
    Total computation time of a 50K vertices mesh with this approximation: 
    5-6 seconds (the full computation is impractical with this amount of
    points, see paper).
    
    If using these ideas please cite:

    [1] Gil Shamai, Michael Zibulevsky, and Ron Kimmel. "Efficient 
    Inter-Geodesic Distance Computation and Fast Classical Scaling". 
    IEEE transactions on pattern analysis and machine intelligence (2018).
    
    [2] Gil Shamai, Yonathan Aflalo, Michael Zibulevsky, and Ron Kimmel. 
     "Classical scaling revisited." In Proceedings of the IEEE 
    International Conference on Computer Vision, pp. 2255-2263. 2015.

%}

close all;
clear all;
clc;
addpath('fastmarch');
addpath('laplace_beltrami');
%% load a triangular mesh

fprintf('Creating shape...\n');
load 'david0.mat';
    
nv = length(surface.X);

figure;
trisurf(surface.TRIV, surface.X, surface.Y, surface.Z, zeros(nv,1)); axis equal;axis off; 
shading interp;lighting phong;cameratoolbar;camlight headlight

%% Canonical form
fprintf('Canonical form computation...\n');
N = 20; % number of samples. recomended 10-200
dim = 3; % embedding dimension 
tic
Z = FMDS(surface, N);
t = toc;
fprintf('Finished in %f seconds. \n', t);

%% Display result
figure;
trisurf(surface.TRIV, Z(:,3), Z(:,2), -Z(:,1), zeros(nv,1));
axis equal;axis off;
shading interp;lighting phong;cameratoolbar;camlight headlight
title('Canonical form', 'fontsize', 20);