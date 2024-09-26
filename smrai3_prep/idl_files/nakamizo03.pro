pro nakamizo00


;cd,'C:\Users\rk\Desktop\desk0003\nict02'
;cd,'C:\Users\rk\Desktop\desk0003\nict03
cd,'D:\nict05'

;nt0=1440/5
nt0=1440.0

nlat=30
nlon=80
;nmin=1440


flist=$
   ['20210511','20210512','20210513','20210514','20210515',$
    '20210531','20210601','20210602','20210603',$
    '20210726','20210727','20210728','20210729',$
    '20210909','20210910','20210911','20210912',$
    '20211011','20211012','20211013','20211014',$
    '20211101','20211102','20211103','20211104','20211105','20211106',$
    '20211125','20211126','20211127','20211128','20211129',$
    '20220130','20220131','20220201','20220202','20220203',$
    '20220311','20220312','20220313','20220314','20220315',$
    '20220328','20220329','20220330','20220331','20220401',$
    '20220815','20220816','20220817','20220818','20220819']

nf0=n_elements(flist)

;  xbig=fltarr(32,15,nt0*nf0)
;  wbig=fltarr(32,15,nt0*nf0)
;  ybig=fltarr(32,15,nt0*nf0)
;  fbig=fltarr(32,15,nt0*nf0)
;  pbig=fltarr(32,15,nt0*nf0)

;allbig=fltarr(nlon,nlat,nt0*nf0,5)
  xbig=fltarr(nlon,nlat,nt0*nf0)
  wbig=fltarr(nlon,nlat,nt0*nf0)
  ybig=fltarr(nlon,nlat,nt0*nf0)
  fbig=fltarr(nlon,nlat,nt0*nf0)
  pbig=fltarr(nlon,nlat,nt0*nf0)

for i=0,nf0-1 do begin

;  restore,'20210515_1min.sav'
;restore,'2021051'+string(i+1,'(I1.1)')+'_1min.sav'
restore,flist(i)+'pnn.sav'
;restore,flist(i)+'_1mis.sav'

;x=congrid(bigsxx,32,15,nt0)
;w=congrid(bigsxy,32,15,nt0)
;y=congrid(bigsyy,32,15,nt0)
;f=congrid(bigfac,32,15,nt0)
;p=congrid(bigpow,32,15,nt0)

;xbig(*,*,i*nt0:(i+1)*nt0-1)=x
;wbig(*,*,i*nt0:(i+1)*nt0-1)=w
;ybig(*,*,i*nt0:(i+1)*nt0-1)=y
;fbig(*,*,i*nt0:(i+1)*nt0-1)=f
;pbig(*,*,i*nt0:(i+1)*nt0-1)=p

;allbig(*,*,i*nt0:(i+1)*nt0-1,0)=bigsxx
;allbig(*,*,i*nt0:(i+1)*nt0-1,1)=bigsxy
;allbig(*,*,i*nt0:(i+1)*nt0-1,2)=bigsyy
;allbig(*,*,i*nt0:(i+1)*nt0-1,3)=bigfac
;allbig(*,*,i*nt0:(i+1)*nt0-1,4)=bigpow

xbig(*,*,i*nt0:(i+1)*nt0-1)=bigsxx
wbig(*,*,i*nt0:(i+1)*nt0-1)=bigsxy
ybig(*,*,i*nt0:(i+1)*nt0-1)=bigsyy
fbig(*,*,i*nt0:(i+1)*nt0-1)=bigfac
pbig(*,*,i*nt0:(i+1)*nt0-1)=bigpow

endfor

;openw,1,'bigalln.dat'
;writeu,1,allbig
;close,1

openw,1,'xbig.dat'
writeu,1,xbig
close,1

openw,1,'wbig.dat'
writeu,1,wbig
close,1

openw,1,'ybig.dat'
writeu,1,ybig
close,1

openw,1,'fbig.dat'
writeu,1,fbig
close,1

