clear; close all; clc;

% load('final_developing_stage_data_for_first_cell.mat');
% load('final_mature_stage_data_for_first_cell.mat');
% load('final_decaying_stage_data_for_first_cell.mat');
 
% load('final_developing_stage_data_for_second_cell.mat');
% load('final_mature_stage_data_for_second_cell.mat');
load('final_decaying_stage_data_for_second_cell.mat');

season = 2; drop_shape = 1; temp1 = 20;
bins_zh = 10:1:60; bins_zdr = -0.6:0.1:4.2; bins_kdp = -0.5:0.1:3; 
bins_dm = 0.01:0.1:4;
cf1 = [0.1 0.5 1 2.5 5:5:100];  % for cfad method 1
cf0 = [0.1 0.2 0.5 1 2 5 10 15 20 25 30 40 50];    % for cfad method 2
cf0_tick = {'0.1','0.2','0.5','1','2','5','10','15','20','25','30','40','50'};
name = 'decaying stage second cell';
for hh = 1:size(final_mean_data,2)
    
    data_zh(:,:)  = final_mean_data(hh).zh;
    data_zdr(:,:) = final_mean_data(hh).zdr;
    data_kdp(:,:) = final_mean_data(hh).kdp;
    data_dm(:,:)  = final_mean_data(hh).dm;
%     [data_dm,data_mu,data_lambda_gamma,data_n0_gamma,data_nt_gamma]...
%      = DSD_gamma_retrieval(data_zh,data_zdr,season,drop_shape,temp1);
%         counts(hh,:) = histogram(data,bins);
    counts_zh(hh,:) = histcounts(data_zh,bins_zh);
    counts_zdr(hh,:) = histcounts(data_zdr,bins_zdr);
    counts_kdp(hh,:) = histcounts(data_kdp,bins_kdp);
    counts_dm(hh,:)  = histcounts(data_dm,bins_dm);  
end
counts_zh(find(counts_zh==0))=nan;
counts_zdr(find(counts_zdr==0))=nan;
counts_kdp(find(counts_kdp==0))=nan;
counts_dm(find(counts_dm==0))=nan;
%% method 2
   % zh
    tot_zh = nansum(counts_zh,2); % sum over each level
    TOT_zh = tot_zh.*ones(1,length(bins_zh)-1);
    freq_zh = 100.*counts_zh./TOT_zh; % get percentage of points at each level in each variable value bin
    cf = cf0;

    % zdr
    tot_zdr = nansum(counts_zdr,2); % sum over each level
    TOT_zdr = tot_zdr.*ones(1,length(bins_zdr)-1);
    freq_zdr = 100.*counts_zdr./TOT_zdr; % get percentage of points at each level in each variable value bin
    
    % kdp
    tot_kdp = nansum(counts_kdp,2); % sum over each level
    TOT_kdp = tot_kdp.*ones(1,length(bins_kdp)-1);
    freq_kdp = 100.*counts_kdp./TOT_kdp; % get percentage of points at each level in each variable value bin

    % dm
    tot_dm = nansum(counts_dm,2); % sum over each level
    TOT_dm = tot_dm.*ones(1,length(bins_dm)-1);
    freq_dm = 100.*counts_dm./TOT_dm; % get percentage of points at each level in each variable value bin

%% plotting CFAD
    
    pos = [400,100,1600,1200];
    figure('Name','Final figure','Position',pos);
    subplot(2,2,1)
    contourf(bins_zh(1,2:size(bins_zh,2)),ht,log(freq_zh),log(cf),'linestyle','-','ShowText','off');
    set(gca,'box','on','linewidth',1,'layer','top','fontweight','bold','fontsize',18)
    grid on
    ylim([0 12])
    shading flat
    xlabel('Z_{H}(dBZ)'); ylabel('Height (km)');
    caxis([min(log(cf)) max(log(cf))]);
    colormap(jet)
    c1 = colorbar;
    set(c1,'linewidth',1,'YTick',log(cf),'YTickLabel',cf0_tick);
    c1.Label.String = '% Occurence frequency' ;
    title(['CFAD for ',name]);
    
    subplot(2,2,2)
    contourf(bins_zdr(1,2:size(bins_zdr,2)),ht,log(freq_zdr),log(cf),'linestyle','-','ShowText','off');
    set(gca,'box','on','linewidth',1,'layer','top','fontweight','bold','fontsize',18)
    grid on
    ylim([0 12])
    % shading flat
    xlabel('Z_{DR}(dB)'); ylabel('Height (km)');
    caxis([min(log(cf)) max(log(cf))]);
    colormap(jet)
    c1 = colorbar;
    set(c1,'linewidth',1,'YTick',log(cf),'YTickLabel',cf0_tick);
    c1.Label.String = '% Occurence frequency' ;
    title(['CFAD for ',name]);

    subplot(2,2,3)
    contourf(bins_kdp(1,2:size(bins_kdp,2)),ht,log(freq_kdp),log(cf),'linestyle','-','ShowText','off');
    set(gca,'box','on','linewidth',1,'layer','top','fontweight','bold','fontsize',18)
    grid on
    ylim([0 12])
    % shading flat
    xlabel('K_{DP}(^o/km)'); ylabel('Height (km)');
    caxis([min(log(cf)) max(log(cf))]);
    colormap(jet)
    c1 = colorbar;
    set(c1,'linewidth',1,'YTick',log(cf),'YTickLabel',cf0_tick);
    c1.Label.String = '% Occurence frequency' ;
    title(['CFAD for ',name]);
    
    
    subplot(2,2,4)
    contourf(bins_dm(1,2:size(bins_dm,2)),ht,log(freq_dm),log(cf),'linestyle','-','ShowText','off');
    set(gca,'box','on','linewidth',1,'layer','top','fontweight','bold','fontsize',18)
    grid on
    ylim([0 3.75])
    % shading flat
    xlabel('D_{m}(mm)'); ylabel('Height (km)');
    caxis([min(log(cf)) max(log(cf))]);
    colormap(jet)
    c1 = colorbar;
    set(c1,'linewidth',1,'YTick',log(cf),'YTickLabel',cf0_tick);
    c1.Label.String = '% Occurence frequency' ;
    title(['CFAD for ',name]);
    
%     saveas(gca,['F:\DATA\data\cyclone\NIVAR\26112020_0530_0529\vol\plots\cfad/',...
%                 'second_patch_cfad_diagram_on_',filetime,'.jpg']);
%     
%     pause(1)
%     close all;