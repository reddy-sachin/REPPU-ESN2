pro nict_is,year,month,day

;cd,'C:\Users\rk\Desktop\nict00\20210512'
;cd,'C:\Users\rk\Desktop\desk0003\nict02\0729'
;cd,'D:\nict\20210511'

nlat=30
nlon=80
nmin=1440
;stop
bispow=fltarr(nlon,nlat,nmin)
bisfac=fltarr(nlon,nlat,nmin)
bissxx=fltarr(nlon,nlat,nmin)
bissyy=fltarr(nlon,nlat,nmin)
bissxy=fltarr(nlon,nlat,nmin)

bigpow=fltarr(nlon,nlat,nmin)
bigfac=fltarr(nlon,nlat,nmin)
bigsxx=fltarr(nlon,nlat,nmin)
bigsyy=fltarr(nlon,nlat,nmin)
bigsxy=fltarr(nlon,nlat,nmin)

nnn=0

maxlong_is=321
maxlat_is=221

;year=2021 & month=07 & day=29
;year=2022 & month=08 & day=18
;year=2022 & month=04 & day=1

mmdd=string(month,'(I2.2)')+string(day,'(I2.2)')
yyyymmdd=string(year,'(I4.4)')+string(month,'(I2.2)')+string(day,'(I2.2)')

;dir='D:\nict03\';7 events
dir='D:\nict03\';bat5a
;dir='D:\nict05\';bat5b
;dir='E:\nict\';earlier events in may2021 

cd,dir+yyyymmdd

;dir='E:\nict02c\';earlier events in nov2021
;cd,dir+mmdd

;filelist=file_search('idata'+yyyymmdd+'*')
;read,'day=',day
;day=fix(day)

pi=3.141593
fac_norm=3.75e-6 ; A/m^2 for FAC (REPPU)
pow_norm=1.017e7 ; V for potential (REPPU)
cond_norm=1.50e01; mho


;***************************************************************************
;parameter definition
;***************************************************************************
tew=fltarr(maxlong_is,maxlat_is)
fiw=fltarr(maxlong_is,maxlat_is)
vxw=fltarr(maxlong_is,maxlat_is)
vyw=fltarr(maxlong_is,maxlat_is)
vzw=fltarr(maxlong_is,maxlat_is)
pow=fltarr(maxlong_is,maxlat_is)
fac=fltarr(maxlong_is,maxlat_is)
sxx=fltarr(maxlong_is,maxlat_is)
syy=fltarr(maxlong_is,maxlat_is)
sxy=fltarr(maxlong_is,maxlat_is)
s1w=fltarr(maxlong_is,maxlat_is)
s2w=fltarr(maxlong_is,maxlat_is)
s3w=fltarr(maxlong_is,maxlat_is)
s4w=fltarr(maxlong_is,maxlat_is)
s5w=fltarr(maxlong_is,maxlat_is)
s6w=fltarr(maxlong_is,maxlat_is)
timea=fltarr(1)
nn=intarr(1)
conbp=fltarr(100)

tew_fig=fltarr(maxlat_is)
fiw_fig=fltarr(maxlong_is)

x=fltarr(maxlong_is,maxlat_is)
y=fltarr(maxlong_is,maxlat_is)
z=fltarr(maxlong_is,maxlat_is)
;***************************************************************************
;read data from files
;***************************************************************************
if month lt 10 then begin
  yyyymmdd=strcompress(string(year)+string('0')+string(month*100+day),/remove_all)
endif else if month ge 10 then begin
  yyyymmdd=strcompress(string(year)+string(month*100+day),/remove_all)
endif
for hour=00,23 do begin
for minute=00,59 do begin
  hhmm=hour*100+minute
  if hour eq 0 then begin
    if minute eq 0 then begin
      yyyymmddhhmm=strcompress(yyyymmdd+string('0000'),/remove_all)
    endif else if minute ge 10 then begin
      yyyymmddhhmm=strcompress(yyyymmdd+string('00')+string(hhmm),/remove_all)
    endif else if minute gt 0 then begin
      yyyymmddhhmm=strcompress(yyyymmdd+string('000')+string(hhmm),/remove_all)
    endif
  endif else if hour lt 10 then begin
    yyyymmddhhmm=strcompress(yyyymmdd+string('0')+string(hhmm),/remove_all)
  endif else if hour ge 10 then begin
    yyyymmddhhmm=strcompress(yyyymmdd+string(hhmm),/remove_all)
  endif
  print,yyyymmddhhmm,year,month,day,hour,minute
  input_filename=strcompress('idata'+yyyymmddhhmm,/remove_all)
;  output_filename=strcompress('odata'+yyyymmddhhmm,/remove_all)

  openr,30,input_filename,/f77_unformatted, ERROR = err
  IF (err NE 0) then goto,skip00
  
  readu,30, nn,timea
  tew(*,*)=0.0
  fiw(*,*)=0.0
  print,nn
  readu,30, vxw
  readu,30, vyw
  readu,30, vzw
  readu,30, pow
  readu,30, fac
  readu,30, sxx
  readu,30, sxy
  readu,30, syy
  readu,30, s1w
  readu,30, s2w
  readu,30, s3w
  readu,30, s4w
  readu,30, s5w
  readu,30, s6w
  readu,30, conbp
  pow(0,0)=pow(2,0)
  pow(1,0)=pow(2,0)
  fac(0,0)=fac(2,0)
  fac(1,0)=fac(2,0)
