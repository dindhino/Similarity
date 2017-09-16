% Nama: Dindin Dhino Alamsyah
% NIM : 1301144360

% Input: ID Movie sebagai parameter input
% Output: 5 tertinggi nilai Jaccard Coefficient

function [] = JaccardCoef5High(IDMovie)
%     load data
    [ratings, items, userids, itemids] = loadmovielens();
    
%     meng-output-kan nama film sesuai ID inputan
    disp(sprintf('Movie: %s \n', items{1,IDMovie}));

%     memasukan list rating dengan id movie inputan
    rowsid = ratings(:,2)==IDMovie;
    ratid = ratings(rowsid,:);

    %loop semua id movie yang ada terhadap id movie yang di-input
    %kecuali dengan id movie yang di-input
    nilaijaccard=[]; film=[];
    for i=1:length(items)
        if(i~=IDMovie) %apabila i tidak sama dengan id movie inputan
            rowsid2 = ratings(:,2)==i;
            ratid2 = ratings(rowsid2,:);

            rateboth = 0;
            rateone = 0;
            for k=1:size(userids,2)
                if(find(ratid(:,1)==k))
                    if (find(ratid2(:,1)==k))
                        rateboth = rateboth + 1;
                    else
                        rateone = rateone + 1;
                    end
                elseif(find(ratid2(:,1)==k))
                    if(find(ratid(:,1)==k))
                        rateboth = rateboth + 1;
                    else
                        rateone =  rateone + 1;
                    end
                end
            end
            jaccard = rateboth/(rateone+rateboth);

%             memasukan nilai jaccard dan film kedalam array
            nilaijaccard = [nilaijaccard jaccard];
            film = [film i];
        end
    end

%     sorting descending berdasarkan nilaijaccard
    [nilaijaccard, urutan] = sort(nilaijaccard, 'descend');
    film = film(urutan);
    
%     menampilkan lima terbesar
    disp(sprintf('No \t Nilai Jaccard Coefficient \t Film \n'));
    for i=1:5
        disp(sprintf('%i \t %0.3f \t\t\t\t\t\t %s \n', i, nilaijaccard(1,i), items{film(1,i)}));
    end
end