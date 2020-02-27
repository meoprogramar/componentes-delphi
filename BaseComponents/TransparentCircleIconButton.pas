unit TransparentCircleIconButton;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, System.Types,
  FMX.Objects, FMX.StdCtrls, System.UITypes, FMX.Graphics, FMX.Dialogs, System.Math,
  System.Math.Vectors, FMX.Edit, FMX.Layouts, FMX.Effects, ColorClass;

type
  TIconPosition = (Left, Right);

  TTransparentCircleIconButton = class(TControl)
  private
    { Private declarations }
  protected
    { Protected declarations }
    FPointerOnMouseEnter: TNotifyEvent;
    FPointerOnMouseExit: TNotifyEvent;
    FPointerOnClick: TNotifyEvent;

    FAnimationOnClick: Boolean;
    FBackgroundSelect: TCircle;
    FIcon: TPath;

    { Block focus on background }
    FButtonLockFocus: TButton;

    procedure Paint; override;

    procedure BackgroundOnEnter(Sender: TObject); virtual;
    procedure BackgroundOnExit(Sender: TObject); virtual;
    procedure BackgroundOnClick(Sender: TObject); virtual;
    function GetFButtonClass: TColorClass; virtual;
    procedure SetFButtonClass(const Value: TColorClass); virtual;
    function GetFBackgroudColor: TAlphaColor; virtual;
    procedure SetFBackgroudColor(const Value: TAlphaColor); virtual;

    function GetFTag: NativeInt;
    procedure SetFTag(const Value: NativeInt);
    function GetFIconAlign: TAlignLayout;
    procedure SetFIconAlign(const Value: TAlignLayout);
    function GetFBackgroudColorAlphaMax: TAlphaColor;
    function GetFCursor: TCursor;
    function GetFHitTest: Boolean;
    procedure SetFCursor(const Value: TCursor);
    procedure SetFHitTest(const Value: Boolean);
    function GetFIconData: TPathData;
    procedure SetFIconData(const Value: TPathData);
    function GetFIconSize: Single;
    procedure SetFIconSize(const Value: Single);
    function GetFOnClick: TNotifyEvent;
    function GetFOnDblClick: TNotifyEvent;
    function GetFOnMouseDown: TMouseEvent;
    function GetFOnMouseEnter: TNotifyEvent;
    function GetFOnMouseLeave: TNotifyEvent;
    function GetFOnMouseMove: TMouseMoveEvent;
    function GetFOnMouseUp: TMouseEvent;
    function GetFOnMouseWheel: TMouseWheelEvent;
    procedure SetFOnClick(const Value: TNotifyEvent);
    procedure SetFOnDblClick(const Value: TNotifyEvent);
    procedure SetFOnMouseDown(const Value: TMouseEvent);
    procedure SetFOnMouseEnter(const Value: TNotifyEvent);
    procedure SetFOnMouseLeave(const Value: TNotifyEvent);
    procedure SetFOnMouseMove(const Value: TMouseMoveEvent);
    procedure SetFOnMouseUp(const Value: TMouseEvent);
    procedure SetFOnMouseWheel(const Value: TMouseWheelEvent);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
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
    property EnableAnimationOnClick: Boolean read FAnimationOnClick write FAnimationOnClick;
    property ButtonClass: TColorClass read GetFButtonClass write SetFButtonClass;
    property IconData: TPathData read GetFIconData write SetFIconData;
    property IconSize: Single read GetFIconSize write SetFIconSize;
    property IconAlign: TAlignLayout read GetFIconAlign write SetFIconAlign;
    property Cursor: TCursor read GetFCursor write SetFCursor;
    property HitTest: Boolean read GetFHitTest write SetFHitTest default True;
    property Color: TAlphaColor read GetFBackgroudColor write SetFBackgroudColor;
    property Tag: NativeInt read GetFTag write SetFTag;

    { Events }
    property OnPainting;
    property OnPaint;
    property OnResize;

    { Mouse events }
    property OnClick: TNotifyEvent read GetFOnClick write SetFOnClick;
    property OnDblClick: TNotifyEvent read GetFOnDblClick write SetFOnDblClick;
    property OnMouseDown: TMouseEvent read GetFOnMouseDown write SetFOnMouseDown;
    property OnMouseUp: TMouseEvent read GetFOnMouseUp write SetFOnMouseUp;
    property OnMouseWheel: TMouseWheelEvent read GetFOnMouseWheel write SetFOnMouseWheel;
    property OnMouseMove: TMouseMoveEvent read GetFOnMouseMove write SetFOnMouseMove;
    property OnMouseEnter: TNotifyEvent read GetFOnMouseEnter write SetFOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read GetFOnMouseLeave write SetFOnMouseLeave;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Componentes Customizados', [TTransparentCircleIconButton]);
