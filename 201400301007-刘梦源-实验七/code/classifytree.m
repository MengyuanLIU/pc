function [class]=classifytree(data,tree)
class = -1;
while 1
    if strcmp(tree,'null')
        break;
    end
    value=tree.value;
    class=value;
    disp('index');
    disp(value);
    next=data(value);
    if next==0
        tree=tree.ll;
    else if next==1
            tree=tree.l;
        else if next==2
                tree=tree.r;
            else if next==3       
                    tree=tree.rr;
                end
            end
        end
    end
end
end