;*********************************************************************
; set mesh
;*********************************************************************
;  for lat=0,maxlat_is-1 do begin
;    for long=0,maxlong_is-1 do begin
;      x(long,lat)=+180.0*tew(long,lat)/pi*sin(fiw(long,lat))
;      y(long,lat)=-180.0*tew(long,lat)/pi*cos(fiw(long,lat))
;    endfor
;  endfor
;***************************************************************************
; store data into the work data
;***************************************************************************
;  for lat=0,maxlat_is-1 do begin
;  for long=0,maxlong_is-1 do begin
;    tew_fig(lat)=tew(long,lat)
;    fiw_fig(long)=fiw(long,lat)
;  endfor
;  endfor
;***************************************************************************
; out
;***************************************************************************

skip00:

pow2=pow(0:319,*)
pow2=shift(pow2,-2,0)

;southern first
;bissxx(*,*,nnn)=congrid(sxx(0:319,0:59)*cond_norm,nlon,nlat)
;bissxy(*,*,nnn)=congrid(sxy(0:319,0:59)*cond_norm,nlon,nlat)
;bissyy(*,*,nnn)=congrid(syy(0:319,0:59)*cond_norm,nlon,nlat)
;;bispow(*,*,nnn)=congrid(pow(0:319,0:59)*pow_norm,nlon,nlat)
;bispow(*,*,nnn)=congrid(pow2(0:319,1:60)*pow_norm,nlon,nlat)
;;bisfac(*,*,nnn)=congrid(fac(0:319,0:59)*fac_norm*1d-3,nlon,nlat)
;bisfac(*,*,nnn)=congrid(fac(0:319,0:59)*fac_norm,nlon,nlat)

bissxx(*,*,nnn)=rebin(sxx(0:319,0:59)*cond_norm,nlon,nlat)
bissxy(*,*,nnn)=rebin(sxy(0:319,0:59)*cond_norm,nlon,nlat)
bissyy(*,*,nnn)=rebin(syy(0:319,0:59)*cond_norm,nlon,nlat)
bispow(*,*,nnn)=rebin(pow(0:319,0:59)*pow_norm,nlon,nlat)
bisfac(*,*,nnn)=rebin(fac(0:319,0:59)*fac_norm,nlon,nlat)

;northern next
;bigsxx(*,*,nnn)=congrid(sxx(0:319,161:220)*cond_norm,nlon,nlat)
;bigsxy(*,*,nnn)=congrid(sxy(0:319,161:220)*cond_norm,nlon,nlat)
;bigsyy(*,*,nnn)=congrid(syy(0:319,161:220)*cond_norm,nlon,nlat)
;;bigpow(*,*,nnn)=congrid(pow(0:319,161:220)*pow_norm,nlon,nlat)
;bigpow(*,*,nnn)=congrid(pow2(0:319,160:219)*pow_norm,nlon,nlat)
;;bigfac(*,*,nnn)=congrid(fac(0:319,161:220)*fac_norm*1d-3,nlon,nlat)
;bigfac(*,*,nnn)=congrid(fac(0:319,161:220)*fac_norm,nlon,nlat)

bigsxx(*,*,nnn)=rebin(sxx(0:319,161:220)*cond_norm,nlon,nlat)
bigsxy(*,*,nnn)=rebin(sxy(0:319,161:220)*cond_norm,nlon,nlat)
bigsyy(*,*,nnn)=rebin(syy(0:319,161:220)*cond_norm,nlon,nlat)
bigpow(*,*,nnn)=rebin(pow(0:319,161:220)*pow_norm,nlon,nlat)
bigfac(*,*,nnn)=rebin(fac(0:319,161:220)*fac_norm,nlon,nlat)

nnn=nnn+1

;  openw,40,output_filename
;  printf,40,fix(year),fix(month),fix(day),fix(hour),fix(minute),format='(i4,4i2)'
;  for long=0,maxlong_is-1 do begin
;  for lat=0,maxlat_is-1 do begin
;    printf,40,long+1,lat+1,90.0-tew_fig(lat)*180.0/pi,fiw_fig(long)*180.0/pi,$
;              sxx(long,lat)*cond_norm,$
;              sxy(long,lat)*cond_norm,$
;              syy(long,lat)*cond_norm,$
;              fac(long,lat)*fac_norm,$
;              pow(long,lat)*pow_norm*1.0e-3,$
;              format='(2i4,2f9.3,3f10.4,2(e12.4))'
;  endfor
;  endfor
;*********************************************************************
; end
;*********************************************************************
  close,30
;  close,40
endfor
endfor

;save,bigsxx,bigsxy,bigsyy,bigpow,bigfac,file='20210512_1min.sav'
;save,bigsxx,bigsxy,bigsyy,bigpow,bigfac,file='20210511_1min.sav'
;save,bigsxx,bigsxy,bigsyy,bigpow,bigfac,file=yyyymmdd+'_nn.sav'
;save,bissxx,bissxy,bissyy,bispow,bisfac,file=yyyymmdd+'_ss.sav'
save,bigsxx,bigsxy,bigsyy,bigpow,bigfac,file=dir+yyyymmdd+'pnn.sav';pot cross
save,bissxx,bissxy,bissyy,bispow,bisfac,file=dir+yyyymmdd+'pss.sav'


;stop

;x=congrid(bigsxx,32,15,144)
;w=congrid(bigsxy,32,15,144)
;z=congrid(bigsyy,32,15,144)
;f=congrid(bigfac,32,15,144)
;p=congrid(bigpow,32,15,144)

;stop
end
