function plot_user_movie_heuristics(k, U, Vt)

    % plot U and Vt only if k = 3 (so that plot can be 3d)
    if(k==3) 
        %U is a Mxk matrix containing user similarities
        figure;
        scatter3(U(:, 1), U(:, 2), U(:, 3), 'filled') % (columns contain x, y, z values respectively)
        %for i = 1:M
        %    text(U(i, 1), U(i, 2), U(i, 3), strcat("User ",num2str(i)));
        %end
    
        %Vt is a Nxk matrix containing movie similarities
        figure
        scatter3(Vt(:, 1), Vt(:, 2), Vt(:, 3), 'filled') % (columns contain x,y,z values respectively)
        
        %for i = 1:N
        %    text(Vt(i, 1), Vt(i, 2), Vt(i, 3), strcat("Movie ", num2str(i)));
        %end
    else
        fprintf("k is not 3, so 3D plot cannot occur. Returning.")
    end
end
