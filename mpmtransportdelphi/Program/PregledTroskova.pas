unit PregledTroskova;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Rtti, FMX.Grid.Style,
  FMX.Grid, Data.DB, Data.Win.ADODB, FMX.ScrollBox, FMX.ListBox,
  FMX.DateTimeCtrls;

type
  TFormPregledTroskova = class(TForm)
    SpeedButton1: TSpeedButton;
    dtOd: TDateEdit;
    dtDo: TDateEdit;
    cmbKategorija: TComboBox;
    cmbVozilo: TComboBox;
    cmbVozac: TComboBox;
    btnPrikazi: TButton;
    grid: TStringGrid;
    lblUkupno: TLabel;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    StringColumn4: TStringColumn;
    StringColumn5: TStringColumn;
    StringColumn6: TStringColumn;
    StringColumn7: TStringColumn;
    StringColumn8: TStringColumn;
    procedure btnPrikaziClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    procedure PopuniFiltere;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPregledTroskova: TFormPregledTroskova;

implementation

uses Menadzer;

{$R *.fmx}

procedure TFormPregledTroskova.PopuniFiltere;
begin
  // Kategorije
