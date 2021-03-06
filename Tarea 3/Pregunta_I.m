%% In this part im going to understang how to work with stocastic effetcs 
tic
clear;
clc;
% parameters first
beta = 0.96;
sigma = 2;
rho = 0.96;
sigmamu = 0.12;
delta = 0.05;
alpha = 0.33;
r = 0.03;
w = 1;
states = 5;
A = linspace(0, 30, 1001);
tol = 0.01;

%% a) calculating markov chain, nature states and policy functions

[pro,tr]= discAR(states, rho, sigmamu);
[Cti,Ati,S,Vf,Ap] = value(beta,sigma,r,w,A,tol,pro,tr);

%% b) sorry about this, but im going to steal Pablo's code 
% because time is scarce 

tx= {'Interpreter','Latex','FontSize', 15};

figure (1);
sgtitle('\textbf{Uncertainty: Matrix}',tx{:},'Fontsize',20)

subplot (2,2,1)
d = plot(A,Cti(:,:));
xlabel('Assets',tx{:})
title('\textbf{Consumption}',tx{:})
legend([d(1),d(length(pro))],'$\varepsilon_1 = 0.48$',...
    '$\varepsilon_5 = 1.74$',tx{:},'fontsize',10,'location','SE'); 
d(1).LineWidth = 2;
d(length(pro)).LineWidth = 2;

subplot(2,2,2)
p = plot(A,Ati(:,:));
xlabel('Assets',tx{:})
title('\textbf{Assets}',tx{:})
legend([p(1),p(length(pro))],'$\varepsilon_1$ = 0.48',...
    '$\varepsilon_5 = 1.74$','location','SE',tx{:},'fontsize',10); 
p(1).LineWidth = 2;
p(length(pro)).LineWidth = 2;

subplot(2,2,[3,4])
f = plot(A,Vf(:,:));
xlabel('Assets',tx{:})
title('\textbf{Value function}',tx{:});
legend([f(1),f(length(pro))],'$\varepsilon_1 = 0.48$',...
    '$\varepsilon_5 = 1.74$',tx{:},'fontsize',10,'location','SE'); 
f(1).LineWidth = 2;
f(length(pro)).LineWidth = 2;

%% c) im going to steal again, but i can assure that i know what im doing, so
% go ahead, ask me whatever you want in the final interrogation (Actually,
% i only need to know inputs and ouputs to work with this code, so it is
% not a big deal). But, im only stealing code because i have no time,
% otherwise i would use my own version. However gotta admit that the 
% "value" fuction is awsome.

N = 10000;
T = 2000;

[panel_S_aux,~,e_bar] = distest(N,T,tr,pro);

figure(2)
sgtitle('\textbf{Simulation}','fontsize',20,tx{:})
plot ((1:T),panel_S_aux(1,:))
xlabel('T',tx{:})
set(gca,'ytick',0:5)

%% d) simulating consuption and assets

[Assets, Consuption] = simulate(Ap,Cti,panel_S_aux, A);


Assets = Assets(:,1001:end);
Consuption = Consuption(:,1001:end);

Assets_mean = mean(Assets, 2);
Assets_mean_mean = mean(Assets_mean);
Assets_median = prctile(Assets_mean, 50);
Assets_10 = prctile(Assets_mean, 10);
Assets_90 = prctile(Assets_mean, 90);
Assets_99 = prctile(Assets_mean, 99);

Consuption_mean = mean(Consuption, 2);
Consuption_mean_mean = mean(Consuption_mean);
Consuption_median = prctile(Consuption_mean, 50);
Consuption_10 = prctile(Consuption_mean, 10);
Consuption_90 = prctile(Consuption_mean, 90);
Consuption_99 = prctile(Consuption_mean, 99);

figure(3)
subplot(1,2,1)
hist(Consuption_mean,100)
title("Consuption mean")
subplot(1,2,2)
hist(Assets_mean, 100)
title("Assets mean")

