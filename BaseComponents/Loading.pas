unit Loading;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, System.Types,
  FMX.Objects, FMX.StdCtrls, System.UITypes, FMX.Graphics, FMX.Dialogs, System.Math,
  System.Math.Vectors, FMX.Edit, FMX.Layouts, FMX.Effects,
  ColorClass, FMX.Ani, FMX.MultiResBitmap;

type
  TLoadingIconType = (Arc, Path, Image);

  TLoading = class(TControl)
  private
    { Private declarations }
    procedure Animation1();
    procedure Animation2();
    procedure OnExitButton1(Sender: TObject);
  protected
    { Protected declarations }
    FBackground: TRectangle;
    FArcIcon: TArc;
    FPathIcon: TPath;
    FImageIcon: TImage;
    FAnimation: TFloatAnimation;

    { Block focus on background }
    FButtonLockFocus: TButton;

    function GetFBackgroundOpacity: Single;
    procedure SetFBackgroundOpacity(const Value: Single);
    function GetFTag: NativeInt;
    procedure SetFTag(const Value: NativeInt);
    function GetFCornerRound: Single;
    procedure SetFCornerRound(const Value: Single);
    function GetFIconImageWrapMode: TImageWrapMode;
    procedure SetFIconImageWrapMode(const Value: TImageWrapMode);
    function GetFCursor: TCursor;
    procedure SetFCursor(const Value: TCursor);
    procedure SetMultiResBitmap(const Value: TFixedMultiResBitmap);
    function GetFMultiResBitmap: TFixedMultiResBitmap;
    function GetFBackgroundColor: TAlphaColor;
    procedure SetFBackgroundColor(const Value: TAlphaColor);
    function GetFIconType: TLoadingIconType;
    procedure SetFIconType(const Value: TLoadingIconType);
    function GetFIconArcColor: TAlphaColor;
    function GetFIconPathColor: TAlphaColor;
    function GetFIconPathData: TPathData;
    procedure SetFIconArcColor(const Value: TAlphaColor);
    procedure SetFIconPathColor(const Value: TAlphaColor);
    procedure SetFIconPathData(const Value: TPathData);
    function GetFIconSize: Single;
    procedure SetFIconSize(const Value: Single);
    function GetFAnimationDuration: Single;
    procedure SetFAnimationDuration(const Value: Single);
    function GetFAnimationAnimationType: TAnimationType;
    function GetFAnimationAutoReverse: Boolean;
    function GetFAnimationInterpolation: TInterpolationType;
    function GetFAnimationPropertyName: String;
    function GetFAnimationStartValue: Single;
    function GetFAnimationStopValue: Single;
    procedure SetFAnimationAnimationType(const Value: TAnimationType);
    procedure SetFAnimationAutoReverse(const Value: Boolean);
    procedure SetFAnimationInterpolation(const Value: TInterpolationType);
    procedure SetFAnimationPropertyName(const Value: String);
    procedure SetFAnimationStartValue(const Value: Single);
    procedure SetFAnimationStopValue(const Value: Single);
  public
    { Public declarations }

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Open(Duration: Single = 0.2); virtual;
    procedure Close(Duration: Single = 0.2); virtual;
  published
    { Published declarations }

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
    property Cursor: TCursor read GetFCursor write SetFCursor;
    property BackgroundColor: TAlphaColor read GetFBackgroundColor write SetFBackgroundColor;
    property BackgroundOpacity: Single read GetFBackgroundOpacity write SetFBackgroundOpacity;
    property IconType: TLoadingIconType read GetFIconType write SetFIconType;
    property IconArcColor: TAlphaColor read GetFIconArcColor write SetFIconArcColor;
    property IconPathData: TPathData read GetFIconPathData write SetFIconPathData;
    property IconPathColor: TAlphaColor read GetFIconPathColor write SetFIconPathColor;
    property IconImage: TFixedMultiResBitmap read GetFMultiResBitmap write SetMultiResBitmap;
    property IconImageWrapMode: TImageWrapMode read GetFIconImageWrapMode write SetFIconImageWrapMode;
    property IconSize: Single read GetFIconSize write SetFIconSize;
    property AnimationDuration: Single read GetFAnimationDuration write SetFAnimationDuration;
    property AnimationAutoReverse: Boolean read GetFAnimationAutoReverse write SetFAnimationAutoReverse;
    property AnimationAnimationType: TAnimationType read GetFAnimationAnimationType write SetFAnimationAnimationType;
    property AnimationInterpolation: TInterpolationType read GetFAnimationInterpolation
      write SetFAnimationInterpolation;
    property AnimationPropertyName: String read GetFAnimationPropertyName write SetFAnimationPropertyName;
    property AnimationStartValue: Single read GetFAnimationStartValue write SetFAnimationStartValue;
    property AnimationStopValue: Single read GetFAnimationStopValue write SetFAnimationStopValue;
    property CornerRound: Single read GetFCornerRound write SetFCornerRound;
    property Tag: NativeInt read GetFTag write SetFTag;

    { Events }
    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Componentes Customizados', [TLoading]);
