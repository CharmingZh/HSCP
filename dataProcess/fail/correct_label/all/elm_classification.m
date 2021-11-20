MTraining=[];
MTesting=[]; 
f=1;
for z=1:500
    disp(['this is ', num2str(z), ' rount'])
Wtrain=xlsread('Wtrain.xlsx');
T=Wtrain(:,1)';
P=Wtrain(:,2:size(Wtrain,2))'; 
Wtest=xlsread('Wtest.xlsx');
TV.T=Wtest(:,1)';
TV.P=Wtest(:,2:size(Wtest,2))';

NumberofTrainingData=size(P,2);
NumberofTestingData=size(TV.P,2);
NumberofInputNeurons=size(P,1);
NumberofHiddenNeurons=60;
sorted_target=sort(cat(2,T,TV.T),2);
label=zeros(1,1);                              
label(1,1)=sorted_target(1,1);
j=1;
    for i = 2:(NumberofTrainingData+NumberofTestingData)
        if sorted_target(1,i) ~= label(1,j)
            j=j+1;
            label(1,j) = sorted_target(1,i);
        end
    end
    number_class=j;
    NumberofOutputNeurons=number_class;
       
    temp_T=zeros(NumberofOutputNeurons, NumberofTrainingData);
    for i = 1:NumberofTrainingData
        for j = 1:number_class
            if label(1,j) == T(1,i)
                break; 
            end
        end
        temp_T(j,i)=1;
    end
    T=temp_T*2-1;
    
    temp_TV_T=zeros(NumberofOutputNeurons, NumberofTestingData);
    for i = 1:NumberofTestingData
        for j = 1:number_class
            if label(1,j) == TV.T(1,i)
                break; 
            end
        end
        temp_TV_T(j,i)=1;
    end
    TV.T=temp_TV_T*2-1;

    start_time_train=cputime;
    InputWeight=rand(NumberofHiddenNeurons,NumberofInputNeurons)*2-1;
    BiasofHiddenNeurons=rand(NumberofHiddenNeurons,1);
    tempH=InputWeight*P;
    clear P;                                           
    ind=ones(1,NumberofTrainingData);
    BiasMatrix=BiasofHiddenNeurons(:,ind);            
    tempH=tempH+BiasMatrix;
    H = 1 ./ (1 + exp(-tempH));
    clear tempH; 
    OutputWeight=pinv(H') * T';  

    end_time_train=cputime;
    TrainingTime=end_time_train-start_time_train;

    Y=(H' * OutputWeight)';
    clear H;

    start_time_test=cputime;
    tempH_test=InputWeight*TV.P;
    clear TV.P;           
    ind=ones(1,NumberofTestingData);
    BiasMatrix=BiasofHiddenNeurons(:,ind);            
    tempH_test=tempH_test + BiasMatrix;
    H_test = 1 ./ (1 + exp(-tempH_test));

    TY=(H_test' * OutputWeight)';                      
   end_time_test=cputime;
   TestingTime=end_time_test-start_time_test;

   MissClassificationRate_Training=0;
   MissClassificationRate_Testing=0;
  
   
    for i = 1 : size(T, 2)
        [x,label_index_expected]=max(T(:,i));
        [x,label_index_actual]=max(Y(:,i));
        G1(1,i)=label_index_actual;
        if label_index_actual~=label_index_expected
            MissClassificationRate_Training=MissClassificationRate_Training+1;
        end
    end
    MTraining(f)=MissClassificationRate_Training;
    
    for i = 1 : size(TV.T, 2)
        [x, label_index_expected]=max(TV.T(:,i));
        [x, label_index_actual]=max(TY(:,i));
        if label_index_actual~=label_index_expected
            MissClassificationRate_Testing=MissClassificationRate_Testing+1;
        end
    end
    MTesting(f)=MissClassificationRate_Testing;
    f=f+1;
    
end
TrainingAccuracy=1-mean( MTraining)/size(T,2);
TestingAccuracy=1-mean( MTesting)/size(TV.T,2);