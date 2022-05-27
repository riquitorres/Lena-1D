
ii=0;exp=today;mv T1_${ii}.dat T1_${exp}.dat; mv T2_${ii}.dat T2_today.dat; sed "s/T1_${ii}/T1_${exp}/" fabm_input${ii}.nml > fabm_input_${exp}.nml ; sed -i "s/T2_${ii}/T2_${exp}/" fabm_input_${exp}.nml ; rm fabm_input${ii}.nml 
ii=1;exp=25;mv T1_${ii}.dat T1_${exp}.dat; mv T2_${ii}.dat T2_${exp}.dat; sed "s/T1_${ii}/T1_${exp}/" fabm_input${ii}.nml > fabm_input_${exp}.nml ; sed -i "s/T2_${ii}/T2_${exp}/" fabm_input_${exp}.nml ; rm fabm_input${ii}.nml 
ii=2;exp=50;mv T1_${ii}.dat T1_${exp}.dat; mv T2_${ii}.dat T2_${exp}.dat; sed "s/T1_${ii}/T1_${exp}/" fabm_input${ii}.nml > fabm_input_${exp}.nml ; sed -i "s/T2_${ii}/T2_${exp}/" fabm_input_${exp}.nml ; rm fabm_input${ii}.nml 
ii=3;exp=75;mv T1_${ii}.dat T1_${exp}.dat; mv T2_${ii}.dat T2_${exp}.dat; sed "s/T1_${ii}/T1_${exp}/" fabm_input${ii}.nml > fabm_input_${exp}.nml ; sed -i "s/T2_${ii}/T2_${exp}/" fabm_input_${exp}.nml ; rm fabm_input${ii}.nml 
ii=4;exp=100;mv T1_${ii}.dat T1_${exp}.dat; mv T2_${ii}.dat T2_${exp}.dat; sed "s/T1_${ii}/T1_${exp}/" fabm_input${ii}.nml > fabm_input_${exp}.nml ; sed -i "s/T2_${ii}/T2_${exp}/" fabm_input_${exp}.nml ; rm fabm_input${ii}.nml 

ii=0;exp=today;mv fabm.yaml${ii}.nml fabm.yaml_${exp}.nml; 
ii=1;exp=25;mv fabm.yaml${ii}.nml fabm.yaml_${exp}.nml; 
ii=2;exp=50;mv fabm.yaml${ii}.nml fabm.yaml_${exp}.nml; 
ii=3;exp=75;mv fabm.yaml${ii}.nml fabm.yaml_${exp}.nml; 
ii=4;exp=100;mv fabm.yaml${ii}.nml fabm.yaml_${exp}.nml; 


