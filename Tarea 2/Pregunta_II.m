%% Question II
clear; clc;

% parameters
T = 70;
b = 0.96;
sigma = 2;
delta = 0.1;
alpha = 1/3;
r = (1 - b)/b;
h = 11111111110;

% wage vector
wf = @(r) (1 - alpha)*(alpha/(r + delta))^(alpha/(1 -alpha));
w = wage(r, T, alpha, delta);

% creating my asets grill
A = linspace(-15,25, 1001);

%% g) i created the function in a specific script
% h) assets suply and capital demand
r0 = 0.04;
r1 = 0.12;
Assets_suply = [];
Capital_demand = [];
iteration = 1;
r_vector = linspace(r0,r1,10);

L = Laboral_suply(T);

for r_iter = r_vector 
w = wage(r_iter, T, alpha, delta);
[Copt, Vopt, Aopt] = V(A, r_iter, w, T, b, sigma, h);

Assets_suply(iteration) = sum(Aopt(2:end))/T;
Capital_demand(iteration) = fisher(r_iter, delta, alpha, L);

iteration = iteration + 1;
end


subplot(1,3, 1)
plot(r_vector, Assets_suply);
title("Assets suply")
xlabel("Interest rate")

subplot(1,3, 2)
plot(r_vector, Capital_demand);
title("Capital demand")
xlabel("Interest rate")

subplot(1,3, 3)
plot(r_vector, Capital_demand, r_vector, Assets_suply);
title("Suply and Demand")
xlabel("Interest rate")
legend("Demand", "Suply")


%% i)

re = BS(@(r) Auxdelta(r, T, b, sigma, A, delta, alpha, h), 0.01, 0.20);
w = wage(re, T, alpha, delta);

%%
[Copt, Vopt, Aopt] = V(A, re, w, T, b, sigma, h);

Aoptp = circshift(Aopt, -1);
Copt1 = w + (1 + re)* Aopt - Aoptp; 
plot(1:T, Aopt, 1:T, Copt1, 1:T, w)
xlabel("T")
legend("Assets", "consuption", "Wage")

%% j)
hvector = linspace(0, 5, 6);

Cons_matrix = [];
Aset_matrix = [];
Wage_matrix = [];
re_vector = [];

for hi = hvector
re = BS(@(r) Auxdelta(r, T, b, sigma, A, delta, alpha, hi), 0.01, 0.20);
re_vector = [re_vector re];
w = wage(re, T, alpha, delta);

[Copt, Vopt, Aopt] = V(A, re, w, T, b, sigma, hi);
Aoptp = circshift(Aopt, -1);
Copt = w + (1 + re)* Aopt - Aoptp; 
Cons_matrix = [Cons_matrix Copt'];
Aset_matrix = [Aset_matrix Aopt'];
Wage_matrix = [Wage_matrix w'];
end

%%
hold on
for i = 1:length(hvector)
txt = strcat("interest rate = ", num2str(re_vector(i)), ...
    " and h =", num2str(hvector(i)));
plot(1:T, Cons_matrix(:, i), "DisplayName",txt)
title("Consuption")
legend show
end
hold off

%%
hold on
for i = 1:length(hvector)
txt = strcat("interest rate = ", num2str(re_vector(i)), ...
    " and h =", num2str(hvector(i)));
plot(1:T, Aset_matrix(:, i), "DisplayName",txt)
title("Assets")
legend show
end
hold off

%%
hold on
for i = 1:length(hvector)
txt = strcat("interest rate = ", num2str(re_vector(i)), ...
    " and h =", num2str(hvector(i)));
plot(1:T, Wage_matrix(:, i), "DisplayName",txt)
title("Wage")
legend show
end
hold off

%%
ci_corr = [];
for i = 1:length(hvector)
    ci_corr = [ci_corr corrp(Cons_matrix(:, i), Wage_matrix(:, i))];
end

plot(hvector, ci_corr);
title("Restriction effects in consuption income correlation")
xlabel("the bigger the number the less restricted")
ylabel("Cons Income Correlation")

%% Auxiliar functions

function dif = Auxdelta(r, T, b, sigma, A, delta, alpha, h)
dif = AuxA(r, T, b, sigma, A, alpha, delta, h) - AuxK(r, T, delta, alpha);
end

function Aux_A = AuxA(r, T, b, sigma, A, alpha, delta, h)
w = wage(r, T, alpha, delta);
[Copt, Vopt, Aopt] = V(A, r, w, T, b, sigma, h);
Aux_A = sum(Aopt(2:end))/T;
end

function Aux_K = AuxK(r, T, delta, alpha)
L = Laboral_suply(T);
Aux_K = fisher(r, delta, alpha, L);
end

function w = wage(r, time, alpha, delta)
w = [];
for t = 1:time
aux1 = 40/(0.4*t*sqrt(2*pi));
aux2 = -(0.5)*((log(t) - log(32.5))/0.4)^2;
w(t) = aux1 * exp(aux2) + 0.4;
end

aux3 = (1 - alpha)*(alpha/(r + delta))^(alpha/(1 -alpha));
w = w*aux3;
end
