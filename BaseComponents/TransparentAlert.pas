unit TransparentAlert;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, System.Types,
  FMX.Objects, FMX.StdCtrls, System.UITypes, FMX.Graphics, FMX.Dialogs, System.Math,
  System.Math.Vectors, FMX.Edit, FMX.Layouts, FMX.Effects, ColorClass;

type
  TIconPosition = (Left, Right);

  TTransparentAlert = class(TControl)
  private
    { Private declarations }
  protected
    FPointerOnClick: TNotifyEvent;

    { Protected declarations }
    FText: TLabel;
    FIcon: TPath;

    { Block focus on background }
    FButtonLockFocus: TButton;

    procedure Paint; override;

    procedure OnTransparentAlertClick(Sender: TObject);

    function GetFIconPosition: TIconPosition;
    procedure SetFIconPosition(const Value: TIconPosition);
    function GetFCursor: TCursor;
    procedure SetFCursor(const Value: TCursor);
    function GetFTag: NativeInt;
    procedure SetFTag(const Value: NativeInt);
    function GetFIconMargins: TBounds;
    procedure SetFIconMargins(const Value: TBounds);
    function GetFButtonClass: TColorClass;
    function GetFIconColor: TAlphaColor;
    function GetFIconData: TPathData;
    function GetFIconSize: Single;
    function GetFText: String;
    function GetFTextSettings: TTextSettings;
    procedure SetFButtonClass(const Value: TColorClass);
    procedure SetFIconColor(const Value: TAlphaColor);
    procedure SetFIconData(const Value: TPathData);
    procedure SetFIconSize(const Value: Single);
    procedure SetFText(const Value: String);
    procedure SetFTextSettings(const Value: TTextSettings);
  public
    { Public declarations }

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Open(TextAlert: String = ''; Duration: Single = 0.2); virtual;
    procedure Close(Duration: Single = 0.2); virtual;
  published
    { Published declarations }

    property Align;
    property Anchors;
    property Enabled;
    property Height;
    property Opacity;
    property Visible;
    property Width;
    property Size;
    property Scale;
    property Margins;
    property Position;
    property RotationAngle;
    property RotationCenter;

    { Additional properties }
    property HitTest;
    property Cursor;
    property ButtonClass: TColorClass read GetFButtonClass write SetFButtonClass;
    property Text: String read GetFText write SetFText;
    property TextSettings: TTextSettings read GetFTextSettings write SetFTextSettings;
    property IconData: TPathData read GetFIconData write SetFIconData;
    property IconColor: TAlphaColor read GetFIconColor write SetFIconColor;
    property IconSize: Single read GetFIconSize write SetFIconSize;
    property IconMargins: TBounds read GetFIconMargins write SetFIconMargins;
    property IconPosition: TIconPosition read GetFIconPosition write SetFIconPosition;
    property Tag;

    { Events }
    property OnPainting;
    property OnPaint;
    property OnResize;

    { Mouse events }
    property OnClick: TNotifyEvent read FPointerOnClick write FPointerOnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseMove;
    property OnMouseEnter;
    property OnMouseLeave;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Componentes Customizados', [TTransparentAlert]);
end;

{ TTransparentAlert }

constructor TTransparentAlert.Create(AOwner: TComponent);
begin
  inherited;
  Self.Width := 230;
  Self.Height := 20;
  Self.Cursor := crDefault;
  TControl(Self).OnClick := OnTransparentAlertClick;

  FButtonLockFocus := TButton.Create(Self);
  Self.AddObject(FButtonLockFocus);
  FButtonLockFocus.SetSubComponent(True);
  FButtonLockFocus.Stored := False;
  FButtonLockFocus.Opacity := 0;
  FButtonLockFocus.TabStop := False;
  FButtonLockFocus.Width := 1;
  FButtonLockFocus.Height := 1;
  FButtonLockFocus.HitTest := False;
  FButtonLockFocus.SendToBack;

  FText := TLabel.Create(Self);
  Self.AddObject(FText);
  FText.Align := TAlignLayout.Client;
  FText.HitTest := False;
  FText.StyledSettings := [];
  FText.TextSettings.Font.Size := 14;
  FText.TextSettings.Font.Family := 'SF Pro Display';
  FText.TextSettings.FontColor := SOLID_PRIMARY_COLOR;
  FText.SetSubComponent(True);
  FText.Stored := False;

  FIcon := TPath.Create(Self);
  Self.AddObject(FIcon);
  FIcon.SetSubComponent(True);
  FIcon.Stored := False;
  FIcon.Align := TAlignLayout.Left;
  FIcon.WrapMode := TPathWrapMode.Fit;
  FIcon.Fill.Color := SOLID_PRIMARY_COLOR;
  FIcon.Stroke.Kind := TBrushKind.None;
  FIcon.Width := 33;
  FIcon.HitTest := False;
  FIcon.Visible := False;
end;

destructor TTransparentAlert.Destroy;
begin
  if Assigned(FIcon) then
    FIcon.Free;
  if Assigned(FText) then
    FText.Free;
  if Assigned(FButtonLockFocus) then
    FButtonLockFocus.Free;
  inherited;
end;

