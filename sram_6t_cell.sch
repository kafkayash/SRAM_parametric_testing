v {xschem version=3.4.6RC file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 310 -320 310 -220 {
lab=Qbar}
N 270 -290 270 -250 {
lab=Q}
N 480 -290 480 -250 {
lab=Qbar}
N 440 -320 440 -220 {
lab=Q}
N 270 -190 480 -190 {
lab=GND}
N 270 -350 480 -350 {
lab=VDD}
N 130 -310 130 -260 {
lab=BL}
N 160 -420 160 -300 {
lab=WL}
N 160 -420 570 -420 {
lab=WL}
N 570 -420 570 -310 {
lab=WL}
N 600 -310 600 -270 {
lab=BLB}
N 190 -260 270 -260 {
lab=Q}
N 270 -290 440 -290 {
lab=Q}
N 310 -250 480 -250 {
lab=Qbar}
N 480 -270 540 -270 {
lab=Qbar}
C {sky130_fd_pr/pfet3_01v8_lvt.sym} 290 -320 0 1 {name=M26
L=0.35
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 290 -220 0 1 {name=M17
L=0.15
W=1
body=GND
nf=1 mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 460 -220 0 0 {name=M1
L=0.15
W=1
body=GND
nf=1 mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8_lvt.sym} 460 -320 0 0 {name=M2
L=0.35
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8_lvt
spiceprefix=X
}
C {gnd.sym} 380 -190 0 0 {name=l1 lab=GND}
C {vdd.sym} 360 -350 0 0 {name=l2 lab=VDD}
C {vsource.sym} 40 -450 0 0 {name=VDD value=1.8 savecurrent=false}
C {gnd.sym} 40 -420 0 0 {name=l3 lab=GND}
C {vdd.sym} 40 -480 0 0 {name=l4 lab=VDD}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 160 -280 3 1 {name=M3
L=0.15
W=1
body=GND
nf=1 mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
C {ipin.sym} 130 -310 1 0 {name=p3 lab=BL}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 570 -290 1 0 {name=M4
L=0.15
W=1
body=GND
nf=1 mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
C {ipin.sym} 360 -420 1 0 {name=p1 lab=WL}
C {ipin.sym} 600 -310 1 0 {name=p2 lab=BLB}
C {vsource.sym} 60 -90 0 0 {name=vblb value="pulse(1 0 0 10ns 10ns 50ns 100ns)" savecurrent=false}
C {gnd.sym} 60 -60 0 0 {name=l5 lab=GND}
C {lab_pin.sym} 60 -120 0 0 {name=p4 sig_type=std_logic lab=BLB}
C {vsource.sym} 730 -460 0 0 {name=vbl value="pulse(0 1 0 10ns 10ns 50ns 100ns)" savecurrent=false}
C {gnd.sym} 730 -430 0 0 {name=l6 lab=GND}
C {lab_pin.sym} 730 -490 0 0 {name=p7 sig_type=std_logic lab=BL}
C {vsource.sym} 730 -340 0 0 {name=vwl value="pulse(0 1.3 0 10ns 10ns 50ns 100ns)" savecurrent=false}
C {gnd.sym} 730 -310 0 0 {name=l7 lab=GND}
C {lab_pin.sym} 730 -370 0 0 {name=p5 sig_type=std_logic lab=WL}
C {ipin.sym} 210 -260 1 0 {name=p9 lab=Q}
C {opin.sym} 510 -270 3 0 {name=p6 lab=	Qbar}
C {devices/code.sym} 840 -210 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib $::SKYWATER_MODELS/sky130.lib.spice tt

"
spice_ignore=false}
C {code_shown.sym} 700 -60 0 0 {name=spice only_toplevel=false value=" .dc Vin 0 1.8 0.01"}
C {gnd.sym} 210 -200 0 0 {name=l8 lab=GND}
C {vsource.sym} 210 -230 0 0 {name=Vin value=0 savecurrent=false}
