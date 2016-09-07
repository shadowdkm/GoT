function color=house2color(index)
            if index==6, H='Stk'; color=[0.88,0.88,0.88];
        elseif index==5, H='Grj'; color=[0.50,0.50,0.50];
        elseif index==4, H='Lts'; color=[0.96,0.80,0.80];
        elseif index==3, H='Tyr'; color=[0.80,0.96,0.80];
        elseif index==2, H='Brt'; color=[0.96,0.96,0.80];
        elseif index==1, H='Drn'; color=[0.96,0.88,0.80];
          else color=[0.9,0.9,0.9]; 
            end
        
%         color=color/2;
end