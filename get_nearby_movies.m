function movies_sorted = get_nearby_movies(movie, Vt)
    % TAKES movie # and Vt matrix (from svd of movie matrix)
    % RETURNS list of movies sorted by closest distance (first movie is
    % given movie #)
    
    format long
    n = height(Vt); % number of movies
    
    % find euclidian distance between all movies and provided one
    movies = zeros(n, 2); % nx2 matrix where column 1 stores movie # and column 2 stores distance
    for i = 1:n
        
        movies(i, 1) = i; % movie #
        movies(i, 2) = norm(Vt(movie, :) - Vt(i, :)); % euclidean distance (if i = provided movie, distance just 0)
       
    end

    % sort list of movies
    movies_sorted = sortrows(movies, 2); % sort based on euclidean distance (in 2nd column)

end