function writeElectrodes(skullelectrodes, path, O_q, Fp_q)
% edit by lipzh@shanghaitech.edu.cn on 2023-10-18

    extn = '';
    posListFileName = [path '/positionList_ISI',extn,'.xlsx'];
    cor_brain = cat(2,skullelectrodes.pos)';
    cor_skull = cat(2,skullelectrodes.skull)';
    tbl = table;
    tbl.channel = {skullelectrodes.name}';
    tbl.brain_x = -cor_brain(:,2);
    tbl.brain_y = cor_brain(:,1);
    tbl.brain_z = cor_brain(:,3);
    tbl.skull_x = -cor_skull(:,2);
    tbl.skull_y = cor_skull(:,1);
    tbl.skull_z = cor_skull(:,3);
    writetable(tbl, posListFileName, 'Sheet',['Chan' num2str(height(tbl))]);    



%     extn = '';
%     posListFileName = [path '/positionList_ISI',extn,'.txt'];
%     fid = fopen(posListFileName, 'w');
%     if fid == -1
%         error('Author:Function:OpenFile', 'Cannot open file: %s', posListFileName);
%     end
% 
%     hdrLine = 'Number   Name   brainX   brainY   brainZ   skullX   skullY   skullZ  \n';
%     fprintf(fid,hdrLine);
% 
%     % switch from (- = right) to (- = left) convention
%     bl = ' ';
%     for tr=1:length(skullelectrodes)
%         if skullelectrodes(tr).quantity(2) > -O_q/(Fp_q-O_q) || skullelectrodes(tr).quantity(2) < (1-O_q)/(Fp_q-O_q)
%             cur_line = [                                                                      ...
%                         int2str(tr)                                                      bl   ...
%                         skullelectrodes(tr).name                                              bl   ...
%                         num2str(skullelectrodes(tr).pos(1))                                   bl   ...
%                         num2str(skullelectrodes(tr).pos(2))                                   bl   ...
%                         num2str(skullelectrodes(tr).pos(3))                                   bl   ...
%                         num2str(skullelectrodes(tr).skull(1))                                 bl   ...
%                         num2str(skullelectrodes(tr).skull(2))                                 bl   ...
%                         num2str(skullelectrodes(tr).skull(3))                                 bl   ...
%                                                                                            '\n'];
% 
%     %         if(skullelectrodes(tr).use == 1)        
%     %              fprintf(fid, cur_line); 
%     %         end
%             fprintf(fid, cur_line);
%         end
% 
%     end % loop trials
%     fclose(fid);
    
%     posListFileName = [path '/positionListSkull_ISI',extn,'.txt'];
%     fid = fopen(posListFileName, 'w');
% 
%     hdrLine = 'Number   Name   ml1   ap1   dv1   ml2   ap2   dv2   use   electrodeNr  \n';
%     fprintf(fid,hdrLine);
% 
%     % switch from (- = right) to (- = left) convention
%     bl = ' ';
%     for tr=1:length(skullelectrodes)
%         cur_line = [                                                                             ...
%                     int2str(tr)                                                             bl   ...
%                     skullelectrodes(tr).name                                                     bl   ...
%                     num2str(-0.1*skullelectrodes(tr).skull(2))                                   bl   ...
%                     num2str( 0.1*skullelectrodes(tr).skull(1))                                   bl   ...
%                     num2str( 0.1*skullelectrodes(tr).skull(3))                                   bl   ...
%                     num2str(-0.1*(skullelectrodes(tr).skull(2)+skullelectrodes(tr).normalSkull(2)))   bl   ...
%                     num2str( 0.1*(skullelectrodes(tr).skull(1)+skullelectrodes(tr).normalSkull(1)))   bl   ...
%                     num2str( 0.1*(skullelectrodes(tr).skull(3)+skullelectrodes(tr).normalSkull(3)))   bl   ...
%                     int2str(1)                                                              bl   ...
%                     int2str(tr)                                                    '      \n'];
% 
% %         if(skullelectrodes(tr).use == 1)        
% %             fprintf(fid, cur_line); 
% %         end
%         fprintf(fid, cur_line); 
% 
%     end % loop trials
%     fclose(fid);
    
end