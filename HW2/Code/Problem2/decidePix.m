% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

function [r_res, g_res, b_res] = decidePix(r ,g, b)

cube = MBVQCube(r,g,b);
vertex = getNearestVertex(cube, r, g, b);

switch vertex
    case 'black'
        r_res = 0;
        g_res = 0;
        b_res = 0;
    case 'red'
        r_res = 1;
        g_res = 0;
        b_res = 0;
    case 'green'
        r_res = 0;
        g_res = 1;
        b_res = 0;
    case 'blue'
        r_res = 0;
        g_res = 0;
        b_res = 1;
    case 'yellow'
        r_res = 1;
        g_res = 1;
        b_res = 0;
    case 'magenta'
        r_res = 1;
        g_res = 0;
        b_res = 1;
    case 'cyan'
        r_res = 0;
        g_res = 1;
        b_res = 1;
    case 'white'
        r_res = 1;
        g_res = 1;
        b_res = 1;
end
end