% Nama: Dindin Dhino Alamsyah
% NIM : 1301144360

% Input: ID Movie 1 dan ID Movie 2 sebagai parameter input
% Output: Nilai Jaccard Coefficient dari kedua movie yang diinput

function [] = JaccardCoef(IDMovie1,IDMovie2)
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

%     mencari banyaknya user yang mereview kedua movie tersebut
    rateboth = 0;
    rateone = 0;
    for i=1:size(userids,2)
        if(find(ratIDMovie1(:,1)==i))
            if (find(ratIDMovie2(:,1)==i))
                rateboth = rateboth + 1;
            else
                rateone = rateone + 1;
            end
        elseif(find(ratIDMovie2(:,1)==i))
            if(find(ratIDMovie1(:,1)==i))
                rateboth = rateboth + 1;
            else
                rateone =  rateone + 1;
            end
        end
    end

%     meng-output-kan nilai jaccard
    disp(sprintf('Jaccard Coefficient: %0.3f \n', rateboth/(rateone+rateboth)));
end