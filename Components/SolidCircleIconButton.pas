unit SolidCircleIconButton;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, System.Types,
  FMX.Objects, FMX.StdCtrls, System.UITypes, FMX.Graphics, FMX.Dialogs, System.Math,
  System.Math.Vectors, FMX.Edit, FMX.Layouts, FMX.Effects, TransparentCircleIconButton,
  ColorClass;

type
  TSolidCircleIconButton = class(TTransparentCircleIconButton)
  private
    { Private declarations }
  protected
    { Protected declarations }
    FBackgroundButton: TCircle;
    FShadow: TShadowEffect;
    FContrastColor: TAlphaColor;

    procedure Paint; override;

    procedure BackgroundOnClick(Sender: TObject); override;
    procedure BackgroundOnEnter(Sender: TObject); override;
    procedure BackgroundOnExit(Sender: TObject); override;
    function GetFElevation: Boolean;
    procedure SetFElevation(const Value: Boolean);
    function GetFDark: Boolean;
    procedure SetFDark(const Value: Boolean);
    function GetFButtonClass: TColorClass; override;
    procedure SetFButtonClass(const Value: TColorClass); override;
    function GetFBackgroudColor: TAlphaColor; override;
    procedure SetFBackgroudColor(const Value: TAlphaColor); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    { Additional properties }
    property Elevation: Boolean read GetFElevation write SetFElevation;
    property Dark: Boolean read GetFDark write SetFDark;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Componentes Customizados', [TSolidCircleIconButton]);
end;

{ TSolidCircleIconButton }

procedure TSolidCircleIconButton.BackgroundOnClick(Sender: TObject);
var
  CircleEffect: TCircle;
  Aux: Single;
begin
  FButtonLockFocus.SetFocus; { Takes the focus off other components }

  if FAnimationOnClick then
  begin
    CircleEffect := TCircle.Create(Self);
    CircleEffect.HitTest := False;
    CircleEffect.Parent := FBackgroundButton;
    CircleEffect.Align := TAlignLayout.Center;
    CircleEffect.Stroke.Kind := TBrushKind.None;
    CircleEffect.Fill.Color := FContrastColor;
    CircleEffect.SendToBack;
    FBackgroundButton.ClipChildren := True;

    Aux := Min(FBackgroundSelect.Width, FBackgroundSelect.Height) * 1.05;

    CircleEffect.Height := 0;
    CircleEffect.Width := 0;
    CircleEffect.Opacity := 0.2;
    CircleEffect.AnimateFloat('Height', Aux, 0.4, TAnimationType.Out, TInterpolationType.Circular);
    CircleEffect.AnimateFloat('Width', Aux, 0.4, TAnimationType.Out, TInterpolationType.Circular);
    CircleEffect.AnimateFloat('Opacity', 0, 0.4);
  end;

  if Assigned(FPointerOnClick) then
    FPointerOnClick(Sender);
end;

procedure TSolidCircleIconButton.BackgroundOnEnter(Sender: TObject);
begin
  if Elevation then
  begin
    FShadow.AnimateFloat('Distance', 5, 0.2, TAnimationType.InOut);
    FShadow.AnimateFloat('Softness', 0.3, 0.2, TAnimationType.InOut);
  end;

  FBackgroundSelect.AnimateFloat('Opacity', 0.1, 0.1, TAnimationType.InOut);

  if Assigned(FPointerOnMouseEnter) then
    FPointerOnMouseEnter(Sender);
end;

procedure TSolidCircleIconButton.BackgroundOnExit(Sender: TObject);
begin
  if Elevation then
  begin
    FShadow.AnimateFloat('Distance', 2, 0.2, TAnimationType.InOut);
    FShadow.AnimateFloat('Softness', 0.15, 0.2, TAnimationType.InOut);
  end;

  FBackgroundSelect.AnimateFloat('Opacity', 0, 0.1, TAnimationType.InOut);

  if Assigned(FPointerOnMouseExit) then
    FPointerOnMouseExit(Sender);
end;

