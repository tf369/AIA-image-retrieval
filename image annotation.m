function q=ReinforcementLearning
clc;
format short
format compact
a=14;
b=15;
% Two input: R and gamma
% immediate reward matrix; 
% row and column = states; -Inf = fasel az markaz seghle object
R=[-inf,-inf,-inf,-inf,   0, -inf;
   -inf,-inf,-inf,   0,-inf, 100;
   -inf,-inf,-inf,   0,-inf, -inf;
   -inf,   0,   0,-inf,   0, -inf;
      0,-inf,-inf,   0,-inf, 100;
   -inf,   0,-inf,-inf,   0, 100];

gamma=0.80;            % learning parameter
xamp=a*b;
q=zeros(size(R));      % meqdar dahi avaliye be matrise Q
q1=ones(size(R))*inf;  % initialize previous Q as big number
count=0; 
episode=xamp% counter
for episode=0:1000
   % random initial state
   y=randperm(size(R,1));
   state=y(1);
   
   % select any action from this state
   x=find(R(state,:)>=0);        % find possible action of this state
   if size(x,1)>0,
      x1=RandomPermutation(x);   % randomize the possible action
      x1=x1(1);                  % select an action 
   end
   qMax=max(q,[],2);
   q(state,x1)= R(state,x1)+gamma*qMax(x1);   % get max of all actions 
   state=x1;
   
   % break if convergence: small deviation on q for 1000 consecutive
   if sum(sum(abs(q1-q)))<0.0001 & sum(sum(q >0))
      if count>1000,
         episode        % report last episode
         break          % for
      else
         count=count+1; % set counter if deviation of q is small
      end
   else
      q1=q;
      count=0; % reset counter when deviation of q from previous q is large
   end
end 
%normalize q
g=max(max(q));
if g>0, 
   q=100*q/g;
end

 
function y=RandomPermutation(A)
 
   [r,c]=size(A);
   b=reshape(A,r*c,1);       
   x=randperm(r*c);          
   w=[b,x'];                 
   d=sortrows(w,2);          
   y=reshape(d(:,1),r,c);    

