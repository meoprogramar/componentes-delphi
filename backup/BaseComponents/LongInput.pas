unit LongInput;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, System.Types,
  FMX.Objects, System.UITypes, FMX.Graphics, FMX.Dialogs, System.Math,
  System.Math.Vectors, FMX.Edit, FMX.Layouts, FMX.Effects, FMX.Memo,
  FMX.StdCtrls;

type
  TIconPosition = (Left, Right);

  TLongInput = class(TControl)
  private
    { Private declarations }
    procedure FMemoOnApplyStyleLookup(Sender: TObject);
    procedure FMemoOnChangeTracking(Sender: TObject);

    procedure EventOnChangeTracking(Sender: TObject);
  protected
    { Protected declarations }
    FPointerOnTyping: TNotifyEvent;
    FPointerOnChangeTracking: TNotifyEvent;
    FPointerOnEnter: TNotifyEvent;
    FPointerOnExit: TNotifyEvent;
    FPointerOnKeyUp: TKeyEvent;

    FBackground: TRectangle;
    FMemo: TMemo;
    FLabel: TLabel;
    FDark: Boolean;
    FTabNext: TControl;

    FDarkTheme: TAlphaColor;
    FLightTheme: TAlphaColor;

    procedure Paint; override;
    procedure Resize; override;
    procedure Painting; override;
    procedure OnKeyUpTabNext(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);

    { Repaint }
    procedure DoChanged(Sender: TObject);

    { Events settings }
    function GetFTag: NativeInt;
    procedure SetFTag(const Value: NativeInt);
    function GetFOnChangeTracking: TNotifyEvent;
    procedure SetFOnChangeTracking(const Value: TNotifyEvent);
    procedure SetFTabNext(const Value: TControl);
    procedure OnEditEnter(Sender: TObject); virtual;
    procedure OnEditExit(Sender: TObject); virtual;
    function Validate(): Boolean; virtual;
    procedure OnFBackgroundClick(Sender: TObject);
    function GetFText: String;
    procedure SetFText(const Value: String);
    function GetFTextPrompt: String;
    procedure SetFTextPrompt(const Value: String);
    function GetFOnClick: TNotifyEvent;
    procedure SetFOnClick(const Value: TNotifyEvent);
    function GetFOnDblClick: TNotifyEvent;
    procedure SetFOnDblClick(const Value: TNotifyEvent);
    function GetTextSettings: TTextSettings;
    procedure SetTextSettings(const Value: TTextSettings);
    function GetFBackgroudColor: TAlphaColor;
    procedure SetFBackgroudColor(const Value: TAlphaColor);
    function GetFDark: Boolean;
    procedure SetFDark(const Value: Boolean);
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
    function GetFOnEnter: TNotifyEvent;
    function GetFOnExit: TNotifyEvent;
    procedure SetFOnEnter(const Value: TNotifyEvent);
    procedure SetFOnExit(const Value: TNotifyEvent);
    function GetFReadOnly: Boolean;
    procedure SetFReadOnly(const Value: Boolean);
    function GetFCanFocus: Boolean;
    procedure SetFCanFocus(const Value: Boolean);
    function GetFCaret: TCaret;
    procedure SetFCaret(const Value: TCaret);
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
    property Dark: Boolean read GetFDark write SetFDark;
    property BackgroudColor: TAlphaColor read GetFBackgroudColor write SetFBackgroudColor;
    property Text: String read GetFText write SetFText;
    property TextPrompt: String read GetFTextPrompt write SetFTextPrompt;
    property TextSettings: TTextSettings read GetTextSettings write SetTextSettings;
    property MaxLength: Integer read GetFMaxLength write SetFMaxLength;
    property TabNext: TControl read FTabNext write SetFTabNext;
    property Tag: NativeInt read GetFTag write SetFTag;

    { Optional properties - Rarely used }
    // property CanFocus default True;
    // property DragMode;
    // property EnableDragHighlight;
    // property Locked;
    // property Padding;
    // property PopupMenu;
    // property TouchTargetExpansion;
    // property TabOrder default -1;
    // property TabStop default True;

    { Events }
    property OnPainting;
    property OnPaint;
    property OnResize;

    { Mouse events }
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
    property OnChangeTracking: TNotifyEvent read GetFOnChangeTracking write SetFOnChangeTracking;
    property OnEnter: TNotifyEvent read GetFOnEnter write SetFOnEnter;
    property OnExit: TNotifyEvent read GetFOnExit write SetFOnExit;
    property OnTyping: TNotifyEvent read FPointerOnTyping write FPointerOnTyping;

    { Optional events - Rarely used }
    // property OnDragEnter;
    // property OnDragLeave;
    // property OnDragOver;
    // property OnDragDrop;
    // property OnDragEnd;
  end;

