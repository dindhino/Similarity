% Nama: Dindin Dhino Alamsyah
% NIM : 1301144360

% Input: ID Movie sebagai parameter input
% Output: 5 tertinggi nilai Correlation Coefficient

function [] = CorrelationCoef5High(IDMovie)
%     load data
    [ratings, items, userids, itemids] = loadmovielens();
    
%     meng-output-kan nama film sesuai ID inputan
    disp(sprintf('Movie: %s \n', items{1,IDMovie}));

%     memasukan list rating dengan id movie inputan
    rowsid = ratings(:,2)==IDMovie;
    ratid = ratings(rowsid,:);

    %loop semua id movie yang ada terhadap id movie yang di-input
    %kecuali dengan id movie yang di-input
    col=1;
    disp(sprintf('No \t Nilai Correlation Coefficient \t Film \n'));
    for i=1:length(items)
        if(i~=IDMovie) %apabila i tidak sama dengan id movie inputan
            rowsid2 = ratings(:,2)==i;
            ratid2 = ratings(rowsid2,:);

            n = 0; TabelRate=[];
           for k=userids
                if(find(ratid(:,1)==k))
                    if(find(ratid2(:,1)==k))
                        n = n+1;
                        TabelRate(n,1) = n; %data ke-n
                        TabelRate(n,2) = ratid(ratid(:,1)==k,3); %x
                        TabelRate(n,3) = ratid2(ratid2(:,1)==k,3); %y
                        TabelRate(n,4) = TabelRate(n,2) * TabelRate(n,2); %x^2
                        TabelRate(n,5) = TabelRate(n,3) * TabelRate(n,3); %y^2
                        TabelRate(n,6) = TabelRate(n,2)*TabelRate(n,3); %xy
                    end
                end
           end

%             menjumlahkan perkolom untuk mengambil semua data
            TabelRate(n+1,:) = sum(TabelRate); %total penjumlahan n | x | y | x^2 | y^2 | xy

%             kalau ukuran tabel = 0, maka tidak akan diproses
            if(length(TabelRate) ~= 1)
                nXY = n*TabelRate(n+1,6);
                sumXsumY = TabelRate(n+1,2)*TabelRate(n+1,3);
                nX2minX2 = (n*TabelRate(n+1,4)) - (TabelRate(n+1,2)*TabelRate(n+1,2));
                nY2minY2 = (n*TabelRate(n+1,5)) - (TabelRate(n+1,3)*TabelRate(n+1,3));
                pembilang = nXY - sumXsumY; 
                penyebut = sqrt(nX2minX2) * sqrt(nY2minY2);  
                r = pembilang / penyebut;

%                 mencari korelasi koefisien 1
%                 karena ikatan yang kuat adalah ikatan yang memiliki
%                 korelasi koefisien 1
                if(and(r==1,col<=5))
                    disp(sprintf('%i \t %0.3f \t\t\t\t\t\t\t %s \n', col, r, items{i}));
                    col=col+1;
                end
            else
                r=0;
            end   
        end
    end
end