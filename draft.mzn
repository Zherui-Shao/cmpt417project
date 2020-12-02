% Use this editor as a MiniZinc scratch book
int: num = 7;
int: cap = 6;
int: refill = 3;
% int: K = 500;
set of int: index = 1..num;
% set of int: index2 = 2..num;
array[index] of int: fun = [5,2,7,9,9,2,10];

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

% huriostic
    
% constraint forall (i in index) (
%     if fun[i] < 0 then p[i] = 1 endif
%     );
    
% constraint forall (i in index where i > 1) (
%     if fun[i] > fun[i-1] then p[i] >= p[i-1] endif
%     /\ if fun[i] < fun[i-1] then p[i] <= p[i-1] endif
%     );
    
% constraint forall (i in index where i > 1) (
%     if fun[i] < fun[i-1] then p[i] <= p[i-1] endif
%     );
    
% constraint forall (i in index) (
%       forall (j in index) (
%       if fun[i] < fun[j] then p[i] <= p[j] endif
%       )
%     );
    
% constraint sum (i in index) (fun[i]*p[i]) >= K;

% solve satisfy

solve maximize sum (i in index) (fun[i]*p[i]);

output [show(sum (i in index) (fun[i]*p[i]))];

% output [show(p)];
% output [show(t)];

