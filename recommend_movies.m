function [movies_sorted, map] = reccomend_movies(chosen_movie_id, min_ratings, k, num_recommendations)
    % TAKES: 
    % - chosen_movie_id, movie id off of which to reccomend similar movies
    % - min_ratings, the minimum number of ratings for a movie to be considered
    % - k, truncation value for TSVD
    % RETURNS:
    % - movies_sorted, list of movies sorted based off of similarity
    % - map, map of movie indicies to IDs
    
    % Import the data associating user IDs with their movie ratings
    AllRatings = readmatrix('ml-latest-small/ratings.csv'); % (used to be A)
    [total_entries, ~] = size(AllRatings);
    
    % Create a matrix B that is User x Movie size, each entry a rating
    num_users = max(AllRatings(:,1)); % num users
    max_movies = max(AllRatings(:,2)); % max id movie set (some ids below have no/few ratings)
    
    % find total number of ratings for each movie
    num_ratings = zeros(max_movies, 1);
    for i = 1:total_entries
        num_ratings(AllRatings(i, 2)) = num_ratings(AllRatings(i, 2))+1;
    end
    idxs = (num_ratings>=min_ratings); % indicies of movies that have at least 3 ratings
    
    % Map movie's index to id: 
    % To get movie's index in Ratings matrix, use "find(map==movie_id))"
    % To get movie's id from index in Ratings matrix, use "map(movie_index)"
    map = find(num_ratings>= min_ratings); 
    num_movies = numel(map);
    
    % create ratings matrix
    Ratings = zeros(num_users, num_movies); % (used to be B)
    
    % go through each entry in ratings.csv, and add to Ratings if movie has at
    % least 3 ratings
    for i = 1:total_entries
        % if movie has at least three ratings, then update element in Ratings
        if(idxs(AllRatings(i, 2)))
            Ratings(AllRatings(i, 1), map==AllRatings(i, 2)) = AllRatings(i, 3); % update element in B
        end
    end

    % set zero elements to non-zero column average
    for i = 1:num_movies
        zero_idx = (Ratings(:, i) == 0); % find indices of non-zero values
        nonzero_avg = mean(nonzeros(Ratings(:, i))); % find avg of non-zero values
        Ratings(zero_idx, i) = nonzero_avg; % set zero values to avg
    end
    
    [U, ~, Vt] = tsvd(Ratings,k);  % truncated svd (could use normal svd here, but will need to truncate when dataset gets larger)
    
    % Create User heuristic plot and Movie heuristic plot
    plot_user_movie_heuristics(k, U, Vt)
    
    
    % find movies that are most similar to chosen movie
    movies_sorted = get_nearby_movies(map==chosen_movie_id, Vt); % (pass location of id in Ratings using map)
    
    movies_sorted = movies_sorted(2:k+1, :)
end

