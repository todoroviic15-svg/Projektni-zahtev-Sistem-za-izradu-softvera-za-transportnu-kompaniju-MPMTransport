program Project1;

uses
  System.StartUpCopy,
  FMX.Forms,
  PocetnaStranica in 'PocetnaStranica.pas' {Form1},
  LoginForma in 'LoginForma.pas' {Form2},
  MenadzerForma in 'MenadzerForma.pas' {Form3},
  AdministratorForma in 'AdministratorForma.pas' {Form4},
  DispecerForma in 'DispecerForma.pas' {Form5},
  KlijentForma in 'KlijentForma.pas' {Form6},
  VozacForma in 'VozacForma.pas' {Form7};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.
