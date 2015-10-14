pro combi_plotter_times

;Plot AIA images in different wavelengths

restgen, file='genx/fld_2', data_nd
waves=['94']

slobj = hsi_obs_summary()

for i=0, n_elements(data_nd)-1  do begin
date=[(anytim(data_nd[i].peak_time-60,/yoh,/trunc)),(anytim(data_nd[i].peak_time,/yoh,/trunc)),(anytim(data_nd[i].peak_time+120,/yoh,/trunc))$
    ,(anytim(data_nd[i].peak_time+180,/yoh,/trunc)),(anytim(data_nd[i].peak_time+240,/yoh,/trunc)),(anytim(data_nd[i].peak_time+300,/yoh,/trunc))]

restgen,file='genx/img_'+string(data_nd[i].id_number,format='(i8)'),map


peak_time=data_nd[i].peak_time
start_time=data_nd[i].start_time
end_time=data_nd[i].end_time
t1a=anytim((peak_time - 30)>start_time ,/yoh,/trunc)
t2a=anytim((peak_time + 30)<end_time,/yoh,/trunc)


!P.font=0
   !p.multi=[0,3,3]
    
    set_plot,'ps'                                                 
    device, /encapsulated, /color, /isolatin1,/inches, $
      bits=8, xsize=10, ysize=10,file='figs/time_figs/img_lc_AIA_time'+string(data_nd[i].id_number,format='(i8)')+'.eps'
    
    ;;;;;;;;;Begin rhessi image ploting;;;;;;;;;;
    
    LOADCT,3  
   
    gamma_ct,1.75,/current
    
    TVLCT,R,G,B,/GET
    RR=REVERSE(R)
    GG=REVERSE(G)
    BB=REVERSE(B)
    TVLCT,RR,GG,BB
   
    
    plot_map,map[0],/border,/limb,lcolor=255,grid=5,gcolor=255 $
            ,title=anytim(map[0].time,/yoh,/trunc)+'+'+string(map[0].dur,format='(i2)')+'s',color=255 $
            , position=[ 0.1,0.65,0.4 ,0.95]
    xyouts,6900,23700,map[0].id,/device,color=150,charsize=0.7
   
    linecolors 
    xyouts,6900,23450,map[1].id,/device,color=9,charsize=0.7
    plot_map,map[1],/cont,c_colors = 9,/per,levels=[50,70,90],/over
    
    
            ;;;;;;;;Begin Light curve plotting;;;;;;;;;;
    
    slobj -> set, obs_time_interval=[start_time-120,end_time+120]
    hsi_linecolors
    slobj -> plot, /saa, /flare, /night,/flag_colors, dim1_use=[0,1,2,3],dim1_colors=[0,2,3,4],title=' '$
      ,legend_loc=2, yrange=[1,2000],xstyle=17,charsize=0.8, psym=10,/no_timestamp, position=[ 0.59,0.65,0.895 ,0.95]
    outplot,[t1a,t1a],[1,1e5],lines=2
    outplot,[t2a,t2a],[1,1e5], lines=2
    outplot,anytim([start_time,start_time],/yoh,/trunc),[1,1e5],lines=2
    outplot,anytim([end_time,end_time],/yoh,/trunc),[1,1e5],lines=2
    outplot,anytim([peak_time,peak_time],/yoh,/trunc),[1,1e5],lines=2
    
    
            ;;;;;;;;Begin AIA plotting;;;;;;;;;;;
    
