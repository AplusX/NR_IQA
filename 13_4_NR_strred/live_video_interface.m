clear all; close all; 
clc;
path_videos = 'D:\final_yuv_videos\';
seq = ['pa'; 'rb'; 'rh'; 'tr'; 'st'; 'sf'; 'bs'; 'sh'; 'mc'; 'pr'];
rate = [25 25 25 25 25 25 25 50 50 50];
num_ref = 10; %No of reference sequences
num_seq = 16; %No of distorted sequences

nframes = [250 250 250 250 250 250 217 500 500 500]; %no of frames for difference reference sequences
rows = 432; 
colms = 768; 


for i = 1:num_ref
    ref_name = strcat(seq(i,:),'1_',num2str(rate(i)),'fps.yuv');
    rname = strcat(path_videos,ref_name);    
    for j=2:16
        dis_name = strcat(seq(i,:),num2str(j),'_',num2str(rate(i)),'fps.yuv')
        dname = strcat(path_videos,dis_name);

        f=1; prev_q=0;
        for k =1:2:nframes(i)-1     
            
            %Read successive frames in both the reference and distorted
            [yr1,cbr,crr]=readframe(rname, k);
            yr1=reshape(yr1,colms,rows)';
            [yr2,cbr,crr]=readframe(rname, k+1);
            yr2=reshape(yr2,colms,rows)';
            %Extract temporal and spatial information from the frames
            [spatial_ref temporal_ref] = extract_info(yr1,yr2); 

            [yd1,cbd,crd]=readframe(dname, k);
            yd1=reshape(yd1,colms,rows)';
            [yd2,cbd,crd]=readframe(dname, k+1);
            yd2=reshape(yd2,colms,rows)';
            [spatial_dis temporal_dis] = extract_info(yd1,yd2);

            rreds(f) = mean2(abs(spatial_ref-spatial_dis)); %spatial RRED for frame f
            rredt(f) = mean2(abs(temporal_ref-temporal_dis));% temporal RRED for frame f
            rredssn(f) = abs(mean2(spatial_ref-spatial_dis));% spaial RRED using 1 number for frame f
            rredtsn(f) = abs(mean2(temporal_ref-temporal_dis)); % temporal RRED using 1 number for frame f            
            f=f+1; 
        end

        srred(i,j)=mean(rreds); %spatial RRED
        trred(i,j)=mean(rredt); %temporal RRED                       
        srredsn(i,j)=mean(rredssn); %single no. spatial RRED
        trredsn(i,j)=mean(rredtsn); %single no. temporal RRED                       

        clear rreds rredt rredssn rredtsn
        toc
    end
end
strred = srred.*trred; %spatiotemporal RRED
strredsn = srredsn.*trredsn; %spatiotemporal RRED
save strred srred trred srredsn trredsn strred strredsn 
