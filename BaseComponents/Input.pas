unit Input;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, System.Types,
  FMX.Objects, System.UITypes, FMX.Graphics, FMX.Dialogs, System.Math,
  System.Math.Vectors, FMX.Edit, FMX.Layouts, FMX.Effects, LongInput;

type
  TIconPosition = (Left, Right);

  TInput = class(TControl)
  private
    { Private declarations }
  protected
    { Protected declarations }
    FPointerOnEnter: TNotifyEvent;
    FPointerOnExit: TNotifyEvent;
    FPointerOnIconClick: TNotifyEvent;
    FPointerOnKeyUp: TKeyEvent;

    FInvalid: Boolean;
    FBackground: TRectangle;
    FEdit: TEdit;
    FIcon: TPath;
    FLayoutIcon: TLayout;
    FLayoutIconClick: TLayout;
    FTabNext: TControl;

    procedure Paint; override;
    procedure OnKeyUpTabNext(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);

    { Repaint }
    procedure DoChanged(Sender: TObject);

    { Events settings }
    procedure OnEditEnter(Sender: TObject); virtual;
    procedure OnEditExit(Sender: TObject); virtual;
    procedure SetFText(const Value: String); virtual;
    function Validate(): Boolean; virtual;

    function GetFText: String;
    function GetFTag: NativeInt;
    procedure SetFTag(const Value: NativeInt);
    procedure SetFTabNext(const Value: TControl);
    procedure OnFBackgroundClick(Sender: TObject);
    procedure OnFIconClick(Sender: TObject);
    procedure SetFOnTyping(const Value: TNotifyEvent);
    function GetFOnTyping: TNotifyEvent;
    function GetFTextPrompt: String;
    procedure SetFTextPrompt(const Value: String);
    function GetFPassword: Boolean;
    procedure SetFPassword(const Value: Boolean);
    function GetFOnClick: TNotifyEvent;
    procedure SetFOnClick(const Value: TNotifyEvent);
    function GetFOnDblClick: TNotifyEvent;
    procedure SetFOnDblClick(const Value: TNotifyEvent);
    function GetTextSettings: TTextSettings;
    procedure SetTextSettings(const Value: TTextSettings);
    function GetFBackgroudColor: TBrush;
    procedure SetFBackgroudColor(const Value: TBrush);
    procedure SetFIconPosition(const Value: TIconPosition);
    function GetFHitTest: Boolean;
    procedure SetFHitTest(const Value: Boolean);
    function GetFCursor: TCursor;
    procedure SetFCursor(const Value: TCursor);
    function GetFOnKeyDown: TKeyEvent;
    procedure SetFOnKeyDown(const Value: TKeyEvent);
    function GetFOnKeyUp: TKeyEvent;
    procedure SetFOnKeyUp(const Value: TKeyEvent);
    function GetFOnMouseDown: TMouseEvent;
    procedure SetFOnMouseDown(const Value: TMouseEvent);
    function GetFOnMouseUp: TMouseEvent;
    procedure SetFOnMouseUp(const Value: TMouseEvent);
    function GetFOnMouseWheel: TMouseWheelEvent;
    procedure SetFOnMouseWheel(const Value: TMouseWheelEvent);
    function GetFOnMouseMove: TMouseMoveEvent;
    procedure SetFOnMouseMove(const Value: TMouseMoveEvent);
    function GetFOnMouseEnter: TNotifyEvent;
    procedure SetFOnMouseEnter(const Value: TNotifyEvent);
    function GetFOnMouseLeave: TNotifyEvent;
    procedure SetFOnMouseLeave(const Value: TNotifyEvent);
    function GetFMaxLength: Integer;
    procedure SetFMaxLength(const Value: Integer);
    function GetFFilterChar: String;
    procedure SetFFilterChar(const Value: String);
    function GetFOnEnter: TNotifyEvent;
    function GetFOnExit: TNotifyEvent;
    procedure SetFOnEnter(const Value: TNotifyEvent);
    procedure SetFOnExit(const Value: TNotifyEvent);
    function GetFReadOnly: Boolean;
    procedure SetFReadOnly(const Value: Boolean);
    function GetFOnIconClick: TNotifyEvent;
    procedure SetFOnIconClick(const Value: TNotifyEvent);
    function GetFCanFocus: Boolean;
    procedure SetFCanFocus(const Value: Boolean);
    function GetFCaret: TCaret;
    procedure SetFCaret(const Value: TCaret);
    function GetFIconPosition: TIconPosition;
    function GetFIconData: TPathData;
    procedure SetFIconData(const Value: TPathData);
    function GetFIconSize: Single;
    procedure SetFIconSize(const Value: Single);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetFocus; reintroduce;
    procedure Clear;
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
    property Caret: TCaret read GetFCaret write SetFCaret;
    property CanFocus: Boolean read GetFCanFocus write SetFCanFocus default True;
    property Cursor: TCursor read GetFCursor write SetFCursor;
    property HitTest: Boolean read GetFHitTest write SetFHitTest default True;
    property ReadOnly: Boolean read GetFReadOnly write SetFReadOnly;
    property BackgroudColor: TBrush read GetFBackgroudColor write SetFBackgroudColor;
    property Text: String read GetFText write SetFText;
    property TextPrompt: String read GetFTextPrompt write SetFTextPrompt;
    property TextSettings: TTextSettings read GetTextSettings write SetTextSettings;
    property MaxLength: Integer read GetFMaxLength write SetFMaxLength;
    property FilterChar: String read GetFFilterChar write SetFFilterChar;
    property Password: Boolean read GetFPassword write SetFPassword;
    property IconData: TPathData read GetFIconData write SetFIconData;
    property IconSize: Single read GetFIconSize write SetFIconSize;
    property IconPosition: TIconPosition read GetFIconPosition write SetFIconPosition;
    property TabNext: TControl read FTabNext write SetFTabNext;
    property Tag: NativeInt read GetFTag write SetFTag;

    { Events }
    property OnPainting;
    property OnPaint;
    property OnResize;

    { Mouse events }
    property OnIconClick: TNotifyEvent read GetFOnIconClick write SetFOnIconClick;
    property OnClick: TNotifyEvent read GetFOnClick write SetFOnClick;
    property OnDblClick: TNotifyEvent read GetFOnDblClick write SetFOnDblClick;
    property OnKeyDown: TKeyEvent read GetFOnKeyDown write SetFOnKeyDown;
    property OnKeyUp: TKeyEvent read GetFOnKeyUp write SetFOnKeyUp;
    property OnMouseDown: TMouseEvent read GetFOnMouseDown write SetFOnMouseDown;
    property OnMouseUp: TMouseEvent read GetFOnMouseUp write SetFOnMouseUp;
    property OnMouseWheel: TMouseWheelEvent read GetFOnMouseWheel write SetFOnMouseWheel;
    property OnMouseMove: TMouseMoveEvent read GetFOnMouseMove write SetFOnMouseMove;
    property OnMouseEnter: TNotifyEvent read GetFOnMouseEnter write SetFOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read GetFOnMouseLeave write SetFOnMouseLeave;
    property OnTyping: TNotifyEvent read GetFOnTyping write SetFOnTyping;
    property OnEnter: TNotifyEvent read GetFOnEnter write SetFOnEnter;
    property OnExit: TNotifyEvent read GetFOnExit write SetFOnExit;
  end;

