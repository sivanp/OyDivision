%this function switches \ into /
function [switched]= switchSlashes(str)
switched='';
[matchstr splitstr] = regexp(str, '\', 'match','split');
for i=1:length(splitstr)
    a=splitstr{i};
    switched(end+1:end+length(a))=a;
    switched(end+1)='/';
end
switched=switched(1:end-1);    
end
    