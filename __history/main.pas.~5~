unit main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,Windows, Messages,
  IntegrationService1,
  WSSE,
  Soap.InvokeRegistry, Soap.SOAPHTTPClient, Soap.XSBuiltIns, opCOnvertOptions, XMLIntf,
  Data.DB, Datasnap.DBClient, Soap.SOAPConn,SOAPHTTPTrans,System.Net.HttpClient,IdCoderMIME,System.NetEncoding, FMX.Effects, FMX.Objects, FMX.Layouts;

type
  TMForm = class(TForm)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Button1: TButton;
    Memo1: TMemo;
    BlurEffect1: TBlurEffect;
    GlowEffect1: TGlowEffect;
    Rectangle2: TRectangle;
    Image1: TImage;
    Image2: TImage;
    SizeGrip1: TSizeGrip;
    procedure Button1Click(Sender: TObject);
    procedure Rectangle2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure FormPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
    procedure Image1MouseEnter(Sender: TObject);
    procedure Image1MouseLeave(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    procedure BeforePost(const HTTPReqResp: THTTPReqResp;  Client: THTTPClient);
  public
    { Public declarations }
  end;


type
 TSOAPCredentials = class(TSoapHeader)
 private
    FPassword: string;
    FUsername: string;
    FKeyClient: string;
 public
   function ObjectToSOAP(RootNode, ParentNode: IXMLNode;
                            const ObjConverter: IObjConverter;
                            const NodeName, NodeNamespace, ChildNamespace: InvString; ObjConvOpts: TObjectConvertOptions;
                            out RefID: InvString): IXMLNode; override;
 published
   property userName     : string read FUsername write Fusername;
   property userPassword : string read FPassword write FPassword;
   property keyClient : string read FKeyClient write FKeyClient;
 end;


var
  MForm: TMForm;
  is1 : IntegrationService;


implementation



{$R *.fmx}
function TSOAPCredentials.ObjectToSOAP(RootNode, ParentNode: IXMLNode; const ObjConverter: IObjConverter; const NodeName,
  NodeNamespace, ChildNamespace: InvString; ObjConvOpts: TObjectConvertOptions; out RefID: InvString): IXMLNode;
begin
 Result := ParentNode.AddChild('userName');
 Result.Text := FUsername;
 Result := ParentNode.AddChild('userPassword');
 Result.Text := FPassword;
end;





procedure TMForm.BeforePost(const HTTPReqResp: THTTPReqResp;  Client: THTTPClient);
var auth, UserName, Password: String;
begin
//HTTPReqResp.UserName := 'demouser';
//HTTPReqResp.Password := 'AfDGlGhWIf12345';
//Client.CustomHeaders['Authorization'] := 'Basic ' + IdCoderMIME.TIdEncoderMIME.EncodeString('demouser:AfDGlGhWIf12345');
     UserName := 'demouser';
     Password := 'AfDGlGhWIf12345';
  Client.CustomHeaders['Authorization'] := 'Authorization: Basic ' + TNetEncoding.Base64.Encode(UserName + ':' + Password);


end;



procedure TMForm.Button1Click(Sender: TObject);
var
 vr,vr1,vr2 : VisitorResponse2;
 Rio  : THTTPRIO;
 Cred : TSOAPCredentials;
 rr : THTTPReqResp;
 Headers: ISOAPHeaders;
begin


//



 // rr := THTTPReqResp.Create(nil);
 // rr.UserName := 'demouser';
 // rr.Password := 'AfDGlGhWIf12345';
  //Rio := THttpRIO.Create(nil);
 // rio.HTTPWebNode := rr;
//  Rio.URL := 'https://api-tet-intregationsnowstaging.infolytx.net/v1/IntegrationService.svc/IntegrationService.svc';


  is1 := IntegrationService1.GetIntegrationService();

  AddSoapHeaderSecurity(is1,'demouser','AfDGlGhWIf12345');

  Memo1.Lines.Clear;
  // vr := VisitorResponse2.Create();

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

   //memo1.Text:= vr.Visitors[7701].VisitorId.ToString;
 //is1.GetVisitors(int64(7701));


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
 hw := FindWindow(nil,PChar(MForm.Caption));
 ReleaseCapture;
 SendMessage(hw, WM_SysCommand,61458,0);
end;

end.
