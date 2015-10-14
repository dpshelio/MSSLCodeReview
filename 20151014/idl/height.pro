; find the height in solar radii corresonding to frequency

pro height

  ; read frequency data
  readcol, 'UpperBand.dat', f = 'A', time_upper, fit_upper, sec_upper   
  readcol, 'LowerBand.dat', f = 'A', time_lower, fit_lower, sec_lower

  fit_upper = (fit_upper - 4.58) * 1.E6	;converting MHz to Hz
  fit_lower = (fit_lower - 3.89) * 1.E6	
  
  ; Density model
  restore,'density_zucca_et_al_01062015.sav'

  ; convert frequency (Hz) to density (cm^-3): f = 18000 sqrt(ne)
  density_upper = ( fit_upper/ 18000 ) ^ 2
  density_lower = ( fit_lower/ 18000 ) ^ 2

  ; interpolate
  int_upper = interpol(  radius_tot, density_pure_model[*,39], density_upper )
  int_lower = interpol(  radius_tot, density_pure_model[*,39], density_lower )
  
  ; output to text file
  sec_upper = [ sec_upper, 0 ] & int_upper = [ int_upper, 0]	; make arrays equal length	
  openw, 1, 'height.dat'
  printf, 1, 'Seconds (Upper):', 'Height (Upper):', 'Seconds (Lower):', 'Height (Lower):'
  for i = 0, 25 do begin
  	printf, 1 ,sec_upper [i], int_upper [i], sec_lower[i], int_lower[i], $
		format = '( F7.2, 9X, F5.3, 10X, F7.2, 9X, F5.3 )'
	endfor
  close, 1

  ; plot of density model
  plot_saito

  oplot, int_upper, density_upper, psym = 4, color = 100
  oplot, int_lower, density_lower, psym = 2, color = 50

end
  