end;

{ TTransparentCircleIconButton }

procedure TTransparentCircleIconButton.BackgroundOnClick(Sender: TObject);
var
  CircleEffect: TCircle;
  Aux: Single;
begin
  FButtonLockFocus.SetFocus; { Takes the focus off other components }

  if FAnimationOnClick then
  begin
    CircleEffect := TCircle.Create(Self);
    CircleEffect.HitTest := False;
    CircleEffect.Parent := FBackgroundSelect;
    CircleEffect.Align := TAlignLayout.Center;
    CircleEffect.Stroke.Kind := TBrushKind.None;
    CircleEffect.Fill.Color := GetFBackgroudColorAlphaMax;
    CircleEffect.SendToBack;
    FBackgroundSelect.ClipChildren := True;

    Aux := Min(FBackgroundSelect.Width, FBackgroundSelect.Height) * 1.05;

    CircleEffect.Height := 0;
    CircleEffect.Width := 0;
    CircleEffect.Opacity := 0.6;
    CircleEffect.AnimateFloat('Height', Aux, 0.4, TAnimationType.Out, TInterpolationType.Circular);
    CircleEffect.AnimateFloat('Width', Aux, 0.4, TAnimationType.Out, TInterpolationType.Circular);
    CircleEffect.AnimateFloat('Opacity', 0, 0.4);
  end;

  if Assigned(FPointerOnClick) then
    FPointerOnClick(Sender);
end;

procedure TTransparentCircleIconButton.BackgroundOnEnter(Sender: TObject);
begin
  FBackgroundSelect.AnimateFloat('Opacity', 1, 0.2, TAnimationType.InOut);

  if Assigned(FPointerOnMouseEnter) then
    FPointerOnMouseEnter(Sender);
end;

procedure TTransparentCircleIconButton.BackgroundOnExit(Sender: TObject);
begin
  FBackgroundSelect.AnimateFloat('Opacity', 0, 0.2, TAnimationType.InOut);

  if Assigned(FPointerOnMouseExit) then
    FPointerOnMouseExit(Sender);
end;

constructor TTransparentCircleIconButton.Create(AOwner: TComponent);
begin
  inherited;
  Self.Height := 40;
  Self.Width := 40;

  FAnimationOnClick := True;

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

  FBackgroundSelect := TCircle.Create(Self);
  Self.AddObject(FBackgroundSelect);
  FBackgroundSelect.Align := TAlignLayout.Contents;
  FBackgroundSelect.HitTest := True;
  FBackgroundSelect.SetSubComponent(True);
  FBackgroundSelect.Stored := False;
  FBackgroundSelect.Stroke.Kind := TBrushKind.None;
  FBackgroundSelect.Visible := True;
  FBackgroundSelect.Opacity := 0;
  FBackgroundSelect.OnMouseEnter := BackgroundOnEnter;
  FBackgroundSelect.OnMouseLeave := BackgroundOnExit;
  FBackgroundSelect.OnClick := BackgroundOnClick;
  FBackgroundSelect.Cursor := crHandPoint;
  SetFBackgroudColor(TRANSPARENT_PRIMARY_COLOR);
  FBackgroundSelect.SendToBack;

  FIcon := TPath.Create(Self);
  Self.AddObject(FIcon);
  FIcon.SetSubComponent(True);
  FIcon.Stored := False;
  FIcon.Align := TAlignLayout.Contents;
  FIcon.WrapMode := TPathWrapMode.Fit;
  FIcon.Fill.Color := GetFBackgroudColorAlphaMax;
  FIcon.Stroke.Kind := TBrushKind.None;
  FIcon.Margins.Top := 10;
  FIcon.Margins.Bottom := 10;
  FIcon.Margins.Left := 10;
  FIcon.Margins.Right := 10;
  FIcon.HitTest := False;
  FIcon.Data.Data :=
    'M12,19.2C9.5,19.2 7.29,17.92 6,16C6.03,14 10,12.9 12,12.9C14,12.9 17.97,14 18,16C16.71,17.92 14.5,19.2 12,19.2M12,5A3,3 0 0,1 15,8A3,3 0 0,1 12,11A3,3 0 0,1 9,8A3,3 0 0,1 12,5M12,2A10,10 0 0,0 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12C22,6.47 17.5,2 12,2Z';
  FIcon.BringToFront;

  SetFTag(0);