function TTransparentAlert.GetFButtonClass: TColorClass;
begin
  if (FText.TextSettings.FontColor = SOLID_PRIMARY_COLOR) and (GetFIconColor() = SOLID_PRIMARY_COLOR) then
    Result := TColorClass.Primary
  else if (FText.TextSettings.FontColor = SOLID_SECONDARY_COLOR) and (GetFIconColor() = SOLID_SECONDARY_COLOR) then
    Result := TColorClass.Secondary
  else if (FText.TextSettings.FontColor = SOLID_ERROR_COLOR) and (GetFIconColor() = SOLID_ERROR_COLOR) then
    Result := TColorClass.Error
  else if (FText.TextSettings.FontColor = SOLID_WARNING_COLOR) and (GetFIconColor() = SOLID_WARNING_COLOR) then
    Result := TColorClass.Warning
  else if (FText.TextSettings.FontColor = SOLID_SUCCESS_COLOR) and (GetFIconColor() = SOLID_SUCCESS_COLOR) then
    Result := TColorClass.Success
  else if (FText.TextSettings.FontColor = SOLID_NORMAL_COLOR) and (GetFIconColor() = SOLID_NORMAL_COLOR) then
    Result := TColorClass.Normal
  else
    Result := TColorClass.Custom;
end;

function TTransparentAlert.GetFCursor: TCursor;
begin
  Result := TControl(Self).Cursor;
end;

function TTransparentAlert.GetFIconColor: TAlphaColor;
begin
  Result := FIcon.Fill.Color;
end;

function TTransparentAlert.GetFIconData: TPathData;
begin
  Result := FIcon.Data;
end;

function TTransparentAlert.GetFIconMargins: TBounds;
begin
  Result := FIcon.Margins;
end;

function TTransparentAlert.GetFIconPosition: TIconPosition;
begin
  Result := TIconPosition.Right;
  if FIcon.Align = TAlignLayout.Right then
    Result := TIconPosition.Right
  else if FIcon.Align = TAlignLayout.Left then
    Result := TIconPosition.Left;
end;

function TTransparentAlert.GetFIconSize: Single;
begin
  Result := FIcon.Width;
end;

function TTransparentAlert.GetFTag: NativeInt;
begin
  Result := TControl(Self).Tag;
end;

function TTransparentAlert.GetFText: String;
begin
  Result := FText.Text;
end;

function TTransparentAlert.GetFTextSettings: TTextSettings;
begin
  Result := FText.TextSettings;
end;

procedure TTransparentAlert.OnTransparentAlertClick(Sender: TObject);
begin
  FButtonLockFocus.SetFocus;
  if Assigned(FPointerOnClick) then
    FPointerOnClick(Sender);
end;

procedure TTransparentAlert.Open(TextAlert: String = ''; Duration: Single = 0.2);
begin
  if not TextAlert.Equals('') then
    FText.Text := TextAlert;
  Self.BringToFront;
  Self.Visible := True;
  Self.Opacity := 0;
  Self.AnimateFloat('Opacity', 1, Duration, TAnimationType.InOut, TInterpolationType.Circular);
end;

procedure TTransparentAlert.Close(Duration: Single = 0.2);
begin
  Self.AnimateFloatWait('Opacity', 0, Duration, TAnimationType.InOut, TInterpolationType.Circular);
  Self.Visible := False;
  Self.Opacity := 1;
end;

procedure TTransparentAlert.Paint;
begin
  inherited;
  if FIcon.Data.Data.Equals('') then
    FIcon.Visible := False
  else
    FIcon.Visible := True;
end;

procedure TTransparentAlert.SetFButtonClass(const Value: TColorClass);
begin
  if Value = TColorClass.Primary then
  begin
    FText.TextSettings.FontColor := SOLID_PRIMARY_COLOR;
    SetFIconColor(SOLID_PRIMARY_COLOR);
  end
  else if Value = TColorClass.Secondary then
  begin
    FText.TextSettings.FontColor := SOLID_SECONDARY_COLOR;
    SetFIconColor(SOLID_SECONDARY_COLOR);
  end
  else if Value = TColorClass.Error then
  begin
    FText.TextSettings.FontColor := SOLID_ERROR_COLOR;
    SetFIconColor(SOLID_ERROR_COLOR);
  end
  else if Value = TColorClass.Warning then
  begin
    FText.TextSettings.FontColor := SOLID_WARNING_COLOR;
    SetFIconColor(SOLID_WARNING_COLOR);
  end
  else if Value = TColorClass.Normal then
  begin
    FText.TextSettings.FontColor := SOLID_NORMAL_COLOR;
    SetFIconColor(SOLID_NORMAL_COLOR);
  end
  else if Value = TColorClass.Success then
  begin
    FText.TextSettings.FontColor := SOLID_SUCCESS_COLOR;
    SetFIconColor(SOLID_SUCCESS_COLOR);
  end
  else
  begin
    FText.TextSettings.FontColor := SOLID_BLACK;
    SetFIconColor(SOLID_BLACK);
  end;
end;

procedure TTransparentAlert.SetFCursor(const Value: TCursor);
begin
  Cursor := Value;
end;

procedure TTransparentAlert.SetFIconColor(const Value: TAlphaColor);
begin
  FIcon.Fill.Color := Value;
end;

procedure TTransparentAlert.SetFIconData(const Value: TPathData);
begin
  FIcon.Data := Value;
end;

procedure TTransparentAlert.SetFIconMargins(const Value: TBounds);
begin
  FIcon.Margins := Value;
end;

procedure TTransparentAlert.SetFIconPosition(const Value: TIconPosition);
begin
  if Value = TIconPosition.Right then
    FIcon.Align := TAlignLayout.Right
  else
    FIcon.Align := TAlignLayout.Left
end;

procedure TTransparentAlert.SetFIconSize(const Value: Single);
begin
  FIcon.Width := Value;
  FIcon.Height := Value;
end;

procedure TTransparentAlert.SetFTag(const Value: NativeInt);
begin
  TControl(Self).Tag := Value;
end;

procedure TTransparentAlert.SetFText(const Value: String);
begin
  FText.Text := Value;
end;

procedure TTransparentAlert.SetFTextSettings(const Value: TTextSettings);
begin
  FText.TextSettings := Value;
end;

end.
