function [U, S, Vt] = tsvd(A, k)
    % TAKES some matrix A and a truncation value k
    % RETURNS U, S, Vt such that U*S*Vt' is truncated SVD of A
    
    % check size
    [m, n] = size(A);
    if(k> min(m,n))
        fprintf("k=%d too large, must be %d or smaller\n", k, min(m,n));
        return;
    end

    [U_, S_, Vt_] = svd(A,"econ");
    
    U = U_(:, 1:k);
    S = S_(1:k, 1:k);
    Vt = Vt_(:,1:k);
    
   
end