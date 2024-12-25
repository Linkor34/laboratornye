program matrix6;

const
  nmax = 10;

type
  matrix = array [1..nmax, 1..nmax] of integer;

var
  a: matrix;
  m, n, i, j, ind: integer;
  icolumn, kreplace: integer;
  column_ex, sorted: boolean;
  f: Textfile;
  x, y: integer;

begin
  if ParamCount < 2 then
    writeln('Недостаточно параметров!')
  else
  begin
    AssignFile(f, ParamStr(1));
    Reset(f);

    writeln('Введите количество строк и столбцов');
    readln( n, m);
    if (n < 1) or (n > nmax) or (m < 1) or (m > nmax) then
    begin
      writeln('Некорректные размеры матрицы. Размеры должны быть от 1 до ', nmax);
      CloseFile(f);
    end;
    for x := 1 to n do
      for y := 1 to m do
        read(f, a[ x, y]);
    CloseFile(f);

    AssignFile(f, ParamStr(2));
    Rewrite(f);

    writeln(f, 'Массив из ', n, ' строк ', m, ' столбцов ');
    writeln(f, 'Исходная матрица');
    for x := 1 to n do
    begin
      for y := 1 to m do
        write(f, a[ x, y], ' ');
      writeln(f)
    end;
    writeln(f);

   sorted := true;
    j := m;
    while (j >= 1) and (not sorted) do
    begin
      i := 1;
      sorted:=true;
      while (i < n) and sorted do
      begin
        if a[i, j] >= a[i + 1, j] then
           sorted:=false
        else
        i := i + 1;;
      end;
      j:=j-1; // переходить только тогда когда нужну
    end;
    icolumn := j; // нужно с условием

    if column_ex then
      writeln(f,'Номер упорядоченного столбца = ', icolumn)
    else
      writeln(f,'В матрице нет упорядоченного столбца ');
    writeln(f);

    if column_ex then
      ind := icolumn
    else
      ind := 1;
    while ind <= m do
    begin
      kreplace := 0;
      i:=1;
      while i <= n do
      begin
        if a[i, ind] < 0 then
        begin
          kreplace := kreplace + 1;
        end;
        i := i + 1;
      end;
      if kreplace = 0 then
        writeln(f, 'В ', ind, ' столбце нет отрицательных элементов')
      else
        writeln(f, 'Количество замен в столбце ', ind, ' = ', kreplace);
      ind := ind + 1;
      kreplace:=0;
    end;


    if column_ex then
      ind := icolumn
    else
      ind := 1;

    while ind <= m do
    begin
      i:=1;
      while i <= n do
      begin
        if a[i, ind] < 0 then
        begin
          a[i,ind] := 0;
        end;
        i := i + 1;
      end;
      ind := ind + 1;
    end;

    writeln(f, 'Полученная матрица');
    for x := 1 to n do
    begin
      for y := 1 to m do
        write(f, a[ x, y], ' ');
      writeln(f);
    end;

    CloseFile(f);

  end;
end.


