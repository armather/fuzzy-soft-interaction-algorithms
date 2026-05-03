function interation


% INTERACTION
% MATLAB implementation of Algorithms 1–2:
% Interaction function and dominant parameter detection
% for fuzzy soft sets.
%
% The script computes interaction matrices, dominant
% parameters, and produces the figures used in the article.

clc;clear all;

%% Fuzzy soft matrices for three universes
A1=[0.4	0.3	0.2	0.2	0.9;
0.3	1.0	0.1	0.3	0.3;
0.2	0.4	0.5	1.0	0.5;
0.5	0.7	0.3	0.6	0.5;
0.3	0.2	0.4	0.3	0.3;
0.9	0.5	0.6	0.3	0.7;
0.6	0.4	0.8	0.2	0.2;
0.8	0.6	0.5	0.5	0.4;
0.1	0.9	0.4	0.4	0.5;
0.0	0.7	0.2	0.9	0.8;
0.8	0.5	0.6	0.1	0.2;
1.0	0.3	0.4	0.5	0.1];


A2=[0.5	0.7	0.3	0.2	0.1;
0.5	0.6	0.4	0.5	0.9;
0.4	0.2	0.3	0.5	1.0;
0.6	0.3	0.7	0.4	0.8;
0.7	1.0	0.7	0.5	0.4;
0.2	0.6	0.3	0.6	0.4;
1.0	0.3	0.5	0.5	0.7;
0.6	0.8	0.3	0.6	0.2;
0.9	0.3	0.5	0.2	0.7;
0.5	0.6	0.5	0.4	0.2;
0.3	0.6	0.5	0.4	0.3;
0.7	0.5	0.1	0.0	0.2];

A3=[0.7	0.2	0.5	0.7	0.5;
0.3	0.4	0.8	0.7	0.5;
0.6	0.5	0.4	0.8	0.2;
0.1	0.4	0.8	0.9	0.2;
0.4	0.5	0.2	0.4	0.7;
0.3	0.4	0.5	0.7	0.3;
0.2	0.5	0.7	0.2	0.9;
0.2	0.1	0.9	0.8	0.3;
0.4	0.6	0.3	0.8	0.5;
0.4	0.5	0.7	0.9	0.3;
0.2	0.4	0.7	0.8	0.9;
0.2	0.3	0.5	0.6	0.4];


format short

%% Compute interaction matrices
[m n ]=size(A1);% m U- n E leri temsil ediyor!
for i=1:n
    for j=1:n
        gamma1(i,j)=1-sum(abs(A1(:,i)-A1(:,j)))/m;
        gamma2(i,j)=1-sum(abs(A2(:,i)-A2(:,j)))/m;
        gamma3(i,j)=1-sum(abs(A3(:,i)-A3(:,j)))/m;
    end
end

%% Remove diagonal elements (self-interaction)
G1=gamma1-eye(n);
G2=gamma2-eye(n);
G3=gamma3-eye(n);

%% Dominant interaction for each parameter
for i=1:n
    [R1(i),In1(i)]=max(G1(i,:));
    [R2(i),In2(i)]=max(G2(i,:));
    [R3(i),In3(i)]=max(G3(i,:));
end
R=[R1;R2;R3];

%% Pairwise interaction bar chart
k=1;
for i=1:n
    
   
    for j=i+1:n
        gr(k,1)=gamma1(i,j);
        gr(k,2)=gamma2(i,j);
        gr(k,3)=gamma3(i,j);
        k=k+1;
    end
end
PS=figure(1);
grsize=size(gr);
grsizex=1:grsize(1,1);
b=bar(grsizex,gr);
set(gca,'XTickLabel',{'e_1 - e_2';'e_1 - e_3';'e_1 - e_4';'e_1 - e_5';'e_2 - e_3';'e_2 - e_4'; 'e_2 - e_5';'e_3 - e_4'; 'e_3 - e_5'; 'e_4 - e_5'});
legend('\Gamma^1','\Gamma^2','\Gamma^3','Location','southwestoutside')
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
print('fig_PS.eps','-depsc')
%print(figure(1),'-dpsc','fig_PS.eps')
saveas(figure(1),'fig_PS.fig')
In=[In1;In2;In3];

%% Dominant parameter plot
figure(2)
b2=bar(R);
set(gca,'XTickLabel',{'U_1';'U_2';'U_3'})
legend('e_1','e_2','e_3','e_4','e_5','Location','southwestoutside')
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.

print('fig_2.eps','-depsc')
saveas(figure(2),'fig_2.fig')




%% Save results
format bank
save interactionmat gamma1 gamma2 gamma3 In
load interactionmat.mat
% T2 = table(gamma2);
% T3 = table(gamma3);
% filename = 'interactionmat.xlsx';
% writetable(T2,filename,'Sheet',1,'Range','A1')
% writetable(T3,filename,'Sheet',1,'Range','H1')
