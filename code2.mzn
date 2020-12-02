int: num;
int: cap;
int: refill;
set of int: index;
array[index] of int: fun;

array[index] of var int: p;
array[index] of var int: t;

constraint t[1] = cap;
constraint forall (i in index where i > 1) (
    if t[i-1] - p[i-1] + refill >= cap then t[i] = cap else t[i] = t[i-1] - p[i-1] + refill endif
    );

constraint forall (i in index) (
    p[i] >= 1 /\ p[i] <= t[i]
    );

% redundent constraint 2
    
constraint forall (i in index where i > 1) (
    if fun[i] > fun[i-1] then p[i] >= p[i-1] endif
    /\ if fun[i] < fun[i-1] then p[i] <= p[i-1] endif
    );

solve maximize sum (i in index) (fun[i]*p[i]);

output [show(sum (i in index) (fun[i]*p[i]))];