end;

destructor TTransparentCircleIconButton.Destroy;
begin
  if Assigned(FIcon) then
    FIcon.Free;
  if Assigned(FBackgroundSelect) then
    FBackgroundSelect.Free;
  if Assigned(FButtonLockFocus) then
    FButtonLockFocus.Free;
  inherited;
end;

function TTransparentCircleIconButton.GetFBackgroudColor: TAlphaColor;
begin
  Result := FBackgroundSelect.Fill.Color;
end;

function TTransparentCircleIconButton.GetFBackgroudColorAlphaMax: TAlphaColor;
var
  Color: TAlphaColorRec;
begin
  Color.Color := GetFBackgroudColor;
  Color.A := $FF;
  Result := Color.Color;
end;

function TTransparentCircleIconButton.GetFButtonClass: TColorClass;
begin
  if FBackgroundSelect.Fill.Color = TRANSPARENT_PRIMARY_COLOR then
    Result := TColorClass.Primary
  else if FBackgroundSelect.Fill.Color = TRANSPARENT_SECONDARY_COLOR then
    Result := TColorClass.Secondary
  else if FBackgroundSelect.Fill.Color = TRANSPARENT_ERROR_COLOR then
    Result := TColorClass.Error
  else if FBackgroundSelect.Fill.Color = TRANSPARENT_WARNING_COLOR then
    Result := TColorClass.Warning
  else if FBackgroundSelect.Fill.Color = TRANSPARENT_SUCCESS_COLOR then
    Result := TColorClass.Success
  else if FBackgroundSelect.Fill.Color = TRANSPARENT_NORMAL_COLOR then
    Result := TColorClass.Normal
  else
    Result := TColorClass.Custom;
end;

function TTransparentCircleIconButton.GetFCursor: TCursor;
begin
  Result := FBackgroundSelect.Cursor;
end;

function TTransparentCircleIconButton.GetFHitTest: Boolean;
begin
  Result := FBackgroundSelect.HitTest;
end;

function TTransparentCircleIconButton.GetFIconAlign: TAlignLayout;
begin
  Result := FIcon.Align;
end;

function TTransparentCircleIconButton.GetFIconData: TPathData;
begin
  Result := FIcon.Data;
end;

function TTransparentCircleIconButton.GetFIconSize: Single;
begin
  Result := FIcon.Width;
end;

function TTransparentCircleIconButton.GetFOnClick: TNotifyEvent;
begin
  Result := FPointerOnClick;
end;

function TTransparentCircleIconButton.GetFOnDblClick: TNotifyEvent;
begin
  Result := FBackgroundSelect.OnDblClick;
end;

function TTransparentCircleIconButton.GetFOnMouseDown: TMouseEvent;
begin
  Result := FBackgroundSelect.OnMouseDown;
end;

function TTransparentCircleIconButton.GetFOnMouseEnter: TNotifyEvent;
begin
  Result := FPointerOnMouseEnter;
end;

function TTransparentCircleIconButton.GetFOnMouseLeave: TNotifyEvent;
begin
  Result := FPointerOnMouseExit;
end;

function TTransparentCircleIconButton.GetFOnMouseMove: TMouseMoveEvent;
begin
  Result := FBackgroundSelect.OnMouseMove;
end;

function TTransparentCircleIconButton.GetFOnMouseUp: TMouseEvent;
begin
  Result := FBackgroundSelect.OnMouseUp;
