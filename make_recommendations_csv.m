clear;


num_recommendations = 3;

% following three array choices for presentation
chosen_movie_ids = [89745, 594, 1213, 111113, 8533];% avengers, snow white, goodfellas, neighbors, the notebook

k_values = [3, 10, 20, 50, 100];
min_rating_values = [1, 3, 5, 10];


num_min_rating_values = numel(min_rating_values);
num_k_values = numel(k_values); 


num_rows = numel(chosen_movie_ids)*num_k_values*num_min_rating_values;

% for storing in table
all_recommended_movies = strings(num_rows, num_recommendations);
all_chosen_movie_names = strings(num_rows, 1);
all_k_values = zeros(num_rows, 1);
all_min_ratings_values = zeros(num_rows, 1);

chosen_movie_names = get_movie_names(chosen_movie_ids);


% loop through all choices of movies
for i = 1:numel(chosen_movie_ids)
    chosen_movie_id = chosen_movie_ids(i);
    chosen_movie_name = chosen_movie_names(i);

    % loop through all choices of k values
    for j = 1:numel(min_rating_values)
        min_ratings_value = min_rating_values(j);
       
        % loop through all cohices of min rating filers
        for k = 1:numel(k_values)
            k_value = k_values(k);

            % set values in columns that will create csv
            current_row = k+(j-1)*num_k_values+(i-1)*num_k_values*num_min_rating_values;
            all_chosen_movie_names(current_row) = chosen_movie_name;
            all_k_values(current_row) = k_value;
            all_min_ratings_values(current_row) = min_ratings_value;

            % get recommended movies
            [recommended_movies_sorted, map] = recommend_movies(chosen_movie_id, min_ratings_value, k_value, num_recommendations);
            recommended_movie_names = get_movie_names(map(recommended_movies_sorted(:, 1)));
            
            % set value in column that will make csv
            all_recommended_movies(current_row, :) = recommended_movie_names;

        end

    end

end

% create table containing columns created above
Recommendations = table( all_chosen_movie_names,  all_min_ratings_values, all_k_values, all_recommended_movies);
Recommendations.Properties.VariableNames = ["Chosen Movie", "Min Ratings Filter", "K values", "Recommended Movies"];

writetable(Recommendations, "Recommendations.csv") % create output csv

