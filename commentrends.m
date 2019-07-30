



function commentrends(X,Y,varargin)
%X represents the stockcodes of the treatment-group stocks,it's a column
% vector

%Y represents the dependent variables which we wanna know how the event has
%influenced it. The first column is stockcodes and other column is the data
%organized by the time

%the number of independent variables is variable to theories and topic, so I
%use varargin here and the data is organized like dependent variables

%k---number of independent variables
k=numel(varargin);



%%%%%%%1. delete unlist stock & min-max data standardization

% dependent variable
locdeletey=isnan(Y(:,2));%deleting the companies which are unlisted when the event study periods started
Y(locdeletey,:)=[];
[ry,cy]=size(Y);
for i=1:ry
    Y(i,2:cy)=fillmissing(Y(i,2:cy),'previous'); %fill missing values with previous month's value
end
Ystd=Y(:,2:cy);
Ystd=Ystd-min(Ystd(:));
Ystd = Ystd ./ max(Ystd(:));
Y(:,2:cy)=Ystd;

% independent varialbles
for i=1:k
    locdeletex=isnan(varargin{i}(:,2)); %deleting the companies which are unlisted when the event study periods started
    varargin{i}(locdeletex,:)=[];
    [rx,cx]=size(varargin{i});
    for m=1:rx
        varargin{i}(m,2:cx)=fillmissing(varargin{i}(m,2:cx),'previous'); %fill missing values with previous month's value
    end
    Xstd=varargin{i}(:,2:cx); %min-max standardization of x
    Xstd=Xstd-min(Xstd(:));
    Xstd = Xstd ./ max(Xstd(:));
    varargin{i}(:,2:cx)=Xstd;
end


%%%%%%%2. separate the data of the treatment stocks and the control pool stocks

%dependent variable

locy=ismember(Y(:,1),X);
Ylist=Y(locy,:);   %Ylist represents the data of treatment group
Ycontrolpool=Y;
Ycontrolpool(locy,:)=[]; %Ycontrolpool represents the data of control pool 



%independent variables



loc=cell(k,1);
for n=1:k
    loc{n}=ismember(varargin{n}(:,1),X);
    xlist{n}=varargin{n}(loc{n},:); %Xlist represents the data of treatment group
    xcontrolpool{n}=varargin{n};
    xcontrolpool{n}(loc{n},:)=[]; %Xcontrolpool represents the data of control pool 
end


%%%%%%%%%3. distance matrix
% calculate each stock(in the control pool)'s distance to every stock in
% the treatment group, so every stock in the treatment group should have
% one stock in the control pool which has the smallest distance to it 
[rl,cl]=size(xlist{n});
[rc,cc]=size(xcontrolpool{n});

dist=zeros(rc,rl); %setting distance matrix
for n=1:k
for i=1:rc
    for j=1:rl
        dist(i,j)=dist(i,j)+(xlist{n}(j,2:cl)-xcontrolpool{n}(i,2:cc))*(xlist{n}(j,2:cl)-xcontrolpool{n}(i,2:cc))';
    end
end
v=1;
dist=abs(dist);
[distorder,idx]=sort(dist);

%%%%%%%%4. Deleting the repeated stocks and rechosing
%since two or more stocks in the treatment group may have the same matching
%stock in the control pool, so we have to keep one and rechosing for others


stockctr=idx(1,:);
j=2;
while length(stockctr)~=length(unique(stockctr))
i=2;
while i<=rl
 m=1;
   while m<i
      if stockctr(m)~=stockctr(i)
         m=m+1;
      else
         stockctr(i)=idx(j,i);
         m=m+1;
      end
   end
   i=i+1;
end
j=j+1;
end
stockctr=stockctr.'
% transform the order in to stockcode
stkcodectr=zeros(rl,1);
ctrall=Y(:,1);
for h=1:rl
     stkcodectr(h)=ctrall(stockctr(h));
end
stkcodectr
end



