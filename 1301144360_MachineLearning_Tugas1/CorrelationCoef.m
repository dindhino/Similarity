% Nama: Dindin Dhino Alamsyah
% NIM : 1301144360

% Input: ID Movie 1 dan ID Movie 2 sebagai parameter input
% Output: Nilai Correlation Coefficient dari kedua movie yang diinput

function [TabelRate] = CorrelationCoef(IDMovie1, IDMovie2)
%     load data
    [ratings, items, userids, itemids] = loadmovielens();
    
%     meng-output-kan nama film sesuai ID inputan
    disp(sprintf('Movie 1: %s \n', items{1,IDMovie1}));
    disp(sprintf('Movie 2: %s \n', items{1,IDMovie2}));

%     sorting ratings
    rowsIDMovie1 = ratings(:,2)==IDMovie1;
    rowsIDMovie2 = ratings(:,2)==IDMovie2;
    ratIDMovie1 = ratings(rowsIDMovie1,:);
    ratIDMovie2 = ratings(rowsIDMovie2,:);

%     memasukan ke tabel hanya untuk yang di rate dua duanya
%     n untuk jumlah user yang merating keduanya
%     TabelRate adalah tabel yang berisi rate untuk kedua film tersebut
%     beserta dengan perhitungan dari sumX, sumY, sumX^2, sumY^2, sumXY
    n = 0; TabelRate=[];
    for i=userids
        if(find(ratIDMovie1(:,1)==i))
            if (find(ratIDMovie2(:,1)==i))
                n = n+1;
                TabelRate(n,1) = n; %data ke-n
                TabelRate(n,2) = ratIDMovie1(ratIDMovie1(:,1)==i,3); %x
                TabelRate(n,3) = ratIDMovie2(ratIDMovie2(:,1)==i,3); %y
                TabelRate(n,4) = TabelRate(n,2) * TabelRate(n,2); %x^2
                TabelRate(n,5) = TabelRate(n,3) * TabelRate(n,3); %y^2
                TabelRate(n,6) = TabelRate(n,2)*TabelRate(n,3); %xy
            end
        end
    end
    
%     menjumlahkan perkolom untuk mengambil semua data
    TabelRate(n+1,:) = sum(TabelRate); %total penjumlahan n | x | y | x^2 | y^2 | xy

%     bila tabel 0, maka tidak akan diproses
    if(length(TabelRate) ~= 1)
        nXY = n*TabelRate(n+1,6);
        sumXsumY = TabelRate(n+1,2)*TabelRate(n+1,3);
        nX2minX2 = (n*TabelRate(n+1,4)) - (TabelRate(n+1,2)*TabelRate(n+1,2));
        nY2minY2 = (n*TabelRate(n+1,5)) - (TabelRate(n+1,3)*TabelRate(n+1,3));

        pembilang = nXY - sumXsumY; 
        penyebut = sqrt(nX2minX2) * sqrt(nY2minY2); 

        r = pembilang / penyebut;

        disp(sprintf('Correlation Coefficient: %0.3f \n', r));
    else
        disp('Correlation Coefficient: 0');
    end
end