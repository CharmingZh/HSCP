%读取文件
Wtrain=xlsread('F:\基于高光谱成像技术的树种识别\平滑光谱\Wtrain.xlsx');
Wtest=xlsread('F:\基于高光谱成像技术的树种识别\平滑光谱\Wtest.xlsx');
Xcal=Wtrain(:,2:size(Wtrain,2));
ycal=Wtrain(:,1);
Xval=Wtest(:,2:size(Wtest,2));
yval=Wtest(:,1);

%设置参数
m_min=10; m_max=30; autoscaling=1;

if ((autoscaling ~= 1) & (autoscaling ~= 0));
    error('Please choose whether or not to use autoscaling.')
end

N = size(Xcal,1); % Number of calibration objects
K = size(Xcal,2); % Total number of variables

if length(m_min) == 0, m_min = 1; end 
if length(m_max) == 0, 
    if size(Xval,1) > 0
        m_max = min(N-1,K); 
    else
        m_max = min(N-2,K); 
    end
end 

if m_max > min(N-1,K)
    error('m_max is too large !');
end

% Phase 1: Projection operations for the selection of candidate subsets
if autoscaling == 1
    normalization_factor = std(Xcal);
else
    normalization_factor = ones(1,K);
end
    
for k = 1:K
    x = Xcal(:,k);
    Xcaln(:,k) = (x - mean(x)) / normalization_factor(k);%数据标准化
end

SEL = zeros(m_max,K);

for k = 1:K
    X_projected = Xcaln;
    norms = sum(X_projected.^2); % Square norm of each column vector
    norm_max = max(norms);% Norm of the "largest" column vector
    X_projected(:,k) = X_projected(:,k)*2*norm_max/norms(k); % Scales the kth column so that it becomes the "largest" column
    [dummy1,dummy2,order] = qr(X_projected,0); 
    SEL(:,k)=order(1:m_max)';
end

% Phase 2: Evaluation of the candidate subsets according to the PRESS criterion
PRESS = Inf*ones(m_max,K);
NV = size(Xval,1);
for k = 1:K
    for m = m_min:m_max
        var_sel = SEL(1:m,k);
        [yhat,e] = validation(Xcal,ycal,Xval,yval,var_sel);
        PRESS(m,k) = e'*e; %误差的平方
    end
end

[PRESSmin,m_sel] = min(PRESS);
[dummy,k_sel] = min(PRESSmin);
var_sel_phase2 = SEL(1:m_sel(k_sel),k_sel);

% Phase 3: Final elimination of variables

% Step 3.1: Calculation of the relevance index
Xcal2 = [ones(N,1) Xcal(:,var_sel_phase2)]; 
b = Xcal2\ycal; % MLR with intercept term
std_deviation = std(Xcal2);
relev = abs(b.*std_deviation');
relev = relev(2:end); % The intercept term is always included
% Sorts the selected variables in decreasing order of "relevance"
[dummy,index_increasing_relev] = sort(relev); % Increasing order
index_decreasing_relev = index_increasing_relev(end:-1:1); % Decreasing order

% Step 3.2: Calculation of PRESS values
for i = 1:length(var_sel_phase2)
    [yhat,e] = validation(Xcal,ycal,Xval,yval,var_sel_phase2(index_decreasing_relev(1:i)) );
    PRESS_scree(i) = e'*e;
end
RMSEP_scree = sqrt(PRESS_scree/length(e));
figure, grid, hold on
plot(RMSEP_scree)
xlabel('Number of variables included in the model'),ylabel('RMSE')

% Step 3.3: F-test criterion
PRESS_scree_min = min(PRESS_scree);
alpha = 0.25;
dof = length(e); % Number of degrees of freedom
fcrit = finv(1-alpha,dof,dof); % Critical F-value
PRESS_crit = PRESS_scree_min*fcrit;
% Finds the minimum number of variables for which PRESS_scree
% is not significantly larger than PRESS_scree_min 
i_crit = min(find(PRESS_scree < PRESS_crit)); 
i_crit = max(m_min,i_crit); % The number of selected variables must be at least m_min

var_sel = var_sel_phase2( index_decreasing_relev(1:i_crit) );
title(['Final number of selected variables: ' num2str(length(var_sel)) '  (RMSE = ' num2str(RMSEP_scree(i_crit)) ')'])

% Indicates the selected point on the scree plot
plot(i_crit,RMSEP_scree(i_crit),'s')

disp('Phase 3 (final elimination of variables) completed !')

% Presents the selected variables 
% in the first object of the calibration set
figure,plot(Xcal(1,:));hold,grid
plot(var_sel,Xcal(1,var_sel),'s')
legend('First calibration object','Selected variables')
xlabel('Variable index')
train=Xcal(:,var_sel);
test=Xval(:,var_sel);