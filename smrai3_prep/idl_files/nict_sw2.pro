;-------------------------------------------------------------
;+
; NAME:
;       YMD2DN
; PURPOSE:
;       Convert from year, month, day to day number of year.
; CATEGORY:
; CALLING SEQUENCE:
;       dy = ymd2dn(yr,m,d)
; INPUTS:
;       yr = year (like 1988).      scalar or vector
;       m = month number (like 11 = Nov).   scalar or vector
;       d = day of month (like 5).        scalar or vector
; KEYWORD PARAMETERS:
; OUTPUTS:
;       dy = day number in year (like 310).  out
; COMMON BLOCKS:
; NOTES:
; MODIFICATION HISTORY:
;       Written by R. Sterner, 20 June, 1985.
;       Johns Hopkins University Applied Physics Laboratory.
;       RES 18 Sep, 1989 --- converted to SUN
;       R. Sterner, 1997 Feb 3 --- Made work for arrays.
;
; Copyright (C) 1985, Johns Hopkins University/Applied Physics Laboratory
; This software may be used, copied, or redistributed as long as it is not
; sold and this copyright notice is reproduced on each copy made.  This
; routine is provided as is without any express or implied warranties
; whatsoever.  Other limitations apply as described in the file disclaimer.txt.
; Converted to IDL V5.0   W. Landsman  2-Jan-1998
;-
;-------------------------------------------------------------

function ymd2dn,yr,m,d, help=hlp

  if (n_params(0) lt 3) or keyword_set(hlp) then begin
    print,' Convert from year, month, day to day number of year.'
    print,' dy = ymd2dn(yr,m,d)'
    print,'   yr = year (like 1988).               in'
    print,'   m = month number (like 11 = Nov).    in'
    print,'   d = day of month (like 5).           in'
    print,'   dy = day number in year (like 310).  out'
    return, -1
  endif

  ;----  Days before start of each month (non-leap year)  -----
  idays = [0,31,59,90,120,151,181,212,243,273,304,334,366]

  ;----  Correct for leap year if month ge 3  -------------
  lpyr = (((yr mod 4) eq 0) and ((yr mod 100) ne 0)) $
    or ((yr mod 400) eq 0) and (m ge 3)

  dy = d + idays[m-1] + lpyr
  return, dy

end

;***************************
FUNCTION INTERPOL_RK,x,y,xx,yrange=yrange,_extra=e
  ;+
  ; NAME:
  ; INTERPOL_RK
  ;
  ; PURPOSE:
  ; FAST interpolation of data with possible bad values.
  ;
  ; CALLING SEQUENCE:
  ; yy = interpol_RK(x,y,xx,yrange=[-10,10],/cubic)
  ;
  ; INPUTS:
  ; x,y: input points.
  ; xx : desired x values.
  ;
  ; KEYWORD PARAMETERS:
  ; yrange: Values out of yrange are considered missing.
  ;
  ; OUTPUTS:
  ; yy = interpolated y values.
  ;
  ; MODIFICATION HISTORY:
  ; Ryuho Kataoka, April, 2003
  ;-

  x2=x & y2=y

  if (n_elements(yrange) eq 2) then begin
    ok=where( (y gt min(yrange)) and $
      (y lt max(yrange)),count)
    if count gt 0 then begin
      y2=y(ok)
      x2=x(ok)
    endif
  endif

  yi = interpol(dindgen(n_elements(y2)),x2,xx)
  yy = interpolate(y2,yi,_extra=e)

  return,yy

END

pro nict_sw,year,month,day

