function y = normalizar(V)

[f, c] = size(V);

y = [];

for i = 1 : c,
    y(:,i) = V(:, i) ./norm(V(:,i));
end