constructor TSolidCircleIconButton.Create(AOwner: TComponent);
begin
  inherited;
  FContrastColor := TAlphaColor($FFFFFFFF);

  FBackgroundButton := TCircle.Create(Self);
  Self.AddObject(FBackgroundButton);
  FBackgroundButton.SetSubComponent(True);
  FBackgroundButton.Stored := False;
  FBackgroundButton.Align := TAlignLayout.Contents;
  FBackgroundButton.Stroke.Kind := TBrushKind.None;
  FBackgroundButton.Fill.Color := TAlphaColor($FF1867C0);
  FBackgroundButton.OnMouseEnter := BackgroundOnEnter;
  FBackgroundButton.OnMouseLeave := BackgroundOnExit;
  FBackgroundButton.OnClick := BackgroundOnClick;
  FBackgroundButton.Cursor := crHandPoint;
  FBackgroundButton.SendToBack;

  FBackgroundSelect.Fill.Color := FContrastColor;
  FBackgroundSelect.BringToFront;

  FShadow := TShadowEffect.Create(Self);
  Self.AddObject(FShadow);
  FShadow.Direction := 90;
  FShadow.Distance := 2;
  FShadow.Opacity := 0.3;
  FShadow.Softness := 0.15;
  FShadow.Enabled := True;
  FShadow.SetSubComponent(True);
  FShadow.Stored := False;
end;

destructor TSolidCircleIconButton.Destroy;
begin
  if Assigned(FShadow) then
    FShadow.Free;
  if Assigned(FBackgroundButton) then
    FBackgroundButton.Free;
  inherited;
end;

function TSolidCircleIconButton.GetFBackgroudColor: TAlphaColor;
begin
  inherited;
  Result := FBackgroundSelect.Fill.Color;
  if Assigned(FBackgroundButton) then
    Result := FBackgroundButton.Fill.Color;
end;

function TSolidCircleIconButton.GetFButtonClass: TColorClass;
begin
  if FBackgroundButton.Fill.Color = SOLID_PRIMARY_COLOR then
    Result := TColorClass.Primary
  else if FBackgroundButton.Fill.Color = SOLID_SECONDARY_COLOR then
    Result := TColorClass.Secondary
  else if FBackgroundButton.Fill.Color = SOLID_ERROR_COLOR then
    Result := TColorClass.Error
  else if FBackgroundButton.Fill.Color = SOLID_WARNING_COLOR then
    Result := TColorClass.Warning
  else if FBackgroundButton.Fill.Color = SOLID_SUCCESS_COLOR then
    Result := TColorClass.Success
  else if FBackgroundButton.Fill.Color = SOLID_NORMAL_COLOR then
    Result := TColorClass.Normal
  else
    Result := TColorClass.Custom;
end;

function TSolidCircleIconButton.GetFDark: Boolean;
begin
  if FContrastColor = TAlphaColor($FF323232) then
    Result := True
  else
    Result := False;
end;

function TSolidCircleIconButton.GetFElevation: Boolean;
begin
  Result := FShadow.Enabled;
end;

procedure TSolidCircleIconButton.Paint;
begin
  inherited;
  if FIcon.Data.Data.Equals('') then
    FIcon.Visible := False
  else
    FIcon.Visible := True;

  FBackgroundSelect.Fill.Color := FContrastColor;
  FIcon.Fill.Color := FContrastColor;
end;

procedure TSolidCircleIconButton.SetFBackgroudColor(const Value: TAlphaColor);
begin
  if Assigned(FBackgroundButton) then
    FBackgroundButton.Fill.Color := Value;
end;

procedure TSolidCircleIconButton.SetFButtonClass(const Value: TColorClass);
begin
  if Value = TColorClass.Primary then
  begin
    SetFBackgroudColor(SOLID_PRIMARY_COLOR);
    SetFDark(False);
  end
  else if Value = TColorClass.Secondary then
  begin
    SetFBackgroudColor(SOLID_SECONDARY_COLOR);
    SetFDark(False);
  end
  else if Value = TColorClass.Error then
  begin
    SetFBackgroudColor(SOLID_ERROR_COLOR);
    SetFDark(False);
  end
  else if Value = TColorClass.Warning then
  begin
    SetFBackgroudColor(SOLID_WARNING_COLOR);
    SetFDark(False);
  end
  else if Value = TColorClass.Normal then
  begin
    SetFBackgroudColor(SOLID_NORMAL_COLOR);
    SetFDark(True);
  end
  else if Value = TColorClass.Success then
  begin
    SetFBackgroudColor(SOLID_SUCCESS_COLOR);
    SetFDark(False);
  end
  else
  begin
    FBackgroundButton.Fill.Color := TAlphaColor($FF323232);
    SetFDark(False);
  end;
end;

procedure TSolidCircleIconButton.SetFDark(const Value: Boolean);
begin
  if Value then
    FContrastColor := TAlphaColor($FF323232)
  else
    FContrastColor := TAlphaColor($FFFFFFFF);
end;

procedure TSolidCircleIconButton.SetFElevation(const Value: Boolean);
begin
  FShadow.Enabled := Value;
end;

end.
