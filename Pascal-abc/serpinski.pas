program Serpinski;
// Программа построения кривой Серпинского
// Описание алгоритма и параметры крвой см.
// http://inf.1september.ru/1999/art/zlat2.htm

uses GraphABC;

const
  delay = 50;      // Задержка (мс) после рисования каждого сегмента

var
  n: byte;         // Порядок кривой
  Hscr,Wscr: word; // Высота и ширна экрана
  Xlu,Ylu: word;   // Координаты левой верхней точки опорного квадрата
  x0,y0: word;     // Координаты начальной точки кривой
  A: word;         // Длина стороны опорного квадрата
  PrA: real;       // Длина стороны опорного квадрата в % от высоты экрана
  h: word;         // Длина горизонтальной (и вертикальной) ПРОЕКЦИ наклонных отрезков кривой
  Z: word;         // Коэффициент диагонали кривой Серпинского
  
// Функция, рекурсивно вычисляющая коэффициент  диагонали кривой Серпинского (Z)
function calcZ(i:byte):word;
begin
  if i=0 then calcZ:=1
    else calcZ:=2*calcZ(i-1)+3;
end;

// Процедуры рисования наклонных, горизонтальных и вертикальных отрезков кривой
Procedure SegmBC; begin Linerel(h, h) end;
Procedure SegmDE; begin Linerel(-h, h) end;
Procedure SegmFG; begin Linerel(-h, -h) end;
Procedure SegmHA; begin Linerel(h, -h) end;
Procedure SegmEast; begin Linerel(2*h, 0) end;
Procedure SegmSouth; begin Linerel(0, 2*h) end;
Procedure SegmWest; begin Linerel(-2*h, 0) end;
Procedure SegmNord; begin Linerel(0, -2*h) end;

// Pекурсивные процедуры рисования четырех частей кривой Серпинского
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
  
  // Высота и ширина экрана
  Hscr:=Window.Height;
  Wscr:=Window.Width;

  // Порядок кривой
  n := 3;

  // Длина стороны опорного квадрата в % от высоты экрана
  PrA := 100;

  // Длина стороны опорного квадрата
  A:=Round(PrA / 100 * Hscr);

  // Коэффициент диагонали кривой Серпинского
  Z:=calcZ(n);
  // Длина горизонтальной (и вертикальной) ПРОЕКЦИ наклонных отрезков кривой
  // сами горизонтальные и вертикальные отрезки имеют длину 2h.
  h:=round(A/(Z+1));

  // Находим координаты левой верхней точки опорного квадрата
  Xlu:=Hscr div 2 - A div 2;
  Ylu:=Hscr div 2 - A div 2;

  // Находим координаты начальной точки кривой
  y0:=Ylu; x0:=Xlu+h;
  moveto(x0, y0);

  LineAB(n); SegmBC; LineCD(n); SegmDE;
  LineEF(n); SegmFG; LineGH(n); SegmHA;
  
END.
