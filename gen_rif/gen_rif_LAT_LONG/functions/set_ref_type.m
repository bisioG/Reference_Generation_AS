%set the right reference

if strcmp(rif_type,'Non linear lateral')
    rif_pressione = yp_NL;
    rif_pressione_hp = 0;
    
elseif strcmp(rif_type,'Non linear lateral HP')
    rif_pressione = yp_NL;
    rif_pressione_hp = ypf_NL;
    
elseif strcmp(rif_type,'Linear lateral')
    rif_pressione = yp_L;
    rif_pressione_hp = 0;
 
elseif strcmp(rif_type,'Linear lateral HP')
    rif_pressione = yp_L;
    rif_pressione_hp = ypf_L;
    
elseif strcmp(rif_type,'Non linear lateral WOfriction')
    rif_pressione = yp_NL_WOfriction;
    rif_pressione_hp = 0;
    
elseif strcmp(rif_type,'Non linear lateral WOfriction HP')
    rif_pressione = yp_NL_WOfriction;
    rif_pressione_hp = ypf_NL_WOfriction;
    
elseif strcmp(rif_type,'Linear longitudinal')
    rif_pressione = yp_L;
    rif_pressione_hp = 0;
    
elseif strcmp(rif_type,'Linear longitudinal HP')
    rif_pressione = yp_L;
    rif_pressione_hp = ypf_L;
else
    disp('error: wrong reference type settings')
end
    