implementation

procedure TInput.OnEditEnter(Sender: TObject);
begin
  if Assigned(FPointerOnEnter) then
    FPointerOnEnter(Sender);
end;

procedure TInput.OnEditExit(Sender: TObject);
begin
  if Assigned(FPointerOnExit) then
    FPointerOnExit(Sender);
end;

procedure TInput.OnFBackgroundClick(Sender: TObject);
begin
  FEdit.SetFocus;
end;

procedure TInput.OnFIconClick(Sender: TObject);
begin
  OnFBackgroundClick(Sender);
  if Assigned(FPointerOnIconClick) then
    FPointerOnIconClick(Sender);
end;

procedure TInput.OnKeyUpTabNext(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if (Key = vkTab) and (Assigned(FTabNext)) then
  begin
    if (FTabNext is TInput) then
      TInput(FTabNext).SetFocus
    else if (FTabNext is TLongInput) then
      TLongInput(FTabNext).SetFocus
    else
      FTabNext.SetFocus;
  end;

  if Assigned(FPointerOnKeyUp) then
    FPointerOnKeyUp(Sender, Key, KeyChar, Shift);
end;

procedure TInput.SetFOnClick(const Value: TNotifyEvent);
begin
  FEdit.OnClick := Value;
end;

procedure TInput.SetFBackgroudColor(const Value: TBrush);
begin
  FBackground.Fill := Value;
end;

function TInput.GetFBackgroudColor: TBrush;
begin
  Result := FBackground.Fill;
end;

procedure TInput.SetFCursor(const Value: TCursor);
begin
  FBackground.Cursor := Value;
  FEdit.Cursor := Value;
end;

function TInput.GetFCanFocus: Boolean;
begin
  Result := FEdit.CanFocus;
end;

procedure TInput.SetFCanFocus(const Value: Boolean);
begin
  FEdit.CanFocus := Value;
end;

function TInput.GetFCaret: TCaret;
begin
  Result := FEdit.Caret;
end;

procedure TInput.SetFCaret(const Value: TCaret);
begin
  FEdit.Caret := Value;
end;

function TInput.GetFCursor: TCursor;
begin
  Result := FBackground.Cursor;
end;

procedure TInput.SetFIconData(const Value: TPathData);
begin
  FIcon.Data := Value;
end;

procedure TInput.SetFIconPosition(const Value: TIconPosition);
begin
  if Value = TIconPosition.Right then
  begin
    FLayoutIcon.Align := TAlignLayout.Right;
    FIcon.Align := TAlignLayout.Left;
  end
  else
  begin
    FLayoutIcon.Align := TAlignLayout.Left;
    FIcon.Align := TAlignLayout.Right;
  end;
end;

procedure TInput.SetFIconSize(const Value: Single);
begin
  FIcon.Width := Value;
  FIcon.Height := Value;
end;

function TInput.GetFIconData: TPathData;
begin
  Result := FIcon.Data;
end;

function TInput.GetFIconPosition: TIconPosition;
begin
  Result := TIconPosition.Right;
  if FLayoutIcon.Align = TAlignLayout.Right then
    Result := TIconPosition.Right
  else if FLayoutIcon.Align = TAlignLayout.Left then
    Result := TIconPosition.Left;
end;

function TInput.GetFIconSize: Single;
begin
  Result := FIcon.Width;
end;

procedure TInput.SetFocus;
begin
  FEdit.SetFocus;
end;

procedure TInput.Clear;
begin
  Self.Text := '';
end;

function TInput.Validate: Boolean;
begin
  Result := not(FEdit.Text.Length = 0);
  FInvalid := not Result;
end;

procedure TInput.SetFFilterChar(const Value: String);
begin
  FEdit.FilterChar := Value;
end;

function TInput.GetFFilterChar: String;
begin
  Result := FEdit.FilterChar;
end;

procedure TInput.SetFHitTest(const Value: Boolean);
begin
  FBackground.HitTest := Value;
  FEdit.HitTest := Value;
end;

function TInput.GetFHitTest: Boolean;
begin
  Result := FBackground.HitTest;
end;

procedure TInput.SetFMaxLength(const Value: Integer);
begin
  FEdit.MaxLength := Value;
end;

function TInput.GetFMaxLength: Integer;
begin
  Result := FEdit.MaxLength;
end;

function TInput.GetFOnClick: TNotifyEvent;
begin
  Result := FEdit.OnClick;
end;

procedure TInput.SetFOnDblClick(const Value: TNotifyEvent);
begin
  FEdit.OnDblClick := Value;
end;

function TInput.GetFOnDblClick: TNotifyEvent;
begin
  Result := FEdit.OnDblClick;
end;

procedure TInput.SetFOnEnter(const Value: TNotifyEvent);
begin
  FPointerOnEnter := Value;
end;

function TInput.GetFOnEnter: TNotifyEvent;
begin
  Result := FPointerOnEnter;
end;

procedure TInput.SetFOnExit(const Value: TNotifyEvent);
begin
  FPointerOnExit := Value;
end;

function TInput.GetFOnExit: TNotifyEvent;
begin
  Result := FPointerOnExit;
end;

procedure TInput.SetFOnIconClick(const Value: TNotifyEvent);
begin
  FPointerOnIconClick := Value;
  if Assigned(Value) then
    FLayoutIconClick.HitTest := True
  else
    FLayoutIconClick.HitTest := False;
end;

function TInput.GetFOnIconClick: TNotifyEvent;
begin
  Result := FPointerOnIconClick;
end;

procedure TInput.SetFOnKeyDown(const Value: TKeyEvent);
begin
  FEdit.OnKeyDown := Value;
end;

function TInput.GetFOnKeyDown: TKeyEvent;
begin
  Result := FEdit.OnKeyDown;
end;

procedure TInput.SetFOnKeyUp(const Value: TKeyEvent);
begin
  FPointerOnKeyUp := Value;
end;

function TInput.GetFOnKeyUp: TKeyEvent;
begin
  Result := FPointerOnKeyUp;
end;

procedure TInput.SetFOnMouseDown(const Value: TMouseEvent);
begin
  FEdit.OnMouseDown := Value;
end;

function TInput.GetFOnMouseDown: TMouseEvent;
begin
  Result := FEdit.OnMouseDown;
end;

procedure TInput.SetFOnMouseEnter(const Value: TNotifyEvent);
begin
  FEdit.OnMouseEnter := Value;
end;

function TInput.GetFOnMouseEnter: TNotifyEvent;
begin
  Result := FEdit.OnMouseEnter;
end;

procedure TInput.SetFOnMouseLeave(const Value: TNotifyEvent);
begin
  FEdit.OnMouseLeave := Value;
end;

function TInput.GetFOnMouseLeave: TNotifyEvent;
begin
  Result := FEdit.OnMouseLeave;
end;

procedure TInput.SetFOnMouseMove(const Value: TMouseMoveEvent);
begin
  FEdit.OnMouseMove := Value;
end;

function TInput.GetFOnMouseMove: TMouseMoveEvent;
begin
  Result := FEdit.OnMouseMove;
end;

procedure TInput.SetFOnMouseUp(const Value: TMouseEvent);
begin
  FEdit.OnMouseUp := Value;
end;

function TInput.GetFOnMouseUp: TMouseEvent;
begin
  Result := FEdit.OnMouseUp;
end;

procedure TInput.SetFOnMouseWheel(const Value: TMouseWheelEvent);
begin
  FEdit.OnMouseWheel := Value;
end;

function TInput.GetFOnMouseWheel: TMouseWheelEvent;
begin
  Result := FEdit.OnMouseWheel;
end;

procedure TInput.SetFOnTyping(const Value: TNotifyEvent);
begin
  FEdit.OnTyping := Value;
end;

function TInput.GetFOnTyping: TNotifyEvent;
begin
  Result := FEdit.OnTyping;
end;

procedure TInput.SetFTabNext(const Value: TControl);
begin
  FTabNext := Value;
end;

procedure TInput.SetFTag(const Value: NativeInt);
begin
  FBackground.Tag := Value;
  FEdit.Tag := Value;
  FLayoutIconClick.Tag := Value;
  TControl(Self).Tag := Value;
end;

procedure TInput.SetFText(const Value: String);
begin
  FEdit.Text := Value;
end;

function TInput.GetFTag: NativeInt;
begin
  Result := TControl(Self).Tag;
end;

function TInput.GetFText: String;
begin
  Result := FEdit.Text;
end;

procedure TInput.SetFTextPrompt(const Value: String);
begin
  FEdit.TextPrompt := Value;
end;

function TInput.GetFTextPrompt: String;
begin
  Result := FEdit.TextPrompt;
end;

procedure TInput.SetTextSettings(const Value: TTextSettings);
begin
  FEdit.TextSettings := Value;
end;

function TInput.GetTextSettings: TTextSettings;
begin
  Result := FEdit.TextSettings;
end;

procedure TInput.SetFPassword(const Value: Boolean);
begin
  FEdit.Password := Value;
end;

function TInput.GetFPassword: Boolean;
begin
  Result := FEdit.Password;
end;

procedure TInput.SetFReadOnly(const Value: Boolean);
begin
  FEdit.ReadOnly := Value;
end;

function TInput.GetFReadOnly: Boolean;
begin
  Result := FEdit.ReadOnly;
end;

{ Protected declarations }

procedure TInput.Paint;
begin
  inherited;
  if FIcon.Data.Data.Equals('') then
  begin
    FLayoutIcon.Visible := False;
    FIcon.Visible := False;
  end
  else
  begin
    FLayoutIcon.Visible := True;
    FIcon.Visible := True;
    FLayoutIcon.Width := 13 + FIcon.Width;
  end;
end;

{ Repaint }

procedure TInput.DoChanged(Sender: TObject);
begin
  Repaint;
end;

{ Public declarations }

constructor TInput.Create(AOwner: TComponent);
begin
  inherited;
  Self.Width := 250;
  Self.Height := 40;

  { Backgroud }
  FBackground := TRectangle.Create(Self);
  Self.AddObject(FBackground);
  FBackground.Align := TAlignLayout.Contents;
  FBackground.Stroke.Kind := TBrushKind.None;
  FBackground.Fill.Color := TAlphaColor($C8FFFFFF);
  FBackground.XRadius := 4;
  FBackground.YRadius := 4;
  FBackground.SetSubComponent(True);
  FBackground.Stored := False;
  FBackground.OnClick := OnFBackgroundClick;

  { Edit }
  FEdit := TEdit.Create(Self);
  FEdit.Parent := FBackground;
  FEdit.Align := TAlignLayout.Client;
  FEdit.Margins.Top := 5;
  FEdit.Margins.Bottom := 5;
  FEdit.Margins.Left := 8;
  FEdit.Margins.Right := 8;
  FEdit.StyleLookup := 'transparentedit';
  FEdit.StyledSettings := [];
  FEdit.TextSettings.Font.Size := 14;
  FEdit.TextSettings.Font.Family := 'SF Pro Display';
  FEdit.TextSettings.FontColor := TAlphaColor($FF323232);
  FEdit.SetSubComponent(True);
  FEdit.Stored := False;
  FEdit.OnKeyUp := OnKeyUpTabNext;
  FEdit.TabStop := False;

  FEdit.OnEnter := OnEditEnter;
  FEdit.OnExit := OnEditExit;

  { Icon }
  FLayoutIcon := TLayout.Create(Self);
  FBackground.AddObject(FLayoutIcon);
  FLayoutIcon.Align := TAlignLayout.Left;
  FLayoutIcon.Width := 25;
  FLayoutIcon.HitTest := False;
  FLayoutIcon.SetSubComponent(True);
  FLayoutIcon.Stored := False;

  FIcon := TPath.Create(Self);
  FLayoutIcon.AddObject(FIcon);
  FIcon.Align := TAlignLayout.Right;
  FIcon.WrapMode := TPathWrapMode.Fit;
  FIcon.Fill.Color := TAlphaColor($FF515151);
  FIcon.Stroke.Kind := TBrushKind.None;
  FIcon.Width := 12;
  FIcon.HitTest := False;
  FIcon.SetSubComponent(True);
  FIcon.Stored := False;

  { Layout Click }
  FLayoutIconClick := TLayout.Create(Self);
  FIcon.AddObject(FLayoutIconClick);
  FLayoutIconClick.Align := TAlignLayout.Client;
  FLayoutIconClick.Margins.Left := -10;
  FLayoutIconClick.Margins.Right := -10;
  FLayoutIconClick.Cursor := crHandPoint;
  FLayoutIconClick.HitTest := False;
  FLayoutIconClick.OnClick := OnFIconClick;

  { Initial settings }
  SetFCursor(crIBeam);
end;

destructor TInput.Destroy;
begin
  if Assigned(FIcon) then
    FIcon.Free;
  if Assigned(FLayoutIcon) then
    FLayoutIcon.Free;
  if Assigned(FEdit) then
    FEdit.Free;
  if Assigned(FBackground) then
    FBackground.Free;
  inherited;
end;

end.
