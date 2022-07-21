function feat   = computefeatures(structdis)

if (isempty(find(structdis ~= 0)))
    disp('*** all 0 patch ***');
    feat = Inf * ones(18,1);
else

    shifts                   = [ 0 1;1 0 ; 1 1; -1 1];

    [alpha leftstd rightstd] = estimateaggdparam(structdis(:));
    feat                     = [alpha ;(leftstd^2+ rightstd^2)/2]; 

    for itr_shift =1:4

    shifted_structdis        = circshift(structdis,shifts(itr_shift,:));
    pair                     = structdis(:).*shifted_structdis(:);
    [alpha leftstd rightstd] = estimateaggdparam(pair);
    const                    = (sqrt(gamma(1/alpha))/sqrt(gamma(3/alpha)));
    meanparam                = (rightstd-leftstd)*(gamma(2/alpha)/gamma(1/alpha))*const;
    feat                     = [feat; alpha; meanparam; leftstd^2 ;rightstd^2];
   

    end
end
    
