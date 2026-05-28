unit Isporuke;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.DateTimeCtrls, FMX.Edit;

type
  TpocetakInfo = class(TForm)
    pocetakVoznje: TPanel;
    btnStart: TButton;
    txtbPLokacija: TEdit;
    vremePocetno: TTimeEdit;
    pocetnoGorivoL: TEdit;
    Text1: TText;
    Text2: TText;
    Text3: TText;
    Panel1: TPanel;
    Timer1: TTimer;
    Text4: TText;
    lblTimer: TLabel;
    btnStop: TButton;
    Panel2: TPanel;
    procedure btnStartClick(Sender: TObject);

    procedure Timer1Timer(Sender: TObject);
    procedure btnStopClick(Sender: TObject);

  private
  StartTime: TDateTime;
    { Private declarations }
  public
    { Public declarations }
  end;



implementation

{$R *.fmx}

procedure TpocetakInfo.btnStartClick(Sender: TObject);
begin
     pocetakVoznje.Visible := False;
  Panel1.Visible := True;

  StartTime := Now;

  Timer1.Enabled := True;
end;

procedure TpocetakInfo.btnStopClick(Sender: TObject);
begin
               Timer1.Enabled := False;

  Panel1.Visible := False;
  pocetakVoznje.Visible := True;
end;

procedure TpocetakInfo.Timer1Timer(Sender: TObject);
begin
lblTimer.Text :=
    FormatDateTime('hh:nn:ss', Now - StartTime);
end;

end.
