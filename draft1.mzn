int: num = 10;
int: cap = 10;
int: refill = 5;
set of int: index = 1..num;
array[index] of int: fun = [-2,-1,-3,-2,-1,-5,-2,-4,-1,-3];

% array[index] of var 1..cap: p;
% array[index] of var refill..cap: t;

array[index] of var int: p;
array[index] of var int: t;

constraint t[1] = cap;
constraint forall (i in index where i > 1) (
    if t[i-1] - p[i-1] + refill >= cap then t[i] = cap else t[i] = t[i-1] - p[i-1] + refill endif
    );

constraint forall (i in index) (
    p[i] >= 1 /\ p[i] <= t[i]
    );

% redundent constraints
    
% constraint forall (i in index) (
%     if fun[i] < 0 then p[i] = 1 endif
%     );
    
constraint forall (i in index where i > 1) (
    if fun[i] > fun[i-1] then p[i] >= p[i-1] endif
    /\ if fun[i] < fun[i-1] then p[i] <= p[i-1] endif
    );

solve maximize sum (i in index) (fun[i]*p[i]);

output [show(sum (i in index) (fun[i]*p[i]))];
