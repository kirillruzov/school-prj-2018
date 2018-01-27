program Serpinski;
// ��������� ���������� ������ �����������
// �������� ��������� � ��������� ����� ��.
// http://inf.1september.ru/1999/art/zlat2.htm

uses GraphABC;

const
  delay = 50;      // �������� (��) ����� ��������� ������� ��������

var
  n: byte;         // ������� ������
  Hscr,Wscr: word; // ������ � ����� ������
  Xlu,Ylu: word;   // ���������� ����� ������� ����� �������� ��������
  x0,y0: word;     // ���������� ��������� ����� ������
  A: word;         // ����� ������� �������� ��������
  PrA: real;       // ����� ������� �������� �������� � % �� ������ ������
  h: word;         // ����� �������������� (� ������������) ������� ��������� �������� ������
  Z: word;         // ����������� ��������� ������ �����������
  
// �������, ���������� ����������� �����������  ��������� ������ ����������� (Z)
function calcZ(i:byte):word;
begin
  if i=0 then calcZ:=1
    else calcZ:=2*calcZ(i-1)+3;
end;

// ��������� ��������� ���������, �������������� � ������������ �������� ������
Procedure SegmBC; begin Linerel(h, h) end;
Procedure SegmDE; begin Linerel(-h, h) end;
Procedure SegmFG; begin Linerel(-h, -h) end;
Procedure SegmHA; begin Linerel(h, -h) end;
Procedure SegmEast; begin Linerel(2*h, 0) end;
Procedure SegmSouth; begin Linerel(0, 2*h) end;
Procedure SegmWest; begin Linerel(-2*h, 0) end;
Procedure SegmNord; begin Linerel(0, -2*h) end;

// P���������� ��������� ��������� ������� ������ ������ �����������
Procedure LineCD(i: byte); forward;
Procedure LineGH(i: byte); forward;
Procedure LineEF(i: byte); forward;
Procedure LineAB(i: byte);
begin
    if i>0 then begin
      LineAB(i-1); SegmBC; LineCD(i-1); SegmEast;
      LineGH(i-1); SegmHA; LineAB(i-1); Sleep(delay);
    end
end;
Procedure LineCD;
  begin
   if i>0 then begin
    LineCD(i-1); SegmDE; LineEF(i-1); SegmSouth;
    LineAB(i-1); SegmBC; LineCD(i-1); Sleep(delay);
   end
  end;
Procedure LineEF;
  begin
   if i>0 then begin
    LineEF(i-1); SegmFG; LineGH(i-1); SegmWest;
    LineCD(i-1); SegmDE; LineEF(i-1); Sleep(delay);
  end
end;
Procedure LineGH;
  begin
   if i>0 then begin
    LineGH(i-1); SegmHA; LineAB(i-1); SegmNord;
    LineEF(i-1); SegmFG; LineGH(i-1); Sleep(delay);
   end
end;

BEGIN

  Window.SetSize(600,600);
  
  // ������ � ������ ������
  Hscr:=Window.Height;
  Wscr:=Window.Width;

  // ������� ������
  n := 3;

  // ����� ������� �������� �������� � % �� ������ ������
  PrA := 100;

  // ����� ������� �������� ��������
  A:=Round(PrA / 100 * Hscr);

  // ����������� ��������� ������ �����������
  Z:=calcZ(n);
  // ����� �������������� (� ������������) ������� ��������� �������� ������
  // ���� �������������� � ������������ ������� ����� ����� 2h.
  h:=round(A/(Z+1));

  // ������� ���������� ����� ������� ����� �������� ��������
  Xlu:=Hscr div 2 - A div 2;
  Ylu:=Hscr div 2 - A div 2;

  // ������� ���������� ��������� ����� ������
  y0:=Ylu; x0:=Xlu+h;
  moveto(x0, y0);

  LineAB(n); SegmBC; LineCD(n); SegmDE;
  LineEF(n); SegmFG; LineGH(n); SegmHA;
  
END.
