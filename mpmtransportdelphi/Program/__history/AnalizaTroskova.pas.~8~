unit AnalizaTroskova;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Rtti, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Grid, FMX.ListBox, FMX.Edit, Data.DB, Data.Win.ADODB,System.DateUtils;

type
  TForm11 = class(TForm)
    SpeedButton1: TSpeedButton;
    edtGodina: TEdit;
    cmbMesec: TComboBox;
    btnPrikazi: TButton;
    grid: TStringGrid;
    lblUkupnoPlanirano: TLabel;
    lblUkupnoOstvareno: TLabel;
    gridOdluke: TStringGrid;
    ADOQuery1: TADOQuery;
    ADOConnection1: TADOConnection;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    StringColumn4: TStringColumn;
    StringColumn5: TStringColumn;
    StringColumn6: TStringColumn;
    StringColumn7: TStringColumn;
    StringColumn8: TStringColumn;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPrikaziClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form11: TForm11;

implementation

uses Menadzer;

{$R *.fmx}

procedure TForm11.btnPrikaziClick(Sender: TObject);
var
  Godina, Mesec, Row: Integer;
  Planirano, Ostvareno, Razlika, Procenat, UkPlan, UkOstv: Double;
begin
      Godina := StrToIntDef(edtGodina.Text, YearOf(Date));
  Mesec := cmbMesec.ItemIndex + 1;

  // --- Tabela: planirano vs ostvareno po kategoriji ---
  ADOQuery1.Close;
  ADOQuery1.SQL.Text :=
    'SELECT k.Naziv, ' +
    '(SELECT Sum(p.PlaniraniIznos) FROM PlanTroska p WHERE p.KategorijaID = k.ID ' +
    '  AND p.Godina = :g1 AND p.Mesec = :m1) AS Planirano, ' +
    '(SELECT Sum(t.Iznos) FROM Trosak t WHERE t.KategorijaID = k.ID ' +
    '  AND Year(t.Datum) = :g2 AND Month(t.Datum) = :m2) AS Ostvareno ' +
    'FROM KategorijaTroska k ORDER BY k.Naziv';
  ADOQuery1.Parameters.ParamByName('g1').Value := Godina;
  ADOQuery1.Parameters.ParamByName('m1').Value := Mesec;
  ADOQuery1.Parameters.ParamByName('g2').Value := Godina;
  ADOQuery1.Parameters.ParamByName('m2').Value := Mesec;
  ADOQuery1.Open;

  grid.RowCount := 1;
  Row := 0;
  UkPlan := 0;
  UkOstv := 0;
  while not ADOQuery1.Eof do
  begin
    grid.RowCount := Row + 1;

    if ADOQuery1.FieldByName('Planirano').IsNull then Planirano := 0
    else Planirano := ADOQuery1.FieldByName('Planirano').AsFloat;

    if ADOQuery1.FieldByName('Ostvareno').IsNull then Ostvareno := 0
    else Ostvareno := ADOQuery1.FieldByName('Ostvareno').AsFloat;

    Razlika := Ostvareno - Planirano;
    if Planirano > 0 then Procenat := (Ostvareno / Planirano) * 100 else Procenat := 0;

    grid.Cells[0, Row] := ADOQuery1.FieldByName('Naziv').AsString;
    grid.Cells[1, Row] := FormatFloat('#,##0.00', Planirano);
    grid.Cells[2, Row] := FormatFloat('#,##0.00', Ostvareno);
    grid.Cells[3, Row] := FormatFloat('#,##0.00', Razlika);
    grid.Cells[4, Row] := FormatFloat('0.0', Procenat) + ' %';

    UkPlan := UkPlan + Planirano;
    UkOstv := UkOstv + Ostvareno;

    Inc(Row);
    ADOQuery1.Next;
  end;
  ADOQuery1.Close;

  lblUkupnoPlanirano.Text := 'Ukupno planirano: ' + FormatFloat('#,##0.00', UkPlan) + ' din';
  lblUkupnoOstvareno.Text := 'Ukupno ostvareno: ' + FormatFloat('#,##0.00', UkOstv) + ' din';

  // --- Tabela: odluke koje su vec upisane u bazu za ovaj period ---
  ADOQuery1.SQL.Text :=
    'SELECT o.Godina, o.Mesec, k.Naziv AS Kategorija, o.TekstOdluke ' +
    'FROM OdlukaTroskovi o LEFT JOIN KategorijaTroska k ON k.ID = o.KategorijaID ' +
    'WHERE o.Godina = :g3 AND o.Mesec = :m3 ' +
    'ORDER BY o.DatumOdluke DESC';
  ADOQuery1.Parameters.ParamByName('g3').Value := Godina;
  ADOQuery1.Parameters.ParamByName('m3').Value := Mesec;
  ADOQuery1.Open;

  gridOdluke.RowCount := 1;
  Row := 0;
  while not ADOQuery1.Eof do
  begin
    gridOdluke.RowCount := Row + 1;
    gridOdluke.Cells[0, Row] := ADOQuery1.FieldByName('Mesec').AsString + '/' + ADOQuery1.FieldByName('Godina').AsString;
    if ADOQuery1.FieldByName('Kategorija').IsNull then
      gridOdluke.Cells[1, Row] := 'Sve kategorije'
    else
      gridOdluke.Cells[1, Row] := ADOQuery1.FieldByName('Kategorija').AsString;
    gridOdluke.Cells[2, Row] := ADOQuery1.FieldByName('TekstOdluke').AsString;
    Inc(Row);
    ADOQuery1.Next;
  end;
  ADOQuery1.Close;
end;

procedure TForm11.FormCreate(Sender: TObject);
begin
                ADOConnection1.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;' +
    'Data Source=' + ExtractFilePath(ParamStr(0)) + 'mpmtransport.mdb;';
  ADOConnection1.LoginPrompt := False;
  ADOConnection1.Connected := True;

  cmbMesec.Items.Text :=
    'Januar'#13'Februar'#13'Mart'#13'April'#13'Maj'#13'Jun'#13 +
    'Jul'#13'Avgust'#13'Septembar'#13'Oktobar'#13'Novembar'#13'Decembar';
  cmbMesec.ItemIndex := MonthOf(Date) - 1;
  edtGodina.Text := YearOf(Date).ToString;
end;




procedure TForm11.FormShow(Sender: TObject);
begin
               btnPrikaziClick(nil);
end;

procedure TForm11.SpeedButton1Click(Sender: TObject);
begin
            Form3.Show;
            Close;
end;

end.
