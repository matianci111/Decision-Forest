plot_toydata(data_train);
%(output_data(:,3)&1) (output_data(:,3)&2) (output_data(:,3)&3)
h = scatter(output_data(:,1),output_data(:,2),[],[((output_data(:,3)==1).*output_data(:,4)) ((output_data(:,3)==2).*output_data(:,4)) ((output_data(:,3)==3).*output_data(:,4))], 'filled');
uistack(h, 'bottom');