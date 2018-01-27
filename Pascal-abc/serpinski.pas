program project1;
uses CRT, Graph;

const
  del = 5000;

var
  n,i: byte;
  Xlu,Ylu,Hscr,Wscr,A,x0,y0,h,Z: word;
  PrA: real;

function calcZ(i:byte):word;
begin
  if i=0 then calcZ:=1
    else calcZ:=2*calcZ(i-1)+3;
end;

Procedure SegmBC; begin Linerel(h, h) end;
Procedure SegmDE; begin Linerel(-h, h) end;
Procedure SegmFG; begin Linerel(-h, -h) end;
Procedure SegmHA; begin Linerel(h, -h) end;
Procedure SegmEast; begin Linerel(2*h, 0) end;
Procedure SegmSouth; begin Linerel(0, 2*h) end;
Procedure SegmWest; begin Linerel(-2*h, 0) end;
Procedure SegmNord; begin Linerel(0, -2*h) end;


Procedure LineCD(i: byte); forward;
Procedure LineGH(i: byte); forward;
Procedure LineEF(i: byte); forward;
Procedure LineAB(i: byte);
begin
    if i>0 then begin
      LineAB(i-1); SegmBC; LineCD(i-1); SegmEast;
      LineGH(i-1); SegmHA; LineAB(i-1); delay(del);
    end
end;
Procedure LineCD;
  begin
   if i>0 then begin
    LineCD(i-1); SegmDE; LineEF(i-1); SegmSouth;
    LineAB(i-1); SegmBC; LineCD(i-1); delay(del);
   end
  end;
Procedure LineEF;
  begin
   if i>0 then begin
    LineEF(i-1); SegmFG; LineGH(i-1); SegmWest;
    LineCD(i-1); SegmDE; LineEF(i-1); delay(del);
  end
end;
Procedure LineGH;
  begin
   if i>0 then begin
    LineGH(i-1); SegmHA; LineAB(i-1); SegmNord;
    LineEF(i-1); SegmFG; LineGH(i-1); delay(del);
   end
end;

var
  grDriver, grMode: smallint;

BEGIN
  clrscr;
  i:=1;
  write('base sqare width (1% .. 100%) :'); readln(PrA);
  write('level : '); readln(n);

  grDriver := Detect;
  initgraph(grDriver, grMode, '');

  Hscr:=GetMaxY+1;
  Wscr:=GetMaxX+1;
  A:=Round(PrA / 100 * Hscr);
  Z:=calcZ(n);

  h:=round(A/(Z+1));

  Xlu:=Wscr div 2 - a div 2;
  Ylu:=Hscr div 2 - a div 2;

  y0:=Ylu; x0:=Xlu+h;
  moveto(x0, y0);

  LineAB(n); SegmBC; LineCD(n); SegmDE;
  LineEF(n); SegmFG; LineGH(n); SegmHA;
  readln;

  closegraph;
END.