;  real*4 N0,mu0,J0
;  parameter (tunit=2.0) ! minutes for time
;  parameter (B0=10.0E-9) ! T for magnetic field
;  parameter (V0=5.32E4) ! m/sec for flow velocity
;  parameter (rho0=1.67E-20) ! kg/m^3 for plasma mass density (=10/cc proton)
;  parameter (P0=4.69E-11) ! Pa for plasma pressure
;  parameter (J0=1.25E-9) ! A/m^2 for magnetospheric current density
;  parameter (F0=0.80E-9) ! J/m^2 for Poynting flux
;  parameter (E0=5.32E-4) ! V/m for electric field
;  parameter (POT0=3.39E3)! V for potential
;  parameter (N0=10.0) ! 10/cc
;  parameter (temp0=340000.0/11604.0) ! temperature in eV
;  parameter (Re=6.37E6) ! Earth's radius in m
;  parameter (mu0 =1.26E-6) ! magnetic permeability of vacuum
;  parameter (Boltzmann=1.38e-23/1.67e-27) ! Boltzmann constant (J/K)

;> YYYYMMDD, hh, mm, d, -Vx_sm, +By_sm, Bz_sm, Pth, Vz_sm, -Bx_sm, 通し時間
;  20210513  0  0        0.448        9.620       -0.580       -0.265        0.843       -2.613       -1.242    15662.000
;  20210513  0  1        0.418        9.610       -0.580       -0.266        0.709       -2.570       -1.242    15662.500
;  20210513  0  2        0.418        9.610       -0.570       -0.264        0.709       -2.579       -1.252    15663.000
  


;  parameter (B0=10.0E-9) ! T for magnetic field
;  parameter (V0=5.32E4) ! m/sec for flow velocity
;  parameter (rho0=1.67E-20) ! kg/m^3 for plasma mass density (=10/cc proton)
;  parameter (N0=10.0) ! 10/cc

v0=5.32E4
b0=10.0E-9
n0=10.0

;dir='D:\nict03\'
;dir='D:\nict03\';bat5a
dir='D:\nict05\';bat5b
;cd,'C:\Users\rk\Desktop\desk0003\nict02
cd,dir

;CD,'E:\nict02c\';earlier events in nov2021
;CD,'E:\nict\';earlier events in nov2021

yyyymmdd=string(year,'(I4.4)')+string(month,'(I2.2)')+string(day,'(I2.2)')

doy=ymd2dn(year,month,day)
doys=sin(float(doy)/365.*2.*!pi)
doyc=cos(float(doy)/365.*2.*!pi)

;fn='20210729sw.txta'
fn=yyyymmdd+'sw.txta'
nl=0
d=fltarr(11)
tt=fltarr(1445)
ts=fltarr(1445)
tc=fltarr(1445)
nn=fltarr(1445)
vv=fltarr(1445)
by=fltarr(1445)
bz=fltarr(1445)

openr,1,fn
;for i=0,1440-1 do begin
while EOF(1) ne 1 do begin
readf,1,d
t=d(1)*60+d(2)
n=d(3)*n0
v=d(4)*v0
y=d(5)*b0
z=d(6)*b0

tt(nl)=t
ts(nl)=sin(float(t)/1440.*2.*!pi)
tc(nl)=cos(float(t)/1440.*2.*!pi)
nn(nl)=n
vv(nl)=v
by(nl)=y
bz(nl)=z

;endfor
nl=nl+1
endwhile
close,1

tt=tt(0:nl-1)
ts=ts(0:nl-1)
tc=tc(0:nl-1)
nn=nn(0:nl-1)
vv=vv(0:nl-1)
by=by(0:nl-1)
bz=bz(0:nl-1)

t2=findgen(1440)
n2 = interpol_RK(tt,nn,t2)
v2 = interpol_RK(tt,vv,t2)*1d-3
y2 = interpol_RK(tt,by,t2)*1d9
z2 = interpol_RK(tt,bz,t2)*1d9

ds2=fltarr(1440)+doys
dc2=fltarr(1440)+doyc
ts2=interpol_RK(tt,ts,t2)
tc2=interpol_RK(tt,tc,t2)

;save,n2,v2,y2,z2,file='20210729_1sw.sav'
save,ds2,dc2,ts2,tc2,n2,v2,y2,z2,file=dir+yyyymmdd+'_ssw.sav';season+ solar wind

;stop

end