openw,1,'pbig.dat'
writeu,1,pbig
close,1

stop
end

pro nakamizo00sw

;  fout='sw720.txt'
;  fout='sw2592.txt'
;  fout='sw5472.txt'
;fout='swshock.txt'
fout='swall.txt'

;  cd,'C:\Users\rk\Desktop\nict00'
;cd,'C:\Users\rk\Desktop\desk0003\nict02'
;cd,'C:\Users\rk\Desktop\desk0003\nict03'
;cd,'C:\Users\rk\Desktop\desk0003\nict03
cd,'D:\nict05'

;  nt0=288
  nt0=1440.0

flist=$
   ['20210511','20210512','20210513','20210514','20210515',$
    '20210531','20210601','20210602','20210603',$
    '20210726','20210727','20210728','20210729',$
    '20210909','20210910','20210911','20210912',$
    '20211011','20211012','20211013','20211014',$
    '20211101','20211102','20211103','20211104','20211105','20211106',$
    '20211125','20211126','20211127','20211128','20211129',$
    '20220130','20220131','20220201','20220202','20220203',$
    '20220311','20220312','20220313','20220314','20220315',$
    '20220328','20220329','20220330','20220331','20220401',$
    '20220815','20220816','20220817','20220818','20220819']


   
 nf0=n_elements(flist)

 dsbig=fltarr(nt0*nf0)
 dcbig=fltarr(nt0*nf0)
 tsbig=fltarr(nt0*nf0)
 tcbig=fltarr(nt0*nf0)
 ybig=fltarr(nt0*nf0)
 zbig=fltarr(nt0*nf0)
 vbig=fltarr(nt0*nf0)
 nbig=fltarr(nt0*nf0)

;  flist=['20210511','20210512','20210513','20210514','20210515',$
;    '20210726','20210727','20210728','20210729']


;save,n2,v2,y2,z2,file='20210729_1sw.sav'
;save,ds2,dc2,ts2,tc2,n2,v2,y2,z2,file=dir+yyyymmdd+'_ssw.sav';season+ solar wind

;for i=0,8 do begin
  for i=0,nf0-1 do begin

    ;  restore,'20210515_1min.sav'
;    restore,'2021051'+string(i+1,'(I1.1)')+'_1sw.sav'
    restore,flist(i)+'_ssw.sav'
    
;    y=congrid(y2,nt0)
;    z=congrid(z2,nt0)
;    v=congrid(v2,nt0)
;    n=congrid(n2,nt0)

dsbig(i*nt0:(i+1)*nt0-1)=ds2
dcbig(i*nt0:(i+1)*nt0-1)=dc2
tsbig(i*nt0:(i+1)*nt0-1)=ts2
tcbig(i*nt0:(i+1)*nt0-1)=tc2

    ybig(i*nt0:(i+1)*nt0-1)=y2
    zbig(i*nt0:(i+1)*nt0-1)=z2
    vbig(i*nt0:(i+1)*nt0-1)=v2
    nbig(i*nt0:(i+1)*nt0-1)=n2

  endfor

  vbig=alog10(vbig)-2.5
  nbig=alog10(nbig)-1.0

a=' '

  openw,1,fout
;  for i=0,2592-1 do begin
;for i=0,5472-1 do begin
  for i=0,nt0*nf0-1 do begin
;    printf,1,ybig(i),zbig(i),vbig(i),nbig(i)
;printf,1,ybig(i),a,zbig(i),a,vbig(i),a,nbig(i),form='(F10.6,A1,F10.6,A1,F10.6,A1,F10.6)'
printf,1,dsbig(i),a,dcbig(i),a,tsbig(i),a,tcbig(i),a,ybig(i),a,zbig(i),a,vbig(i),a,nbig(i),$
  form='(F10.6,A1,F10.6,A1,F10.6,A1,F10.6,A1,F10.6,A1,F10.6,A1,F10.6,A1,F10.6)'
  endfor
  close,1


  stop

end