end;

{ TLoading }

{ Block focus on background }
procedure TLoading.OnExitButton1(Sender: TObject);
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          FButtonLockFocus.SetFocus;
        end);
    end).Start;
end;

procedure TLoading.Open(Duration: Single = 0.2);
begin
  Self.BringToFront;
  Self.Visible := True;
  Self.Opacity := 0;
  FAnimation.Start;
  Self.AnimateFloat('Opacity', 1, Duration, TAnimationType.InOut, TInterpolationType.Circular);

  { Block focus on background }
  FButtonLockFocus.OnExit := OnExitButton1;
  FButtonLockFocus.SetFocus;
end;

procedure TLoading.Animation1;
begin
  FAnimation.AnimationType := TAnimationType.InOut;
  FAnimation.AutoReverse := False;
  FAnimation.Duration := 1;
  FAnimation.Interpolation := TInterpolationType.Sinusoidal;
  FAnimation.Loop := True;
  FAnimation.PropertyName := 'RotationAngle';
  FAnimation.StartValue := 0;
  FAnimation.StopValue := 360;
end;

procedure TLoading.Animation2;
begin
  FAnimation.AnimationType := TAnimationType.InOut;
  FAnimation.AutoReverse := False;
  FAnimation.Duration := 1.5;
  FAnimation.Interpolation := TInterpolationType.Elastic;
  FAnimation.Loop := True;
  FAnimation.PropertyName := 'RotationAngle';
  FAnimation.StartValue := 0;
  FAnimation.StopValue := 360;
end;

procedure TLoading.Close(Duration: Single = 0.2);
begin
  { Block focus on background }
  FButtonLockFocus.OnExit := nil;

  Self.AnimateFloatWait('Opacity', 0, Duration, TAnimationType.InOut, TInterpolationType.Circular);
  Self.Visible := False;
  Self.Opacity := 1;

  FAnimation.Stop;
end;

