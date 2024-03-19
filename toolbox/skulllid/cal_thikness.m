% 模板表格
tbl0 = readtable('loc.xlsx');
tbl = readtable('positionList_ISI.xlsx');
tbl = join(tbl0(:,{'channel', 'elec_id', 'R', 'G', 'B'}),tbl, 'Keys','channel');
center = tbl{:,{'skull_x' 'skull_y' 'skull_z'}};
%%
surf = stlread('skull_lower_surf.stl');
for i = 1:length(center)

    [d, ind] = min(vecnorm(surf.Points - center(i,:),2,2));
    tbl{i, 'dura_x'} = surf.Points(ind,1);
    tbl{i, 'dura_y'} = surf.Points(ind,2);
    tbl{i, 'dura_z'} = surf.Points(ind,3);
    tbl{i,'skull_thickness'} = d;
    tbl{i,'screw_length'} = floor(d/0.5) * 0.5;
end
lower_thr = 2;
flag_to_fix = (tbl{:,'skull_thickness'} - tbl{:,'screw_length'} < 0.2) | tbl{:,'skull_thickness'} < lower_thr;
lower_thr_v = lower_thr*ones(sum(flag_to_fix),1);
tbl{flag_to_fix, 'screw_length'}...
    = max([tbl{flag_to_fix, 'screw_length'}-0.5, lower_thr_v], [], 2);

writetable(tbl,'loc.xlsx');

diary('screw_list.txt')
tabulate(tbl{:,'screw_length'})
diary off;