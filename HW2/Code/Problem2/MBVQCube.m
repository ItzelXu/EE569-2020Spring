% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

function cube = MBVQCube(r,g,b)
if((r+g)>(255/255))
    if((g+b)>(255/255))
        if((r+g+b)>(510/255))
            cube='CMYW';
        else
            cube='MYGC';
        end
    else
        cube='RGMY';
    end
else
    if(~((g+b)>(255/255)))
        if(~((r+g+b)>(255/255)))
            cube='KRGB';
        else
            cube='RGBM';
        end
    else
        cube='CMGB';
    end
end     
end