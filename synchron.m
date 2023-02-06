nn=size(set,2);
aas=[];
sumr=0;
for k=1:nn
siteseta=[siteseta0,set(k)];
m=size(siteseta,2);
tt=9;
[~,~,~,inf,~,~] = hilemd(set(k),1,tt);
inf=inf(tt,:);
inf(inf<0)=[];
nf=size(inf,2);
sync=[];
for kk=1:nf
ff=[f0,inf(kk)];
cors=zeros(m);
for i=1:m
for j=1:m
r=find(siteseta(i)==site9);
c=find(siteseta(j)==site9);
cors(i,j)=covariance9(r,c);
end
end
a0=m;
t=0:0.001:5;
n=size(t,2);
theta0=2*pi*rand(m,1)';
theta_all=zeros(n,m);
theta_all(1,:)=theta0;
r=[];
for tt=2:n
for s=1:m
cor=0;
for s2=1:m
cor=cor+35*cors(s,s2)*sin(theta_all(tt-1,s2)-theta_all(tt-1,s));
end
theta_all(tt,s)=(ff(s)+cor)*0.01+theta_all(tt-1,s);
end
r0=sum(exp(1i*theta_all(tt,[1:a0])))/a0/exp(1i*mean(theta_all(tt,[1:a0])));
r=[r,abs(r0)];
end
sync=[sync,mean(r(1000:5000))];
end
[aa,bb]=max(sync);
sumr=[sumr,aa];
if aa>0.997 %|| sumr(k)<sumr(k-1)-0.005
    siteseta0=siteseta;%(end)=[];
%else
    f0=[f0,inf(bb)];
end
aas=[aas,aa];
aa;
end