constructor TLoading.Create(AOwner: TComponent);
begin
  inherited;
  Self.Align := TAlignLayout.Client;

  FButtonLockFocus := TButton.Create(Self);
  Self.AddObject(FButtonLockFocus);
  FButtonLockFocus.SetSubComponent(True);
  FButtonLockFocus.Stored := False;
  FButtonLockFocus.Opacity := 0;
  FButtonLockFocus.TabStop := False;

  FBackground := TRectangle.Create(Self);
  Self.AddObject(FBackground);
  FBackground.SetSubComponent(True);
  FBackground.Stored := False;
  FBackground.Align := TAlignLayout.Contents;
  FBackground.Stroke.Kind := TBrushKind.None;
  FBackground.Fill.Color := TAlphaColor($FFFFFFFF);
  FBackground.HitTest := True;
  FBackground.Cursor := crHourGlass;

  FArcIcon := TArc.Create(Self);
  Self.AddObject(FArcIcon);
  FArcIcon.SetSubComponent(True);
  FArcIcon.Stored := False;
  FArcIcon.Align := TAlignLayout.Center;
  FArcIcon.Stroke.Color := TAlphaColor(SOLID_PRIMARY_COLOR);
  FArcIcon.Stroke.Thickness := 4;
  FArcIcon.EndAngle := 120;
  FArcIcon.Width := 50;
  FArcIcon.Height := 50;
  FArcIcon.HitTest := False;

  FPathIcon := TPath.Create(Self);
  Self.AddObject(FPathIcon);
  FPathIcon.SetSubComponent(True);
  FPathIcon.Stored := False;
  FPathIcon.Align := TAlignLayout.Center;
  FPathIcon.WrapMode := TPathWrapMode.Fit;
  FPathIcon.Fill.Color := TAlphaColor(SOLID_PRIMARY_COLOR);
  FPathIcon.Stroke.Kind := TBrushKind.None;
  FPathIcon.Width := 25;
  FPathIcon.Height := 25;
  FPathIcon.HitTest := False;
  FPathIcon.Data.Data :=
    'M6,2H18V8H18V8L14,12L18,16V16H18V22H6V16H6V16L10,12L6,8V8H6V2M16,16.5L12,12.5L8,16.5V20H16V16.5M12,11.5L16,7.5V4H8V7.5L12,11.5M10,6H14V6.75L12,8.75L10,6.75V6Z';

  FImageIcon := TImage.Create(Self);
  Self.AddObject(FImageIcon);
  FImageIcon.SetSubComponent(True);
  FImageIcon.Stored := False;
  FImageIcon.Align := TAlignLayout.Center;
  FImageIcon.WrapMode := TImageWrapMode.Original;
  FImageIcon.Width := 64;
  FImageIcon.Height := 64;
  FImageIcon.HitTest := False;

  FAnimation := TFloatAnimation.Create(Self);
  FAnimation.Parent := FArcIcon;
  FAnimation.AnimationType := TAnimationType.InOut;
  FAnimation.Duration := 1;
  FAnimation.Interpolation := TInterpolationType.Sinusoidal;
  FAnimation.Loop := True;
  FAnimation.PropertyName := 'RotationAngle';
  FAnimation.StartValue := 0;
  FAnimation.StopValue := 360;
  SetFIconType(TLoadingIconType.Arc);
end;

destructor TLoading.Destroy;
begin
  if Assigned(FImageIcon) then
    FImageIcon.Free;
  if Assigned(FPathIcon) then
    FPathIcon.Free;
  if Assigned(FArcIcon) then
    FArcIcon.Free;
  if Assigned(FBackground) then
    FBackground.Free;
  if Assigned(FButtonLockFocus) then
    FButtonLockFocus.Free;
  inherited;
end;

function TLoading.GetFAnimationAnimationType: TAnimationType;
begin
  Result := FAnimation.AnimationType;
end;

function TLoading.GetFAnimationAutoReverse: Boolean;
begin
  Result := FAnimation.AutoReverse;
end;

function TLoading.GetFAnimationDuration: Single;
begin
  Result := FAnimation.Duration;
end;

function TLoading.GetFAnimationInterpolation: TInterpolationType;
begin
  Result := FAnimation.Interpolation;
end;

function TLoading.GetFAnimationPropertyName: String;
begin
  Result := FAnimation.PropertyName;
end;

function TLoading.GetFAnimationStartValue: Single;
begin
  Result := FAnimation.StartValue;
end;

function TLoading.GetFAnimationStopValue: Single;
begin
  Result := FAnimation.StopValue;
end;

function TLoading.GetFBackgroundColor: TAlphaColor;
begin
  Result := FBackground.Fill.Color;
end;

function TLoading.GetFBackgroundOpacity: Single;
begin
  Result := FBackground.Opacity;
end;

function TLoading.GetFCornerRound: Single;
begin
  Result := FBackground.XRadius;
end;

function TLoading.GetFCursor: TCursor;
begin
  Result := FBackground.Cursor;
end;

function TLoading.GetFIconArcColor: TAlphaColor;
begin
  Result := FArcIcon.Stroke.Color
end;

function TLoading.GetFIconImageWrapMode: TImageWrapMode;
begin
  Result := FImageIcon.WrapMode;
end;

function TLoading.GetFIconPathColor: TAlphaColor;
begin
  Result := FPathIcon.Fill.Color;
end;

function TLoading.GetFIconPathData: TPathData;
begin
  Result := FPathIcon.Data;
end;