%% e)
Assets_means = [];
Consuption_means = [];
sigmamu_list = linspace(0.1, 0.19, 10);
for sigmamu_i = sigmamu_list
    [pro,tr]= discAR(states, rho, sigmamu_i);
    [Cti,Ati,S,Vf,Ap] = value(beta,sigma,r,w,A,tol,pro,tr);
    [panel_S_aux,~,e_bar] = distest(N,T,tr,pro);
    [Assets, Consuption] = simulate(Ap,Cti, panel_S_aux, A);

    Assets = Assets(:,1001:end);
    Consuption = Consuption(:,1001:end);

    Assets_mean = mean(Assets, 2);
    Assets_means = [Assets_means Assets_mean];

    Consuption_mean = mean(Consuption, 2);
    Consuption_means = [Consuption_means Consuption_mean];

end

[Am, Astd, Ap10, Ap50, Ap90, Ap99] = ownsummary(Assets_means, 1);
[Cm, Cstd, Cp10, Cp50, Cp90, Cp99] = ownsummary(Consuption_means, 1);

figure(4)
e_summary(Assets_means, "Assets")
figure(5)
e_summary(Consuption_means, "Consuption")

%% f)

Assets_means = [];
Consuption_means = [];
rho_list = linspace(0.9, 0.98, 10);
for rho_i = rho_list
    [pro,tr]= discAR(states, rho_i, sigmamu);
    [Cti,Ati,S,Vf,Ap] = value(beta,sigma,r,w,A,tol,pro,tr);
    [panel_S_aux,~,e_bar] = distest(N,T,tr,pro);
    [Assets, Consuption] = simulate(Ap,Cti, panel_S_aux, A);

    Assets = Assets(:,1001:end);
    Consuption = Consuption(:,1001:end);

    Assets_mean = mean(Assets, 2);
    Assets_means = [Assets_means Assets_mean];

    Consuption_mean = mean(Consuption, 2);
    Consuption_means = [Consuption_means Consuption_mean];
end

[Am, Astd, Ap10, Ap50, Ap90, Ap99] = ownsummary(Assets_means, 1);
[Cm, Cstd, Cp10, Cp50, Cp90, Cp99] = ownsummary(Consuption_means, 1);

figure(6)
f_summary(Assets_means, "Assets")
figure(7)
f_summary(Consuption_means, "Consuption")

%% g) now, time to understand the efects on welfare
sigmamu = 0.1;
[pro,tr]= discAR(states, rho, sigmamu);
[Cti,Ati,S,Vf1,Ap] = value(beta,sigma,r,w,A,tol,pro,tr);
[panel_S_aux,~,e_bar] = distest(N,T,tr,pro);
[Assets, Consuption1] = simulate(Ap,Cti, panel_S_aux, A);

sigmamu = 0.15;
[pro,tr]= discAR(states, rho, sigmamu);
[Cti,Ati,S,Vf2,Ap] = value(beta,sigma,r,w,A,tol,pro,tr);
[panel_S_aux,~,e_bar] = distest(N,T,tr,pro);
[Assets, Consuption2] = simulate(Ap,Cti, panel_S_aux, A);

[change, H2, H1] = gfunction(Consuption1(:,1001:end)...
    , Consuption2(:,1001:end), sigma, beta);
%% 
figure(8)
subplot(2,2,1)
histogram((H2 - H1)/(sqrt(var(H2 - H1))), 100)
[t,s] = title('Effective change in welfare (Normalized difference)',...
    'sigma = 0.1 -> sigma = 0.15');
subplot(2,2,2)
histogram(change, 100)
[t,s] = title('Effective change in welfare (Function g(a,e))',...
    'sigma = 0.1 -> sigma = 0.15');
subplot(2,2,3)
hold on
[t,s] = title('Effective Value function',...
    'sigma = 0.1 (Orange) -> sigma = 0.15 (Blue)');
h2 = histogram(H2, 100, 'Normalization', 'probability');
h1 = histogram(H1, 100, 'Normalization', 'probability');
hold off
subplot(2,2,4)
Vdif = (Vf2./Vf1).^(1/(1-sigma)) - 1;
plot(A, Vdif(:,:))
title('Expected change in welfare (Function g(a,e))')
legend('shock 1','','','','shock 5'); 

%%
toc

