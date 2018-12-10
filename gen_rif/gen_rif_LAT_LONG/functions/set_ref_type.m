%set the right reference

if type ==1

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
        
    else
        error('error: wrong reference type settings : rif_type')
    end
    
elseif type==2
    
    if strcmp(rif_type,'Linear longitudinal')
        rif_pressione = yp_L_long;
        rif_pressione_hp = 0;
    
    elseif strcmp(rif_type,'Linear longitudinal HP')
        rif_pressione = yp_L_long;
        rif_pressione_hp = ypf_L_long;
    
    else
        error('error: wrong reference type settings : rif_type')
    end
else
    error('error: wrong reference type settings: type')

end
    