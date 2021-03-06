155 NC=32
170 CX=32:CY=24:GE=1
185 REM NC=NMBR OF CHAR PER ROW
192 REM CX=MAX. NUM. OF COLS
193 REM CY=MAX. NUM. OF ROWS
194 REM GE=GENERATION
200 :
210 REM CONFIGURATION DATA
215 :
220 DIM P(CY+1,CX+1),IN(CY+1,CX+1),M(CY+1,CX+1)
225 :
230 SCREEN 1
232 LOCATE 13,0:PRINT "WA-TOR":PRINT
235 INPUT "# of rows (20)";LC
237 IF LC<=O OR LC>22 THEN LC=20
240 INPUT "# of cols (30)";LR
242 IF LR<=O OR LR>31 THEN LR=30
245 INPUT "Init. density (0.3)";D
247 IF D<=0 OR D>1 THEN D=0.3
250 INPUT "Init. % of predators (0.2)";NS
252 IF NS<=0 OR NS>1 THEN NS=0.2
255 INPUT "Reprod. time of preys (3)";PP
257 IF PP<=0 THEN PP=3
259 PP=PP+10
260 INPUT "Repr. time of predators (6)";SP
262 IF SP<=0 THEN SP=6
264 SP=SP+1000
265 INPUT "Predator starvation (3)";M
267 IF M<=0 THEN M=3
270 PRINT:PRINT"PLEASE WAIT"
272 PRINT "Populating the world..."
275 :
280 REM * FIRST COMMIT *
285 :
290 FOR I=0 TO LC+1:P(I,0)=1000:P(I,LR+1)=1000:NEXT I
295 FOR J=0 TO LR+1:P(0,J)=1000:P(LC+1,J)=1000:NEXT J
300 FOR I=1 TO LC:FOR J=1 TO LR:A=RND(1)
305 IF A<(1-D) THEN P(I,J)=0:GOTO 320
310 A=RND(1):IF A<NS THEN P(I,J)=1000+INT(RND(1)*SP+1):GOTO 320
315 P(I,J)=10+INT(RND(1)*PP+1)
320 NEXT J,I
325 CLS
330 :
335 REM ** VISUALIZATION **
340 :
345 LOCATE 0,23:PRINT SPC(31);
347 FOR I=1 TO LC:FOR J=1 TO LR:M(I,J)=0:NEXT J,I
349 LOCATE 0,23:PRINT "Showing generation #";GE;
350 XX=0:YY=0:FOR I=1 TO LC:FOR J=1 TO LR
355 IF P(I,J)=0 THEN LOCATE J-1,I:PRINT " ";:GOTO 370
360 IF P(I,J)<1000 THEN LOCATE J-1,I:PRINT".";:XX=XX+1:GOTO 370
365 LOCATE J-1,I:PRINT"+";:YY=YY+1:GOTO 370
370 NEXT J,I
375 LOCATE 0,0:PRINT SPC(30);
380 LOCATE 0,0:PRINT"PREYS =";XX;" PREDATORS =";YY;
382 LOCATE 0,23:PRINT "Computing new generation...  ";:GE=GE+1
385 :
390 REM ** SCROLLING P(I,J) TO LOOK FOR OCCUPIED CELLS **
395 :
400 FOR I=1 TO LC:FOR J=1 TO LR:C=0:S=0
405 IF P(I,J)=0 OR M(I,J)<>O THEN 495
410 IF P(I-1,J)<>0 THEN C=C+1:S=S+P(I-1,J)
415 IF P(I+1,J)<>0 THEN C=C+2:S=S+P(I+1,J)*2
420 IF P(I,J-1)<>0 THEN C=C+4:S=S+P(I,J-1)*4
425 IF P(I,J+1)<>0 THEN C=C+8:S=S+P(I,J+1)*8
430 IF P(I,J)>=1000 THEN 480
435 :
440 REM ** PREYS' MOVEMENT **
445 :
450 ON C GOSUB 520,525,530,535,540,545,550,555,560,565,570,575,580,585
455 IF C=0 THEN A=INT(RND(1)*4+1):ON A GOSUB 590,605,620,635
460 GOTO 495
465 :
470 REM ** PREDATORS' MOVEMENT **
475 :
480 S=INT(S/1000):IF IN(I,J)>M THEN P(I,J)=0:IN(I,J)=0:GOTO 495
485 ONSGOSUB665,670,675,680,685,690,695,700,705,710,715,720,725,730,735
490 IF S=0 THEN A=INT(RND(1)*4+1):ON A GOSUB 740,760,780,800
495 NEXT J,I
500 GOTO 345
505 :
510 REM ** SUB-ROUTINES TO MOVE PREYS **
515 :
520 A=INT(RND(1)*3+1):ON A GOSUB 605,620,635:RETURN
525 A=INT(RND(1)*3+1):ON A GOSUB 590,620,635:RETURN
530 A=INT(RND(1)*2+1):ON A GOSUB 620,635:RETURN
535 A=INT(RND(1)*3+1):ON A GOSUB 590,605,635:RETURN
540 A=INT(RND(1)*2+1):ON A GOSUB 605,635:RETURN
545 A=INT(RND(1)*2+1):ON A GOSUB 590,635:RETURN
550 GOSUB 635:RETURN
555 A=INT(RND(1)*3+1):ON A GOSUB 590,605,620:RETURN
560 A=INT(RND(1)*2+1):ON A GOSUB 605,620:RETURN
565 A=INT(RND(1)*2+1):ON A GOSUB 590,620:RETURN
570 GOSUB 620:RETURN
575 A=INT(RND(1)*2+1):ON A GOSUB 590,605:RETURN
580 GOSUB 605:RETURN
585 GOSUB 590:RETURN
590 QQ=I-1
595 IF P(I,J)>PP THEN P(QQ,J)=10:P(I,J)=10:RETURN
600 P(QQ,J)=P(I,J)+1:P(I,J)=0:RETURN
605 QQ=I+1:M(QQ,J)=1
610 IF P(I,J)>PP THEN P(QQ,J)=10:P(I,J)=10:RETURN
615 P(QQ,J)=P(I,J)+1:P(I,J)=Q:RETURN
620 QQ=J-1
625 IF P(I,J)>PP THEN P(I,QQ)=10:P(I,J)=10:RETURN
630 P(I,QQ)=P(I,J)+1:P(I,J)=0:RETURN
635 QQ=J+1:M(I,QQ)=1
640 IF P(I,J)>PP THEN P(I,QQ)=10:P(I,J)=10:RETURN
645 P(I,QQ)=P(I,J)+1:P(I,J)=0:RETURN
650 :
655 REM ** SUB-ROUTINES TO MOVE PREDATORS **
660 :
665 A=INT(RND(1)*3+1):ON A GOSUB 760,780,800:RETURN
670 A=INT(RND(1)*3+1):ON A GOSUB 740,780,800:RETURN
675 A=INT(RND(1)*2+1):ON A GOSUB 780,800:RETURN
680 A=INT(RND(1)*3+1):ON A GOSUB 740,760,800:RETURN
685 A=INT(RND(1)*2+1):ON A GOSUB 760,800:RETURN
690 A=INT(RND(1)*2+1):ON A GOSUB 740,800:RETURN
695 GOSUB 800:RETURN
700 A=INT(RND(1)*3+1):ON A GOSUB 740,760,780:RETURN
705 A=INT(RND(1)*2+1):ON A GOSUB 760,780:RETURN
710 A=INT(RND(1)*2+1):ON A GOSUB 740,780:RETURN
715 GOSUB 780:RETURN
720 A=INT(RND(1)*2+1):ON A GOSUB 740,760:RETURN
725 GOSUB 760:RETURN
730 GOSUB 740:RETURN
735 IN(I,J)=IN(I,J)+1:RETURN
740 QQ=I-1
745 IFP(I,J)>SP THENP(QQ,J)=1000:P(I,J)=1000:IN(I,J)=IN(I,J)+1:RETURN
750 IFP(QQ,J)>0 THEN IN(I,J)=-1
755 P(QQ,J)=P(I,J)+1:P(I,J)=0:IN(QQ,J)=IN(I,J)+1:IN(I,J)=0:RETURN
760 QQ=I+1:M(QQ,J)=1
765 IFP(I,J)>SP THENP(QQ,J)=1000:P(I,J)=1000:IN(I,J)=IN(I,J)+1:RETURN
770 IF P(QQ,J)>0 THEN IN(I,J)=-1
775 P(QQ,J)=P(I,J)+1:P(I,J)=0:IN(QQ,J)=IN(I,J)+1:IN(I,J)=0:RETURN
780 QQ=J-1
785 IFP(I,J)>SP THEN P(I,QQ)=1000:P(I,J)=1000:IN(I,J)=IN(I,J)+1:RETURN
790 IF P(I,QQ)>0 THEN IN(I,J)=-1
795 P(I,QQ)=P(I,J)+1:P(I,J)=0:IN(I,QQ)=IN(I,J)+1:IN(I,J)=0:RETURN
800 QQ=J+1:M(I,QQ)=1
805 IFP(I,J)>SP THENP(I,QQ)=1000:P(I,J)=1000:IN(I,J)=IN(I,J)+1:RETURN
810 IF P(I,QQ)>0 THEN IN(I,J)=-1
815 P(I,QQ)=P(I,J)+1:P(I,J)=0:IN(I,QQ)=IN(I,J)+1:IN(I,J)=0:RETURN
820 END
