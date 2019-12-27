unit Control1;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, System.Types,
  FMX.Objects, System.UITypes, FMX.Graphics, FMX.Dialogs, System.Math,
  System.Math.Vectors, FMX.Edit, FMX.Layouts, FMX.Effects;

type
  Tbuttonfinal = class(TControl)
  private
    { Private declarations }
    FBackground: TRectangle;
    FEdit: TEdit;
    FIcon: TPath;
    FLayoutIcon: TLayout;
    FShadow: TShadowEffect;
    FStrokeGradientDefocus: TGradient;

    { Edit settings }
    FText: String;
    FTextPrompt: String;

    { Icon settings }
    FIconData: TPathData;
    FIconSize: Single;

    { Events settings }
    procedure SetFOnTyping(const Value: TNotifyEvent);
    function GetFText: String;
    procedure SetFText(const Value: String);
    function GetFOnTyping: TNotifyEvent;
    function GetFTextPrompt: String;
    procedure SetFTextPrompt(const Value: String);
    function GetFPassword: Boolean;
    procedure SetFPassword(const Value: Boolean);
    function GetFOnClick: TNotifyEvent;
    procedure SetFOnClick(const Value: TNotifyEvent);
    function GetFOnDblClick: TNotifyEvent;
    procedure SetFOnDblClick(const Value: TNotifyEvent);
  protected
    { Protected declarations }
    procedure Paint; override;
    procedure Resize; override;
    procedure Painting; override;

    { Repaint }
    procedure DoChanged(Sender: TObject);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property Align;
    property Anchors;
    property ClipParent;
    property Cursor;
    property Enabled;
    property Height;
    property HitTest default True;
    property Opacity;
    property Margins;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property Visible;
    property Width;

    { Additional properties }
    property Text: String read GetFText write SetFText;
    property TextPrompt: String read GetFTextPrompt write SetFTextPrompt;
    property Password: Boolean read GetFPassword write SetFPassword;
    property IconData: TPathData read FIconData write FIconData;
    property IconSize: Single read FIconSize write FIconSize;

    { Optional properties - Rarely used }
    //property CanFocus default True;
    //property DragMode;
    //property EnableDragHighlight;
    //property Locked;
    //property Padding;
    //property PopupMenu;
    //property TouchTargetExpansion;
    //property TabOrder default -1;
    //property TabStop default True;

    { Events }
    property OnPainting;
    property OnPaint;
    property OnResize;
    { Mouse events }
    property OnClick: TNotifyEvent read GetFOnClick write SetFOnClick;
    property OnDblClick: TNotifyEvent read GetFOnDblClick write SetFOnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;

    { Additional events }
    property OnTyping: TNotifyEvent read GetFOnTyping write SetFOnTyping;

    { Optional events - Rarely used }
    //property OnDragEnter;
    //property OnDragLeave;
    //property OnDragOver;
    //property OnDragDrop;
    //property OnDragEnd;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Delphistrap', [Tbuttonfinal]);
end;

{ Tbuttonfinal }

{ Private declarations }

{ Events settings }

procedure Tbuttonfinal.SetFOnClick(const Value: TNotifyEvent);
begin
  FEdit.OnClick := Value;
end;

function Tbuttonfinal.GetFOnClick: TNotifyEvent;
begin
  Result := FEdit.OnClick;
end;

procedure Tbuttonfinal.SetFOnDblClick(const Value: TNotifyEvent);
begin
  FEdit.OnDblClick := Value;
end;

function Tbuttonfinal.GetFOnDblClick: TNotifyEvent;
begin
  Result := FEdit.OnDblClick;
end;

procedure Tbuttonfinal.SetFOnTyping(const Value: TNotifyEvent);
begin
  FEdit.OnTyping := Value;
end;

function Tbuttonfinal.GetFOnTyping: TNotifyEvent;
begin
  Result := FEdit.OnTyping;
end;

procedure Tbuttonfinal.SetFText(const Value: String);
begin
  FEdit.Text := Value;
end;

function Tbuttonfinal.GetFText: String;
begin
  Result := FEdit.Text;
end;

procedure Tbuttonfinal.SetFTextPrompt(const Value: String);
begin
  FEdit.TextPrompt := Value;
end;

function Tbuttonfinal.GetFTextPrompt: String;
begin
  Result := FEdit.TextPrompt;
end;

