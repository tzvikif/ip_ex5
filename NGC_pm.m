function c = NGC_pm(im,pattern)
    c = normxcorr2(pattern,im);
end