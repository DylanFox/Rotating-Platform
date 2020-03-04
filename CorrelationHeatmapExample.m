% Correlation Matrix Examples 

X = F1777_filt(:,[9:34]);   %Only single value parameters 

%Correlation function doesn't work with tables - convert to matrix 
X = table2cell(X);
X = cell2mat(X);

%Correlation - can be changed to spearman and such 
[rho,pval] = corr(X,'rows','pairwise','type','Kendall');
% To only get lower triangle 
rho = tril(rho); 
pval = tril(pval); 
pval(pval==0) = NaN; 
rho(rho==0) = NaN; 

XNames = F1777_filt.Properties.VariableNames(9:34);
YNames = F1777_filt.Properties.VariableNames(9:34);
figure ('Name','Correlation_rho')
h = heatmap(XNames,YNames,rho);
figure ('Name','Correlation_pval')
h1 = heatmap(XNames,YNames,pval);

%tweak graph visuals
h.MissingDataLabel = ''; 
h.MissingDataColor = [0.94,0.94,0.94]; 
h.GridVisible = 'off'

h1.MissingDataLabel = ''; 
h1.MissingDataColor = [0.94,0.94,0.94]; 
h1.GridVisible = 'off'