10 REM
20 REM             DAMA
30 REM GIOCO ORIGINARIAMENTE PUBBLICATO
40 REM DA SYSTEMS EDITORIALE PER C16/+4
50 REM CONVERTITO PER LM80C COLOR COMPUTER
60 REM DA LEONARDO MILIANI
70 REM
100 GOSUB 8000
110 GOSUB 10000
190 RV=1/3:DIMTC(4),R(4),SC(7,7),CC(27),FC(27):G=-1:TC(2)=SPZ
200 REM
210 REM *** DISEGNA LA DAMIERA ***
220 REM
230 CLS
240 CHAR=160:FORY=0TO21STEP3:FORX=1TO22STEP3:FORI=0TO2
250 LOCATEX,Y+I:PRINTCHR$(CHAR);CHR$(CHAR);CHR$(CHAR);
260 NEXT:IFCHAR=160THENCHAR=161:GOTO280
270 CHAR=160
280 NEXT:IFCHAR=161THENCHAR=160:GOTO286
283 CHAR=161
286 NEXT
290 FORI=0TO7:LOCATE0,1+(I*3):PRINTCHR$(65+I);:NEXT
295 FOR I=0TO7:LOCATE2+(I*3),0:PRINTCHR$(49+I);:NEXT
300 MO=0:R(0)=-99:PC=12:PT=12:IS=6144
305 REM *** STATO INIZIALE DELLE PEDINE ***
310 FORX=0TO7:FORY=0TO7:IF(-1)^(X+Y)>0THEN350
320 IFY<3THENSC(X,Y)=1:GOTO350
330 IFY>4THENSC(X,Y)=-1:GOTO350
340 SC(X,Y)=0
350 NEXT:NEXT
360 TC(0)=192:TC(1)=193:TC(3)=163:TC(4)=162
365 REM TC(0)=PEDINA NERA;TC(1)=DAMA NERA;TC(2)=SPAZIO
366 REM TC(3)=PEDINA BIANCA;TC(4)=DAMA BIANCA
370 GOSUB1760:YCUR=2:PSX=25:GOTO1290
380 FORX=0TO7:FORY=0TO7:IFSC(X,Y)>-1THEN410
390 IFSC(X,Y)=-1THENFORA=-1TO1STEP2:B=G:MA=0:MC=0:GOSUB420:NEXT
400 IFSC(X,Y)=-2THEN407
403 GOTO 410
407 FORA=-1TO1STEP2:FORB=-1TO1STEP2:MA=0:MC=0:GOSUB420:NEXTB,A
410 NEXTY,X:GOSUB1880:GOTO1100
420 U=X+A:V=Y+B:IFU<0ORU>7ORV<0ORV>7THEN480
430 IFSC(U,V)<0THEN480
440 IFSC(X,Y)=-1ANDSC(U,V)=2THEN480
450 IFSC(U,V)=0THENGOSUB490:GOTO480
460 U=U+A:V=V+B:IFU<0ORU>7ORV<0ORV>7THEN480
470 IFSC(U,V)=0THENPNS=1:GOSUB490
480 RETURN
490 REM
500 IFABS(Y-V)=2THENQ=99:MA=1
510 IFMA=1ANDSC(X,Y)=-2THENQ=Q+50
520 IFMA=0THEN600
530 UU=(X+U)/2:VV=(Y+V)/2
540 IFSC(X,Y)=-2THENQ=Q+50
550 X1=4*UU-3*X:Y1=4*VV-3*Y:IFX1<0ORX1>7ORY1<0ORY1>7THEN570
560 IFSC(3*UU-2*X,3*VV-2*Y)=1ANDSC(X1,Y1)=0THENQ=Q+10:GOTO1060
570 IFY1<0ORY1>7THEN1060
580 IFSC(UU,3*VV-2*Y)=1ANDSC(X,Y1)=0THENQ=Q+10
590 GOTO1060
600 FORC=-1TO1STEP2:IFU+C<0ORU+C>7ORV+G<0THEN700
610 IFU-C<0ORU-C>7ORV-G>7THEN700
620 IFSC(U+C,V+G)>0AND(SC(U-C,V-G)=0OR(U-C=XANDV-G=Y))THENQ=Q-45:MC=1
630 IFMC=0THEN700
640 MC=0:X1=X-2:Y1=Y+2:IFX1<0ORX1>7ORY1<0ORY1>7THEN670
650 IFSC(X-1,Y+1)=-1ANDSC(X1,Y1)=0THENTP=1:Q=-97
660 IFTP=1ANDY1=7THENQ=-98:TP=0:MC=0:GOTO700
670 X1=X+2:IFX1<0ORX1>7ORY1<0ORY1>7THEN700
680 IFSC(X+1,Y+1)=-1ANDSC(X1,Y1)=0THENTP=1:Q=-97
690 IFTP=1ANDY1=7THENQ=-98:TP=0
700 NEXTC:GOSUB2260:IFSC(X,Y)=-2THENGOSUB1960:GOTO1060
710 IFY=1THENQ=Q+15
720 IFFC(10)=0THEN800
730 IFY<4AND(U=0ORU=7)ANDCC(10)=0THENQ=Q+15
740 IFFC(18)=0THEN800
750 IFCC(18)>0THEN1060
760 IFY<4ANDCC(10)=0ANDCC(17)<>2ANDCC(18)=0THENQ=Q+15
770 IFCC(10)<>0ANDCC(17)<>0ANDCC(18)=0THENSW=1:Q=Q+5
780 IFSW=1ANDY<3THENQ=Q+10:SW=0
790 IF(CC(10)=0ANDCC(17)=2)OR(CC(10)=2ANDCC(17)=0)THENQ=Q-30
800 IFFC(2)=0ORFC(16)=0THEN830
810 IFCC(2)>0ANDCC(5)=-1ANDCC(12)=-1ANDCC(16)=0THENQ=Q-30
820 IFCC(16)=2ANDCC(12)<0ANDCC(5)<0ANDCC(2)=0THENQ=Q-40
830 IFFC(6)=0ORFC(17)=0THEN850
840 IFCC(17)<>0ANDCC(10)>0ANDCC(6)=0THENQ=Q+5
850 IFFC(6)=0THEN880
860 IFCC(6)=0ANDCC(10)=1AND(U=7ORU=0)THENQ=Q+5
870 IFCC(6)>0ANDCC(10)<0THENQ=Q+35
880 IFFC(22)=0THEN900
890 IFCC(22)>0ANDCC(18)=-1THENQ=Q+35
900 IFFC(5)=0ORFC(2)=0THEN920
910 IFCC(5)=-1ANDCC(2)>0THENQ=Q-30
920 IFFC(5)=0THEN940
930 IFY=7ANDCC(5)=1THENQ=Q-20
940 IFY=7ANDPC>7THENQ=Q-8
950 IFY=6ANDPC>8THENQ=Q-7
960 IFFC(4)=0THEN980
970 IFCC(4)=2THENQ=Q+40
980 IFFC(12)=0ORFC(5)=0THEN1000
990 IFCC(12)=2ANDCC(5)=0THENQ=Q+40
1000 IFFC(5)=0ORFC(12)=0THEN1020
1010 IFCC(5)>0ANDCC(12)=0THENQ=Q+40
1020 IFFC(14)=0ORFC(18)=0THEN1040
1030 IFCC(10)=-1ANDCC(18)=-1ANDCC(14)=-1THENQ=Q+10
1040 IFFC(21)=0THEN1060
1050 IFCC(17)=-1ANDCC(18)=-1ANDCC(21)=-1THENQ=Q+10
1060 LOCATEPSX,2:IFPNS=1THENPNS=0:C$=" PENSO ":GOTO1070
1065 PNS=1:C$="       "
1070 PRINTC$;:GOTO1080
1080 IFQ>R(0)THENR(0)=Q:R(1)=X:R(2)=Y:R(3)=U:R(4)=V
1090 Q=0:RETURN
1100 IFR(0)=-99THEN1580
1110 MO=MO+1:LOCATEPSX,0:PRINT"M.:";MO;
1120 LOCATEPSX,2:PRINT"CPU  ";:GOSUB1740
1125 LOCATEPSX,3:PRINT"DA  ";C$
1130 GOSUB1750:YCUR=4:LOCATEPSX,YCUR:PRINT"IN  ";C$
1140 R(0)=-99
1150 IFR(4)=0THENSC(R(3),R(4))=-2:GOTO1170
1160 SC(R(3),R(4))=SC(R(1),R(2))
1170 SC(R(1),R(2))=0:IFABS(R(1)-R(3))<>2THEN1280
1180 SC((R(1)+R(3))/2,(R(2)+R(4))/2)=0
1190 X=R(3):Y=R(4):IFSC(X,Y)=-1THENB=-2:FORA=-2TO2STEP4:GOSUB1240
1200 IFSC(X,Y)=-2THENFORA=-2TO2STEP4:FORB=-2TO2STEP4:GOSUB1240:NEXTB
1210 NEXTA
1220 IFR(0)<>-99THENGOSUB1750:GOSUB1235:GOTO1150
1230 PRINT:GOTO1280
1235 YCUR=YCUR+1:LOCATEPSX,YCUR:PRINT"IN  ";C$:R(0)=-99:RETURN
1240 U=X+A:V=Y+B:IFU<0ORU>7ORV<0ORV>7THEN1270
1250 IFSC(X,Y)=-1ANDSC(U,V)=2THENR(0)=-99:GOTO1270
1260 IFSC(U,V)=0ANDSC(X+A/2,Y+B/2)>0THENGOSUB490
1270 RETURN
1280 GOSUB1760
1282 REM
1285 REM *** MOSSA GIOCATORE ***
1287 REM
1290 YCUR=YCUR+2:LOCATEPSX,YCUR:PRINT"TU";:YCUR=YCUR+1
1300 LOCATEPSX,YCUR:INPUT"DA";A$:GOSUB1600:X=E:Y=H
1310 IFX<0ORY<0THENLOCATEPSX,YCUR:PRINTSPC(4);:GOTO1300
1320 IFSC(X,Y)<=0THENLOCATEPSX,YCUR:PRINTSPC(4);:GOTO1300
1330 IFWQC=1THENWQC=0:LOCATEPSX,YCUR:PRINTSPC(4);:GOTO1300
1340 YCUR=YCUR+1:LOCATEPSX,YCUR:INPUT"IN";A$:GOSUB1700:X=A:Y=B
1350 IFWQC=1THENWQC=0:LOCATEPSX,YCUR:PRINTSPC(4);:GOTO1340
1360 QWC=SC((E+A)/2,(H+B)/2)
1370 GOSUB1650
1373 IFWQC=1ANDQWC>=0ANDABS(B-H)<=2THEN1378
1375 GOTO 1380
1378 WQC=0:LOCATEPSX,YCUR:PRINTSPC(4);:YCUR=YCUR-1:GOTO1300
1380 IFB-H<0ANDSC(E,H)=1THEN1430
1390 IFABS(B-H)=2ANDQWC>=0THEN1430
1400 IFABS(B-H)=2ANDQWC=-2ANDSC(E,H)=1THEN1430
1410 IFSC(X,Y)<>0ORABS(A-E)>2ORABS(A-E)<>ABS(B-H)THEN1430
1420 GOTO1440
1430 YCUR=YCUR+1:LOCATEPSX,YCUR:GOTO1340
1440 SC(A,B)=SC(E,H):SC(E,H)=0:IFABS(E-A)<>2THEN1520
1450 SC((E+A)/2,(H+B)/2)=0:GOSUB1760
1460 FORJ=-1TO1STEP2:FORK=-1TO1STEP2:X2=A+2*K:Y2=B+2*J
1470 IFX2<0ORX2>7ORY2<0ORY2>7THEN1510
1480 X1=A+K:Y1=B+J:IFX1<0ORX1>7ORY1<0ORY1>7THEN1510
1490 IFSC(A,B)=1ANDSC(X2,Y2)=0ANDSC(X1,Y1)=-1ANDJ=1THEN1550
1500 IFSC(A,B)=2ANDSC(X2,Y2)=0ANDSC(X1,Y1)<0THEN1550
1510 NEXT:NEXT
1520 GOTO1560
1530 REM
1540 REM
1550 E=A:H=B:GOTO1340
1560 IFB=7THENSC(A,B)=2
1570 MO=MO+1:LOCATEPSX,0:PRINT"M.";MO;:GOSUB1760:GOSUB1800:GOTO380
1580 GOTO1920
1590 END
1596 REM
1597 REM *** CONTROLLA INPUT GIOCATORE (DA?) ***
1598 REM
1600 H=72-ASC(MID$(A$,1)):E=VAL(MID$(A$,2))-1
1610 IFH<0ORH>7ORE<0ORE>7ORH=-24THEN1640
1620 IF(-1)^(E+H)>0THEN1640
1630 WQC=0:RETURN
1640 WQC=1:RETURN
1650 IN=IS-96*H+3*E+706
1660 IFSC(E,H)=1THEN1680
1670 IFVPEEK(IN+99)=SPZORVPEEK(IN+93)=SPZTHENRETURN
1680 IFVPEEK(IN-99)=SPZORVPEEK(IN-93)=SPZTHENRETURN
1690 WQC=1:RETURN
1696 REM
1697 REM *** CONTROLLA INPUT GIOCATORE (A?) ***
1698 REM
1700 B=72-ASC(MID$(A$,1)):A=VAL(MID$(A$,2))-1
1710 IFB<0ORB>7ORA<0ORA>7ORB=-24THENWQC=1:RETURN
1720 IF(-1)^(B+A)<0THENRETURN
1730 WQC=1:RETURN
1740 C$=CHR$(72-R(2))+CHR$(R(1)+49):RETURN
1750 C$=CHR$(72-R(4))+CHR$(R(3)+49):RETURN
1754 REM
1755 REM *** POSIZIONA LE PEDINE ***
1756 REM
1760 FORY=7TO0STEP-1:FORX=0TO7:IN=IS-96*Y+3*X+706
1770 IF(-1)^(X+Y)>0THEN1790
1780 VPOKEIN,TC(SC(X,Y)+2)
1790 NEXTX,Y:RETURN
1797 REM
1798 REM *** PULISCE LE SCRITTE LATERALI ***
1799 REM
1800 PC=0:PT=0:FORJ=0TO7:FORK=0TO7:S=SC(J,K):IFS=0THEN1830
1810 IFS<0THENPC=PC+2*ABS(S)-1:GOTO1830
1820 PT=PT+2*ABS(S)-1
1830 NEXT:NEXT
1840 FOR I=1TO22
1850 LOCATEPSX,I
1860 PRINTSPC(32-PSX);:NEXT
1870 LOCATEPSX,22:PRINT"C"+STR$(PC);:LOCATEPSX,23:PRINT"G"+STR$(PT);
1880 REM FORI=6TO22:FORJ=28TO39:VPOKEIS+32*I+J,96:NEXT:NEXT
1890 IFPC/PT<=RVTHEN1920
1900 IFPT/PC<=RVTHEN1930
1910 RETURN
1920 LOCATEPSX,2:PRINT"HAI";:LOCATEPSX,3:PRINT"VINTO";:GOTO1950
1930 LOCATEPSX,2:PRINT"LA CPU";:LOCATEPSX,3:PRINT"VINCE!";:GOTO1950
1950 PAUSE300:RUN
1960 IFFC(18)=0THEN2090
1970 IFMC=1ANDCC(18)=1ORCC(10)=1ORCC(17)=1THENQ=0:MC=0
1980 IFFC(16)=0THEN2000
1990 IFCC(12)=2ANDCC(16)<>0ANDCC(18)<>2THENQ=Q+60
2000 IFCC(12)=2ANDCC(18)THENQ=Q+60
2010 IFFC(0)=0THEN2030
2020 IFCC(4)=2ANDCC(0)<>0ANDCC(18)<>2THENQ=Q+60
2030 IFCC(4)=2ANDCC(18)<>2THENQ=Q+60
2040 IFCC(18)=2OR(CC(17)=2ANDCC(10)=0)OR(CC(17)=0ANDCC(10)=2)THEN2045
2042 GOTO 2050
2045 Q=-60:RETURN
2050 IFFC(17)=0THEN2070
2060 IFCC(18)=1ANDCC(22)=0ANDCC(27)<>2ANDCC(19)<>2ANDCC(26)<>2THENQ=Q+25
2070 IFFC(22)=0THEN2090
2080 IFCC(18)=1ANDCC(22)=0ANDFC(27)=0THENQ=Q+25
2090 IFFC(24)=0THEN2110
2100 IFCC(17)=1ANDCC(20)=0ANDCC(16)<>2ANDCC(24)<>2ANDCC(25)<>2THENQ=Q+25
2110 IFFC(20)=0THEN2130
2120 IFCC(17)=1ANDCC(20)=0ANDFC(24)=0THENQ=Q+25
2130 IFFC(3)=0THEN2150
2140 IFCC(10)=1ANDCC(6)=0ANDCC(2)<>2ANDCC(3)<>2ANDCC(11)<>2THENQ=Q+25
2150 IFFC(6)=0THEN2170
2160 IFCC(10)=1ANDCC(6)=0ANDFC(3)=0THENQ=Q+25
2170 IFFC(20)=0ORFC(6)=0THEN2190
2180 IFCC(17)>0ANDCC(10)>0ANDCC(6)=0ANDCC(20)=0THENQ=Q+35
2190 IFFC(22)=0THEN2210
2200 IFCC(18)<0ANDCC(22)=2THENQ=Q+25
2210 IFFC(20)=0THEN2230
2220 IFCC(17)<0ANDCC(20)>0THENQ=Q+25
2230 IFFC(6)=0THEN2250
2240 IFCC(10)<0ANDCC(6)=2THENQ=Q+15
2250 Q=Q-5:RETURN
2260 M=0:FORJ=-2TO4:L=J-2*INT((J+2)/2):FORK=LTOL+6STEP2
2270 UU=U:VV=V
2280 IFMA=1THENUU=(X+U)/2:VV=(Y+V)/2
2290 X1=J*(UU-X)+X:Y1=K*(VV-Y)+Y
2300 IFX1<0ORY1<0ORX1>7ORY1>7THENFC(M)=0:GOTO2320
2310 CC(M)=SC(X1,Y1):FC(M)=1
2320 M=M+1:NEXT:NEXT:RETURN
7997 REM
7998 REM *** INITIALIZE SCREEN ***
7999 REM
8000 VOLUME0,15:SCREEN1:VREG7,34:FORI=0TO31:VPOKE8192+I,242:NEXT
8010 RESTORE9030:ADDR=1280:N=4:GOSUB8500:REM LOAD WHITE CHARS
8020 ADDR=1536:N=2:GOSUB8500:REM LOAD BLACK CHARS
8030 VPOKE8212,&HF6:VPOKE8216,&H16
8040 SPZ=160:REM CAMBIARE QUI IL CODICE DEL QUADRO SCURO
8050 RETURN
8500 REM
8510 REM *** LOAD CHAR INTO VRAM ***
8520 REM
8530 FORJ=0TO(N-1):FORI=0TO7:READX:VPOKEADDR+(J*8)+I,X:NEXT:NEXT
8540 RETURN
9000 REM
9010 REM *** PROGRAM DATA ***
9020 REM
9030 DATA 0,0,0,0,0,0,0,0:REM 160->QUADRO SCURO
9040 DATA 255,255,255,255,255,255,255,255:REM 161->QUADRO CHIARO
9050 DATA 60,126,255,255,255,255,126,60:REM 162->DAMA BIANCA
9060 DATA 0,24,60,126,126,60,24,0:REM 163->PEDINA BIANCA
9070 DATA 60,126,255,255,255,255,126,60:REM 192->DAMA NERA
9080 DATA 0,24,60,126,126,60,24,0:REM 193->PEDINA NERA
10000 REM
10010 REM *** WELCOME MESSAGE & RULES ***
10020 REM
10020 CLS:LOCATE12,2:PRINT "D A M A":PRINT
10030 PRINT"IL GIOCO SEGUE LE REGOLE DELLA"
10040 PRINT"DAMA ITALIANA. SEI OBBLIGATO A"
10050 PRINT"MANGIARE. LA PARTITA FINISCE O"
10060 PRINT"PER SCONFITTA TUA O DELLA CPU"
10070 PRINT"OPPURE PER STALLO. IL BIANCO"
10080 PRINT"MUOVE PER PRIMO."
10090 PRINT:PRINT"PREMI UN TASTO...":A=INKEY(0)
10100 A=INKEY(10):IFA=0THEN10100
10110 RETURN
