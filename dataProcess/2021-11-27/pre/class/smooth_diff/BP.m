%��ȡ����
Wtrain=xlsread('Wtrain_2.xlsx');
Wtest=xlsread('Wtest_2.xlsx');

%�趨ÿ������ź�
outtrain1=Wtrain(:,1);
for i=1:size(Wtrain,1)
    switch outtrain1(i)
        case 1
            outtrain(i,:)=[1 0 0];
        case 2
            outtrain(i,:)=[0 1 0];
        case 3
            outtrain(i,:)=[0 0 1];
    end
end
            
outtest1=Wtest(:,1);
for i=1:size(Wtest,1)
    switch outtest1(i)
        case 1
            outtest(i,:)=[1 0 0];
        case 2
            outtest(i,:)=[0 1 0];
        case 3
            outtest(i,:)=[0 0 1];
    end
end

input_train=Wtrain(:,2:size(Wtrain,2))';
output_train=outtrain';
input_test=Wtest(:,2:size(Wtest,2))';
output_test=outtest';

%BP������ṹ��ʼ��
%����ṹ
innum=size(input_train,1);
midnum=25;
outnum=3;

%Ȩֵ��ֵ��ʼ��
w1=rands(midnum,innum);
b1=rands(midnum,1);
w2=rands(midnum,outnum);
b2=rands(outnum,1);

%BP������ѵ��
for ii=1:60
    E(ii)=0; %ѵ�����
    for i=1:1:268
        
        %ѡ�񱾴�ѵ������
        x=input_train(:,i);
        
        %���������
        for j=1:1:midnum
            I(j)=x'*w1(j,:)'+b1(j);
            Iout(j)=1/(1+exp(-I(j)));
        end
        %��������
        yn=w2'*Iout'+b2;
        
        %Ԥ�����
        e=output_train(:,i)-yn;
        E(ii)=E(ii)+sum(abs(e));
        
        %����w2,b2������
        dw2=e*Iout;
        db2=e';
        
        %����w1,b1������
        for j=1:1:midnum
            S=1/(1+exp(-I(j)));
            FI(j)=S*(1-S);
        end
        for k=1:1:innum
            for j=1:1:midnum
                dw1(k,j)=FI(j)*x(k)*(e(1)*w2(j,1)+e(2)*w2(j,2)+e(3)*w2(j,3));
                db1(j)=FI(j)*(e(1)*w2(j,1)+e(2)*w2(j,2)+e(3)*w2(j,3));
            end
        end
        
        %Ȩֵ��ֵ����
        xite=0.1;
        w1=w1+xite*dw1';
        b1=b1+xite*db1';
        w2=w2+xite*dw2';
        b2=b2+xite*db2';
    end
end

%BP���������
%����Ԥ��
for i=1:132
    for j=1:1:midnum
            I(j)=input_test(:,i)'*w1(j,:)'+b1(j);
            Iout(j)=1/(1+exp(-I(j)));
    end 
    %Ԥ����
    fore(:,i)=w2'*Iout'+b2;
end

%���ͳ��
for i=1:132
    output_fore(i)=find(fore(:,i)==max(fore(:,i)));
end

%Ԥ�����
error=output_fore-outtest1';
k=zeros(1,3);
%ͳ�����
for i=1:132
    if error(i)~=0
        [b,c]=max(output_test(:,i));
        switch c
            case 1
                k(1)=k(1)+1;
            case 2
                k(2)=k(2)+1;
            case 3
                k(3)=k(3)+1;
        end
    end
end
