for i = 2:m
    if(A(i, 2) < 7)
        plot(x(:), A(i, 3:n), 'k');
        hold on
    else
        plot(x(:), A(i, 3:n), 'r');
        hold on
    end
end