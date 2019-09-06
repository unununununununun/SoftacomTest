unit main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,Windows, Messages,
  FMX.Effects, FMX.Objects, FMX.Layouts,
  System.Threading,
  IntegrationService1,
  WSSE;

type
  TMForm = class(TForm)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    b1: TButton;
    Memo1: TMemo;
    BlurEffect1: TBlurEffect;
    GlowEffect1: TGlowEffect;
    Rectangle2: TRectangle;
    Image1: TImage;
    Image2: TImage;
    SizeGrip1: TSizeGrip;
    procedure b1Click(Sender: TObject);
    procedure Rectangle2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure FormPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
    procedure Image1MouseEnter(Sender: TObject);
    procedure Image1MouseLeave(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  MForm: TMForm;
  is1 : IntegrationService;


implementation

{$R *.fmx}

procedure TMForm.b1Click(Sender: TObject);
var
 vr,vr1,vr2 : VisitorResponse2;

begin
b1.Text:= 'load...';
Memo1.Lines.Clear;
  TTask.Run(
  procedure
   begin
   try
    is1 := IntegrationService1.GetIntegrationService();
    AddSoapHeaderSecurity(is1,'demouser','AfDGlGhWIf12345');
    except on E:Exception do
     ShowMessage(E.message);
     exit;
    end;
    TThread.Synchronize(nil,
    procedure
    begin

     vr :=  is1.GetVisitors(7701);
     memo1.Lines.Add(#13#10);
     memo1.Lines.Add('  Visitor 7701[0] :: ID=' +vr.Visitors[0].VisitorId.ToString+ ' Name='+vr.Visitors[0].VisitorName);
     memo1.Lines.Add('  Visitor 7701[1] :: ID=' +vr.Visitors[1].VisitorId.ToString+ ' Name='+vr.Visitors[1].VisitorName);
     memo1.Lines.Add('');
     AddSoapHeaderSecurity(is1,'demouser','AfDGlGhWIf12345');

     vr :=  is1.GetVisitors(7703);
     memo1.Lines.Add('  Visitor 7703[0] :: ID=' +vr.Visitors[0].VisitorId.ToString+ ' Name='+vr.Visitors[0].VisitorName);
     memo1.Lines.Add('  Visitor 7703[1] :: ID=' +vr.Visitors[1].VisitorId.ToString+ ' Name='+vr.Visitors[1].VisitorName);
     memo1.Lines.Add('  Visitor 7703[2] :: ID=' +vr.Visitors[2].VisitorId.ToString+ ' Name='+vr.Visitors[2].VisitorName);
     memo1.Lines.Add('');
     AddSoapHeaderSecurity(is1,'demouser','AfDGlGhWIf12345');

     vr :=  is1.GetVisitors(7704);
     memo1.Lines.Add('  Visitor 7704[0] :: ID=' +vr.Visitors[0].VisitorId.ToString+ ' Name='+vr.Visitors[0].VisitorName);
     b1.Text:= 'get data';
    end);
   end
   );


end;

procedure TMForm.FormPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
begin
BlurEffect1.UpdateParentEffects;
end;

procedure TMForm.Image1Click(Sender: TObject);
begin
Application.Terminate;
end;

procedure TMForm.Image1MouseEnter(Sender: TObject);
begin
Image1.Opacity := 0.5;
end;

procedure TMForm.Image1MouseLeave(Sender: TObject);
begin
Image1.Opacity := 1.0;
end;

procedure TMForm.Rectangle2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var hw:hwnd;
begin
 //перетягивание окна за любой контрол
 hw := FindWindow(nil,PChar(MForm.Caption));
 ReleaseCapture;
 SendMessage(hw, WM_SysCommand,61458,0);
end;

end.