end;

function TTransparentCircleIconButton.GetFOnMouseWheel: TMouseWheelEvent;
begin
  Result := FBackgroundSelect.OnMouseWheel;
end;

function TTransparentCircleIconButton.GetFTag: NativeInt;
begin
  Result := TControl(Self).Tag;
end;

procedure TTransparentCircleIconButton.Paint;
begin
  inherited;
  if FIcon.Data.Data.Equals('') then
    FIcon.Visible := False
  else
    FIcon.Visible := True;

  FIcon.Fill.Color := GetFBackgroudColorAlphaMax;
end;

procedure TTransparentCircleIconButton.SetFBackgroudColor(const Value: TAlphaColor);
begin
  FBackgroundSelect.Fill.Color := Value;
end;

procedure TTransparentCircleIconButton.SetFButtonClass(const Value: TColorClass);
begin
  if Value = TColorClass.Primary then
  begin
    SetFBackgroudColor(TRANSPARENT_PRIMARY_COLOR);
  end
  else if Value = TColorClass.Secondary then
  begin
    SetFBackgroudColor(TRANSPARENT_SECONDARY_COLOR);
  end
  else if Value = TColorClass.Error then
  begin
    SetFBackgroudColor(TRANSPARENT_ERROR_COLOR);
  end
  else if Value = TColorClass.Warning then
  begin
    SetFBackgroudColor(TRANSPARENT_WARNING_COLOR);
  end
  else if Value = TColorClass.Normal then
  begin
    SetFBackgroudColor(TRANSPARENT_NORMAL_COLOR);
  end
  else if Value = TColorClass.Success then
  begin
    SetFBackgroudColor(TRANSPARENT_SUCCESS_COLOR);
  end
  else
  begin
    SetFBackgroudColor(TAlphaColor($1E303030));
  end;
end;

procedure TTransparentCircleIconButton.SetFCursor(const Value: TCursor);
begin
  FBackgroundSelect.Cursor := Value;
end;

procedure TTransparentCircleIconButton.SetFHitTest(const Value: Boolean);
begin
  FBackgroundSelect.HitTest := Value;
end;

procedure TTransparentCircleIconButton.SetFIconAlign(const Value: TAlignLayout);
begin
  FIcon.Align := Value;
end;

procedure TTransparentCircleIconButton.SetFIconData(const Value: TPathData);
begin
  FIcon.Data := Value;
end;

procedure TTransparentCircleIconButton.SetFIconSize(const Value: Single);
begin
  FIcon.Width := Value;
  FIcon.Height := Value;
end;

procedure TTransparentCircleIconButton.SetFOnClick(const Value: TNotifyEvent);
begin
  FPointerOnClick := Value;
end;

procedure TTransparentCircleIconButton.SetFOnDblClick(const Value: TNotifyEvent);
begin
  FBackgroundSelect.OnDblClick := Value;
end;

procedure TTransparentCircleIconButton.SetFOnMouseDown(const Value: TMouseEvent);
begin
  FBackgroundSelect.OnMouseDown := Value;
end;

procedure TTransparentCircleIconButton.SetFOnMouseEnter(const Value: TNotifyEvent);
begin
  FPointerOnMouseEnter := Value;
end;

procedure TTransparentCircleIconButton.SetFOnMouseLeave(const Value: TNotifyEvent);
begin
  FPointerOnMouseExit := Value;
end;

procedure TTransparentCircleIconButton.SetFOnMouseMove(const Value: TMouseMoveEvent);
begin
  FBackgroundSelect.OnMouseMove := Value;
end;

procedure TTransparentCircleIconButton.SetFOnMouseUp(const Value: TMouseEvent);
begin
  FBackgroundSelect.OnMouseUp := Value;
end;

procedure TTransparentCircleIconButton.SetFOnMouseWheel(const Value: TMouseWheelEvent);
begin
  FBackgroundSelect.OnMouseWheel := Value;
end;

procedure TTransparentCircleIconButton.SetFTag(const Value: NativeInt);
begin
  TControl(Self).Tag := Value;
  FBackgroundSelect.Tag := Value;
end;

end.
