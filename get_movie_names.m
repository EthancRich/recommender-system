function movie_names = get_movie_names(movie_ids)
    %TAKES:
    %   List of movie ids 
    %RETURNS:
    %   Movie names as listed in 'movies.csv'

    Movies = readtable('ml-latest-small/movies.csv', "Delimiter", ","); 
    
    movie_names = strings(numel(movie_ids), 1);
    
    for i = 1:numel(movie_ids)
        idx = Movies{:, 1}==movie_ids(i);
        movie_names(i) = Movies(idx, 2).title;
    end



end