;AIA-94
restgen,file='maps/time_maps/AIA_re_scale_'+string(data_nd[i].id_number,format='(i8)')+'_'+string([0]),mmallc
    
    aia_lct,wave=waves[0],/load
    plot_map,mmallc[0],/border,/limb,lcolor=255,grid=5,gcolor=255 $
            ,title=string(date[0]) +'  -  94'+ string("305B),position=[0.05, 0.35, 0.3, 0.60]
    ;xyouts,100,900,mmall[0].id,/device,color=255,charsize=1.0
   
    linecolors 
    ;xyouts,100,400,map[0].id,/device,color=9,charsize=1.0
    plot_map,map[0],/cont,c_colors = 2,/per,levels=[50,70,90],/over
    
    linecolors 
    ;xyouts,100,400,map[1].id,/device,color=14,charsize=1.0
    plot_map,map[1],/cont,c_colors = 14,/per,levels=[50,70,90],/over
   
;AIA-131
restgen,file='maps/time_maps/AIA_re_scale_'+string(data_nd[i].id_number,format='(i8)')+'_'+string([1]),mmallc
    
    aia_lct,wave=waves[0],/load
    plot_map,mmallc[1],/border,/limb,lcolor=255,grid=5,gcolor=255 $
            ,title=string(date[1]) +'  -  94'+ string("305B),color=0, position=[0.375, 0.35, 0.625, 0.60]
   ; xyouts,100,900,mmall[0].id,/device,color=255,charsize=1.0
   
    linecolors 
   ; xyouts,100,400,map[0].id,/device,color=9,charsize=1.0
    plot_map,map[0],/cont,c_colors = 2,/per,levels=[50,70,90],/over
    
    linecolors 
   ; xyouts,100,400,map[1].id,/device,color=14,charsize=1.0
    plot_map,map[1],/cont,c_colors = 14,/per,levels=[50,70,90],/over
   
;AIA-171
restgen,file='maps/time_maps/AIA_re_scale_'+string(data_nd[i].id_number,format='(i8)')+'_'+string([2]),mmallc
    
    aia_lct,wave=waves[0],/load
    plot_map,mmallc[2],/border,/limb,lcolor=255,grid=5,gcolor=255 $
            ,title=string(date[2]) +'  -  94'+ string("305B),position=[0.7, 0.35, 0.95, 0.6]
    ;xyouts,100,900,mmall[0].id,/device,color=255,charsize=1.0
   
    linecolors 
    ;xyouts,100,400,map[0].id,/device,color=9,charsize=1.0
    plot_map,map[0],/cont,c_colors = 2,/per,levels=[50,70,90],/over
    
    linecolors 
    ;xyouts,100,400,map[1].id,/device,color=14,charsize=1.0
    plot_map,map[1],/cont,c_colors = 14,/per,levels=[50,70,90],/over
  
;AIA-193
restgen,file='maps/time_maps/AIA_re_scale_'+string(data_nd[i].id_number,format='(i8)')+'_'+string([3]),mmallc
   
    aia_lct,wave=waves[0],/load
    plot_map,mmallc[3],/border,/limb,lcolor=255,grid=5,gcolor=255 $
            ,title=string(date[3]) +'  -  94'+ string("305B),color=0, position=[0.05, 0.05, 0.30, 0.30]
    ;xyouts,100,900,mmall[0].id,/device,color=255,charsize=1.0
   
    linecolors 
    ;xyouts,100,400,map[0].id,/device,color=9,charsize=1.0
    plot_map,map[0],/cont,c_colors = 2,/per,levels=[50,70,90],/over
    
    linecolors 
    ;xyouts,100,400,map[1].id,/device,color=14,charsize=1.0
    plot_map,map[1],/cont,c_colors = 14,/per,levels=[50,70,90],/over
  
;AIA-211
restgen,file='maps/time_maps/AIA_re_scale_'+string(data_nd[i].id_number,format='(i8)')+'_'+string([4]),mmallc
    
    aia_lct,wave=waves[0],/load
    plot_map,mmallc[4],/border,/limb,lcolor=255,grid=5,gcolor=255 $
            ,title=string(date[4]) +'  -  94'+ string("305B),color=0,position=[0.375, 0.05, 0.625, 0.30]
    ;xyouts,100,900,mmall[0].id,/device,color=255,charsize=1.0
   
    linecolors 
    ;xyouts,100,400,map[0].id,/device,color=9,charsize=1.0
    plot_map,map[0],/cont,c_colors = 2,/per,levels=[50,70,90],/over
    
    linecolors 
    ;xyouts,100,400,map[1].id,/device,color=14,charsize=1.0
    plot_map,map[1],/cont,c_colors = 14,/per,levels=[50,70,90],/over
  
 
;AIA-335
restgen,file='maps/time_maps/AIA_re_scale_'+string(data_nd[i].id_number,format='(i8)')+'_'+string([5]),mmallc
   
    aia_lct,wave=waves[0],/load
    plot_map,mmallc[5],/border,/limb,lcolor=255,grid=5,gcolor=255 $
           ,title=string(date[5]) +'  -  94'+ string("305B),color=0,position=[0.7, 0.05, 0.95, 0.30]
   ; xyouts,100,900,mmall[0].id,/device,color=255,charsize=1.0
  
    linecolors 
    ;xyouts,100,400,map[0].id,/device,color=9,charsize=1.0
    plot_map,map[0],/cont,c_colors = 2,/per,levels=[50,70,90],/over
    
    linecolors 
    ;xyouts,100,400,map[1].id,/device,color=14,charsize=1.0
    plot_map,map[1],/cont,c_colors = 14,/per,levels=[50,70,90],/over
       
  device,/close
    set_plot, 'x'
  
    endfor
    
    end