function TLoading.GetFIconSize: Single;
begin
  Result := FArcIcon.Width;
  if FPathIcon.Visible then
    Result := FPathIcon.Width
  else if FImageIcon.Visible then
    Result := FImageIcon.Width;
end;

function TLoading.GetFIconType: TLoadingIconType;
begin
  Result := TLoadingIconType.Arc;
  if FPathIcon.Visible then
    Result := TLoadingIconType.Path
  else if FImageIcon.Visible then
    Result := TLoadingIconType.Image;
end;

function TLoading.GetFMultiResBitmap: TFixedMultiResBitmap;
begin
  Result := FImageIcon.MultiResBitmap;
end;

function TLoading.GetFTag: NativeInt;
begin
  Result := TControl(Self).Tag;
end;

procedure TLoading.SetFAnimationAnimationType(const Value: TAnimationType);
begin
  FAnimation.AnimationType := Value;
end;

procedure TLoading.SetFAnimationAutoReverse(const Value: Boolean);
begin
  FAnimation.AutoReverse := Value;
end;

procedure TLoading.SetFAnimationDuration(const Value: Single);
begin
  FAnimation.Duration := Value;
end;

procedure TLoading.SetFAnimationInterpolation(const Value: TInterpolationType);
begin
  FAnimation.Interpolation := Value;
end;

procedure TLoading.SetFAnimationPropertyName(const Value: String);
begin
  FAnimation.PropertyName := Value;
end;

procedure TLoading.SetFAnimationStartValue(const Value: Single);
begin
  FAnimation.StartValue := Value;
end;

procedure TLoading.SetFAnimationStopValue(const Value: Single);
begin
  FAnimation.StopValue := Value;
end;

procedure TLoading.SetFBackgroundColor(const Value: TAlphaColor);
begin
  FBackground.Fill.Color := Value;
end;

procedure TLoading.SetFBackgroundOpacity(const Value: Single);
begin
  FBackground.Opacity := Value;
end;

procedure TLoading.SetFCornerRound(const Value: Single);
begin
  FBackground.XRadius := Value;
  FBackground.YRadius := Value;
end;

procedure TLoading.SetFCursor(const Value: TCursor);
begin
  FBackground.Cursor := Value;
end;

procedure TLoading.SetFIconArcColor(const Value: TAlphaColor);
begin
  FArcIcon.Stroke.Color := Value;
end;

procedure TLoading.SetFIconImageWrapMode(const Value: TImageWrapMode);
begin
  FImageIcon.WrapMode := Value;
end;

procedure TLoading.SetFIconPathColor(const Value: TAlphaColor);
begin
  FPathIcon.Fill.Color := Value;
end;

procedure TLoading.SetFIconPathData(const Value: TPathData);
begin
  FPathIcon.Data := Value;
end;

procedure TLoading.SetFIconSize(const Value: Single);
begin
  if GetFIconType = TLoadingIconType.Arc then
  begin
    FArcIcon.Width := Value;
    FArcIcon.Height := Value;
  end
  else if GetFIconType = TLoadingIconType.Path then
  begin
    FPathIcon.Width := Value;
    FPathIcon.Height := Value;
  end
  else
  begin
    FImageIcon.Width := Value;
    FImageIcon.Height := Value;
  end;
end;

procedure TLoading.SetFIconType(const Value: TLoadingIconType);
begin
  FArcIcon.Visible := False;
  FPathIcon.Visible := False;
  FImageIcon.Visible := False;
  if Value = TLoadingIconType.Arc then
  begin
    FArcIcon.Visible := True;
    FAnimation.Parent := FArcIcon;
    Animation1();
  end
  else if Value = TLoadingIconType.Path then
  begin
    FPathIcon.Visible := True;
    FAnimation.Parent := FPathIcon;
    Animation2();
  end
  else
  begin
    FImageIcon.Visible := True;
    FAnimation.Parent := FImageIcon;
    Animation2();
  end;
end;

procedure TLoading.SetFTag(const Value: NativeInt);
begin
  FBackground.Tag := Value;
  TControl(Self).Tag := Value;
end;

procedure TLoading.SetMultiResBitmap(const Value: TFixedMultiResBitmap);
begin
  FImageIcon.MultiResBitmap := Value;
end;

end.
