pro edge,amount,data,out
v_kernel=[0,0,0,0,2,-2,0,2,-2]
h_kernel=[0,0,0,0,-2,-2,0,2,2]
v_grad=0.
h_grad=0.
for i=0,8 do begin
    v_grad=v_grad+(v_kernel[i]*data[i])
    h_grad=h_grad+(h_kernel[i]*data[i])
endfor
out=sqrt((v_grad^2*amount)+(h_grad^2*amount))

end

pro GimpDiff,image,amount,nimage
nimage=image*0.
sz=size(image)
nx=sz[1]
ny=sz[2]
kernel=fltarr(9)
for x=1,nx-2 do begin
    for y=1,ny-2 do begin
        for i=0,2 do begin
            for j=0,2 do begin
                kernel[(3*i)+j]=image[x-(1-i),y-(1-i)]
            endfor
        endfor
        edge,amount,kernel,newval
        nimage[x,y]=newval
    endfor
endfor



end
