unit Unit8;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.DateTimeCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.Objects, Data.DB,
  Data.Win.ADODB  ;

type
  TIsporukaStartStop = class(TForm)
    panelPocetak: TPanel;
    btnStart: TButton;
    TimeEdit1: TTimeEdit;
    Z: TLabel;
    Label2: TLabel;
    tbxPocetnaLokacija: TEdit;
    Label1: TLabel;
    txbPocetnoGorivo: TEdit;
    Label3: TLabel;
    panelUtoku: TPanel;
    btnStop: TButton;
    Timer1: TTimer;
    lblTajmer: TLabel;
    lblVremetrajanjavoznje: TLabel;
    Label4: TLabel;
    btnPauza: TButton;
    panelZavrsi: TPanel;
    lblZavrsi: TLabel;
    TimeEdit2: TTimeEdit;
    Label5: TLabel;
    Label6: TLabel;
    tbxKrajnjaLokacija: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    txbKrajnjeGorivo: TEdit;
    ADOQuery1: TADOQuery;
    ADOConnection1: TADOConnection;
    btnZavrsi: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnPauzaClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnZavrsiClick(Sender: TObject);

  private
  var
  Pauza: Boolean;
  TrenutnaVoznjaID: Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IsporukaStartStop: TIsporukaStartStop;

implementation

{$R *.fmx}

procedure TIsporukaStartStop.btnPauzaClick(Sender: TObject);

begin
        Pauza := not Pauza;
  Timer1.Enabled := not Pauza;

  if Pauza then
    btnPauza.Text := 'Nastavi'
  else
    btnPauza.Text := 'Pauza';
end;

procedure TIsporukaStartStop.btnStartClick(Sender: TObject);
begin
           panelPocetak.Enabled := False;
          Timer1.Enabled := true ;

          ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add(
    'INSERT INTO T_Voznja ' +
    '(VremePocetka, LokacijaPocetak, GorivoPocetak) ' +
    'VALUES (:vp, :lp, :gp)'
  );

  ADOQuery1.Parameters.ParamByName('vp').Value := TimeEdit1.Time;
  ADOQuery1.Parameters.ParamByName('lp').Value := tbxPocetnaLokacija.Text;
  ADOQuery1.Parameters.ParamByName('gp').Value := StrToFloatDef(txbPocetnoGorivo.Text, 0);

  ADOQuery1.ExecSQL;

  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('SELECT @@IDENTITY AS ID');
  ADOQuery1.Open;

  TrenutnaVoznjaID := ADOQuery1.FieldByName('ID').AsInteger;
end;



procedure TIsporukaStartStop.btnStopClick(Sender: TObject);
var
  Sekunde: Integer;
begin
          panelUtoku.Enabled := False;
          Timer1.Enabled := False;

          Sekunde := StrToIntDef(lblTajmer.Text.Replace('s',''), 0);

          ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add(
    'UPDATE T_Voznja SET TrajanjeSekunde = :ts, VremeKraja = :vk ' +
    'WHERE ID = :id'
  );

  ADOQuery1.Parameters.ParamByName('ts').Value := Sekunde;
  ADOQuery1.Parameters.ParamByName('vk').Value := Time;
  ADOQuery1.Parameters.ParamByName('id').Value := TrenutnaVoznjaID;

  ADOQuery1.ExecSQL;
end;

procedure TIsporukaStartStop.btnZavrsiClick(Sender: TObject);

begin
         ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add(
    'UPDATE T_Voznja SET ' +
    'VremeKraja = :vk, ' +
    'LokacijaKraj = :lk, ' +
    'GorivoKraj = :gk ' +
    'WHERE ID = :id'
  );

  ADOQuery1.Parameters.ParamByName('vk').Value := TimeEdit2.Time;
  ADOQuery1.Parameters.ParamByName('lk').Value := tbxKrajnjaLokacija.Text;
  ADOQuery1.Parameters.ParamByName('gk').Value := StrToFloatDef(txbKrajnjeGorivo.Text, 0);
  ADOQuery1.Parameters.ParamByName('id').Value := TrenutnaVoznjaID;

  ADOQuery1.ExecSQL;
end;

procedure TIsporukaStartStop.FormCreate(Sender: TObject);
begin
           ADOConnection1.LoginPrompt := False;
  ADOConnection1.Connected := True;
end;

procedure TIsporukaStartStop.Timer1Timer(Sender: TObject);
var
  v: Integer;
begin
          v := StrToIntDef(lblTajmer.Text.Replace('s',''), 0);
  Inc(v);
  lblTajmer.Text := v.ToString + 's';
end;

end.
