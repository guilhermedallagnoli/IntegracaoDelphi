program IntegracaoMyTapp;

uses
  Vcl.Forms,
  UDM in 'UDM.pas' {dm: TDataModule},
  UPrincipal in 'UPrincipal.pas' {FrmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