implementation

uses
  Input;

procedure TLongInput.OnEditEnter(Sender: TObject);
begin
  if Assigned(FPointerOnEnter) then
    FPointerOnEnter(Sender);
end;

procedure TLongInput.OnEditExit(Sender: TObject);
begin
  if Assigned(FPointerOnExit) then
    FPointerOnExit(Sender);
end;

procedure TLongInput.OnFBackgroundClick(Sender: TObject);
begin
  FMemo.SetFocus;
end;

procedure TLongInput.OnKeyUpTabNext(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
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

procedure TLongInput.SetFOnChangeTracking(const Value: TNotifyEvent);
begin
  FPointerOnChangeTracking := Value;
end;

procedure TLongInput.SetFOnClick(const Value: TNotifyEvent);
begin
  FMemo.OnClick := Value;
end;

procedure TLongInput.SetFBackgroudColor(const Value: TAlphaColor);
begin
  FBackground.Fill.Color := Value;
end;

function TLongInput.GetFBackgroudColor: TAlphaColor;
begin
  Result := FBackground.Fill.Color;
end;

procedure TLongInput.SetFCursor(const Value: TCursor);
begin
  FBackground.Cursor := Value;
  FMemo.Cursor := Value;
end;

function TLongInput.GetFCanFocus: Boolean;
begin
  Result := FMemo.CanFocus;
end;

procedure TLongInput.SetFCanFocus(const Value: Boolean);
begin
  FMemo.CanFocus := Value;
end;

function TLongInput.GetFCaret: TCaret;
begin
  Result := FMemo.Caret;
end;

procedure TLongInput.SetFCaret(const Value: TCaret);
begin
  FMemo.Caret := Value;
end;

function TLongInput.GetFCursor: TCursor;
begin
  Result := FBackground.Cursor;
end;

procedure TLongInput.SetFDark(const Value: Boolean);
begin
  FDark := Value;
  FBackground.Fill.Kind := TBrushKind.Solid;
  if Value then
  begin
    FBackground.Fill.Color := FDarkTheme;
    FMemo.TextSettings.FontColor := TAlphaColor($FFFFFFFF);
  end
  else
  begin
    FBackground.Fill.Color := FLightTheme;
    FMemo.TextSettings.FontColor := TAlphaColor($FF323232);
  end;
end;

procedure TLongInput.SetFocus;
begin
  FMemo.SetFocus;
end;

procedure TLongInput.Clear;
begin
  FMemo.Text := '';
end;

function TLongInput.Validate: Boolean;
begin
  Result := not(FMemo.Text.Length = 0);
end;

function TLongInput.GetFDark: Boolean;
begin
  Result := FDark;
end;

procedure TLongInput.SetFHitTest(const Value: Boolean);
begin
  FBackground.HitTest := Value;
  FMemo.HitTest := Value;
end;

function TLongInput.GetFHitTest: Boolean;
begin
  Result := FBackground.HitTest;
end;

procedure TLongInput.SetFMaxLength(const Value: Integer);
begin
  FMemo.MaxLength := Value;
end;

function TLongInput.GetFMaxLength: Integer;
begin
  Result := FMemo.MaxLength;
end;

function TLongInput.GetFOnChangeTracking: TNotifyEvent;
begin
  Result := FPointerOnChangeTracking;
end;

function TLongInput.GetFOnClick: TNotifyEvent;
begin
  Result := FMemo.OnClick;
end;

procedure TLongInput.SetFOnDblClick(const Value: TNotifyEvent);
begin
  FMemo.OnDblClick := Value;
end;

function TLongInput.GetFOnDblClick: TNotifyEvent;
begin
  Result := FMemo.OnDblClick;
end;

procedure TLongInput.SetFOnEnter(const Value: TNotifyEvent);
begin
  FPointerOnEnter := Value;
end;

function TLongInput.GetFOnEnter: TNotifyEvent;
begin
  Result := FPointerOnEnter;
end;

procedure TLongInput.SetFOnExit(const Value: TNotifyEvent);
begin
  FPointerOnExit := Value;
end;

function TLongInput.GetFOnExit: TNotifyEvent;
begin
  Result := FPointerOnExit;
end;

procedure TLongInput.SetFOnKeyDown(const Value: TKeyEvent);
begin
  FMemo.OnKeyDown := Value;
end;

function TLongInput.GetFOnKeyDown: TKeyEvent;
begin
  Result := FMemo.OnKeyDown;
end;

procedure TLongInput.SetFOnKeyUp(const Value: TKeyEvent);
begin
  FPointerOnKeyUp := Value;
end;

function TLongInput.GetFOnKeyUp: TKeyEvent;
begin
  Result := FPointerOnKeyUp;
end;

procedure TLongInput.SetFOnMouseDown(const Value: TMouseEvent);
begin
  FMemo.OnMouseDown := Value;
end;

function TLongInput.GetFOnMouseDown: TMouseEvent;
begin
  Result := FMemo.OnMouseDown;
end;

procedure TLongInput.SetFOnMouseEnter(const Value: TNotifyEvent);
begin
  FMemo.OnMouseEnter := Value;
end;

function TLongInput.GetFOnMouseEnter: TNotifyEvent;
begin
  Result := FMemo.OnMouseEnter;
end;

procedure TLongInput.SetFOnMouseLeave(const Value: TNotifyEvent);
begin
  FMemo.OnMouseLeave := Value;
end;

function TLongInput.GetFOnMouseLeave: TNotifyEvent;
begin
  Result := FMemo.OnMouseLeave;
end;

procedure TLongInput.SetFOnMouseMove(const Value: TMouseMoveEvent);
begin
  FMemo.OnMouseMove := Value;
end;

function TLongInput.GetFOnMouseMove: TMouseMoveEvent;
begin
  Result := FMemo.OnMouseMove;
end;

procedure TLongInput.SetFOnMouseUp(const Value: TMouseEvent);
begin
  FMemo.OnMouseUp := Value;
end;

function TLongInput.GetFOnMouseUp: TMouseEvent;
begin
  Result := FMemo.OnMouseUp;
end;

procedure TLongInput.SetFOnMouseWheel(const Value: TMouseWheelEvent);
begin
  FMemo.OnMouseWheel := Value;
end;

function TLongInput.GetFOnMouseWheel: TMouseWheelEvent;
begin
  Result := FMemo.OnMouseWheel;
end;

procedure TLongInput.SetFTabNext(const Value: TControl);
begin
  FTabNext := Value;
end;

procedure TLongInput.SetFTag(const Value: NativeInt);
begin
  FBackground.Tag := Value;
  FMemo.Tag := Value;
  TControl(Self).Tag := Value;
end;

procedure TLongInput.SetFText(const Value: String);
begin
  FMemo.Text := Value;
end;

function TLongInput.GetFTag: NativeInt;
begin
  Result := TControl(Self).Tag;
end;

function TLongInput.GetFText: String;
begin
  Result := FMemo.Text;
end;

procedure TLongInput.SetFTextPrompt(const Value: String);
begin
  FLabel.Text := Value;
end;

function TLongInput.GetFTextPrompt: String;
begin
  Result := FLabel.Text;
end;

procedure TLongInput.SetTextSettings(const Value: TTextSettings);
begin
  FMemo.TextSettings := Value;
end;

function TLongInput.GetTextSettings: TTextSettings;
begin
  Result := FMemo.TextSettings;
end;

procedure TLongInput.SetFReadOnly(const Value: Boolean);
begin
  FMemo.ReadOnly := Value;
end;

function TLongInput.GetFReadOnly: Boolean;
begin
  Result := FMemo.ReadOnly;
end;

{ Protected declarations }

procedure TLongInput.Paint;
begin
  inherited;

  FLabel.TextSettings := FMemo.TextSettings;
end;

procedure TLongInput.Resize;
begin
  inherited;
  if Assigned(FBackground) then
  begin
    with FBackground do
    begin
      Height := Self.Width * 0.85;
      Width := Self.Width * 0.85;
      Position.X := Self.Width / 2 - Width / 2;
      Position.Y := Self.Height / 2 - Height / 2;
    end;
  end;
end;

procedure TLongInput.Painting;
begin
  inherited;
end;

{ Repaint }

procedure TLongInput.DoChanged(Sender: TObject);
begin
  Repaint;
end;

procedure TLongInput.EventOnChangeTracking(Sender: TObject);
begin
  FMemoOnChangeTracking(Sender);

  if Assigned(FPointerOnChangeTracking) then
    FPointerOnChangeTracking(Sender);

  if Assigned(FPointerOnTyping) then
    FPointerOnTyping(Sender);
end;

procedure TLongInput.FMemoOnApplyStyleLookup(Sender: TObject);
var
  Obj: TFmxObject;
  Rectangle1: TRectangle;
begin
  Obj := FMemo.FindStyleResource('background');
  if Obj <> nil then
  begin
    TControl(Obj).Margins := TBounds.Create(TRectF.Create(-2, -2, -2, -2));
    Rectangle1 := TRectangle.Create(Obj);
    Obj.AddObject(Rectangle1);
    Rectangle1.Align := TAlignLayout.Contents;
    Rectangle1.Fill.Color := GetFBackgroudColor;
    Rectangle1.Stroke.Kind := TBrushKind.None;
    Rectangle1.HitTest := False;
    Rectangle1.SendToBack;
  end;
end;

procedure TLongInput.FMemoOnChangeTracking(Sender: TObject);
begin
  if FMemo.Text.Equals('') then
    FLabel.Visible := True
  else
    FLabel.Visible := False;
end;

{ Public declarations }

constructor TLongInput.Create(AOwner: TComponent);
begin
  inherited;
  Self.Width := 400;
  Self.Height := 120;

  FDarkTheme := TAlphaColor($FF2F2F2F);
  FLightTheme := TAlphaColor($FFFFFFFF);

  { Backgroud }
  FBackground := TRectangle.Create(Self);
  Self.AddObject(FBackground);
  FBackground.Align := TAlignLayout.Contents;
  FBackground.Stroke.Kind := TBrushKind.None;
  FBackground.Fill.Color := FLightTheme;
  FBackground.XRadius := 4;
  FBackground.YRadius := 4;
  FBackground.SetSubComponent(True);
  FBackground.Stored := False;
  FBackground.OnClick := OnFBackgroundClick;

  { Edit }
  FMemo := TMemo.Create(Self);
  FBackground.AddObject(FMemo);
  FMemo.Align := TAlignLayout.Client;
  FMemo.Margins.Top := 8;
  FMemo.Margins.Bottom := 8;
  FMemo.Margins.Left := 8;
  FMemo.Margins.Right := 8;
  FMemo.StyledSettings := [];
  FMemo.TextSettings.Font.Size := 14;
  FMemo.TextSettings.Font.Family := 'SF Pro Display';
  FMemo.TextSettings.FontColor := TAlphaColor($FF323232);
  FMemo.SetSubComponent(True);
  FMemo.Stored := False;
  FMemo.OnKeyUp := OnKeyUpTabNext;
  FMemo.TabStop := False;
  FMemo.WordWrap := True;

  FMemo.OnEnter := OnEditEnter;
  FMemo.OnExit := OnEditExit;
  FMemo.OnApplyStyleLookup := FMemoOnApplyStyleLookup;
  FMemo.OnChangeTracking := EventOnChangeTracking;

  { Label }
  FLabel := TLabel.Create(Self);
  FMemo.AddObject(FLabel);
  FLabel.Align := TAlignLayout.Client;
  FLabel.HitTest := False;
  FLabel.StyledSettings := [];
  FLabel.TextSettings.Font.Size := 14;
  FLabel.TextSettings.Font.Family := 'SF Pro Display';
  FLabel.TextSettings.FontColor := TAlphaColor($FF323232);
  FLabel.TextSettings.VertAlign := TTextAlign.Leading;
  FLabel.SetSubComponent(True);
  FLabel.Stored := False;
  FLabel.Opacity := 0.5;

  { Initial settings }
  SetFCursor(crIBeam);
end;

destructor TLongInput.Destroy;
begin
  if Assigned(FLabel) then
    FLabel.Free;
  if Assigned(FMemo) then
    FMemo.Free;
  if Assigned(FBackground) then
    FBackground.Free;
  inherited;
end;

end.