procedure Tbuttonfinal.SetFPassword(const Value: Boolean);
begin
  FEdit.Password := Value;
end;

function Tbuttonfinal.GetFPassword: Boolean;
begin
  Result := FEdit.Password;
end;

{ Protected declarations }

procedure Tbuttonfinal.Paint;
begin
  inherited;
  if FIconData.Data.Equals('') then
  begin
    FLayoutIcon.Visible := false;
    FIcon.Visible := false;
  end
  else
  begin
    FLayoutIcon.Visible := true;
    FIcon.Visible := true;
    FLayoutIcon.Width := 13+FIconSize;
    FIcon.Width := FIconSize;
    FIcon.Data := FIconData;
  end;
end;

procedure Tbuttonfinal.Resize;
begin
  inherited;
  if Assigned(FBackground) then
  begin
    with FBackground do
    begin
      Height := self.Width * 0.85;
      Width := self.Width * 0.85;
      Position.X := self.Width / 2 - Width / 2;
      Position.Y := self.Height / 2 - Height / 2;
    end;
  end;
end;

procedure Tbuttonfinal.Painting;
begin
  inherited;
end;

{ Repaint }

procedure Tbuttonfinal.DoChanged(Sender: TObject);
begin
  Repaint;
end;

{ Public declarations }

constructor Tbuttonfinal.Create(AOwner: TComponent);
begin
  inherited;
  Self.Width := 250;
  Self.Height := 40;

  FIconData := TPathData.Create;
  FIconData.OnChanged := DoChanged;
  FIconSize := 12;

  { Backgroud }
  FBackground := TRectangle.Create(self);
  Self.AddObject(FBackground);
  FBackground.Align := TAlignLayout.Client;
  FBackground.Stroke.Kind := TBrushKind.Gradient;
  FBackground.Stroke.Thickness := 1;
  FBackground.Fill.Color := TAlphaColor($FFFFFFFF);
  FBackground.XRadius := 4;
  FBackground.YRadius := 4;

  FStrokeGradientDefocus := TGradient.Create;
  with FStrokeGradientDefocus do
  begin
    Color := $FFD2D2D2;
    Color1 := $FFBABABA;
  end;
  FBackground.Stroke.Gradient := FStrokeGradientDefocus;

  { Edit }
  FEdit := TEdit.Create(self);
  FEdit.Parent := FBackground;
  FEdit.Align := TAlignLayout.Client;
  FEdit.Margins.Top := 5;
  FEdit.Margins.Bottom := 5;
  FEdit.Margins.Left := 8;
  FEdit.Margins.Right := 8;
  FEdit.StyleLookup := 'transparentedit';
  FEdit.TextPrompt := 'Placeholder';
  FEdit.StyledSettings := [];
  FEdit.TextSettings.Font.Size := 14;
  FEdit.TextSettings.Font.Family := 'SF Pro Display';
  FEdit.TextSettings.FontColor := TAlphaColor($FF323232);

  { Shadow }
  FShadow := TShadowEffect.Create(self);
  FBackground.AddObject(FShadow);
  FShadow.Direction := 90;
  FShadow.Distance := 0.5;
  FShadow.Opacity := 0.1;
  FShadow.Softness := 0.05;

  { Icon }
  FLayoutIcon := TLayout.Create(self);
  FBackground.AddObject(FLayoutIcon);
  FLayoutIcon.Align := TAlignLayout.Left;
  FLayoutIcon.Width := 25;

  FIcon := TPath.Create(self);
  FLayoutIcon.AddObject(FIcon);
  FIcon.Align := TAlignLayout.Right;
  FIcon.WrapMode := TPathWrapMode.Fit;
  FIcon.Fill.Color := TAlphaColor($FF515151);
  FIcon.Stroke.Kind := TBrushKind.None;
  FIcon.Width := FIconSize;
end;

destructor Tbuttonfinal.Destroy;
begin
  if Assigned(FIconData) then
    FIconData.Free;
  if Assigned(FIcon) then
    FIcon.Free;
  if Assigned(FLayoutIcon) then
    FLayoutIcon.Free;
  if Assigned(FShadow) then
    FShadow.Free;
  if Assigned(FEdit) then
    FEdit.Free;
  if Assigned(FStrokeGradientDefocus) then
    FStrokeGradientDefocus.Free;
  if Assigned(FBackground) then
    FBackground.Free;
  inherited;
end;

{ TButtonFinalAvancado }

end.
