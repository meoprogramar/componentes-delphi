unit SolidComboBox;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, System.Types,
  FMX.Objects, System.UITypes, FMX.Graphics, FMX.Dialogs, System.Math,
  System.Math.Vectors, FMX.Edit, FMX.Layouts, FMX.Effects, SolidInput, Card,
  FMX.StdCtrls, FMX.Ani, System.Threading, Input;

type
  TComboBoxAlign = (Top, Bottom);

  TSolidComboBox = class(TControl)
  private
    procedure OnComboBoxEnter(Sender: TObject);
    procedure OnComboBoxExit(Sender: TObject);
    procedure OnItemComboBoxClick(Sender: TObject);
    procedure ItemSelect(Index: Integer);
    procedure ShowItemSelect(Sender: TObject);
    procedure ResetItemSelect();
    function GetFItems: TStringList;
    procedure SetFItems(const Value: TStringList);
    function GetFItemIndex: Integer;
    procedure SetFItemIndex(const Value: Integer);
    function GetFComboBoxAlign: TComboBoxAlign;
    procedure SetFComboBoxAlign(const Value: TComboBoxAlign);
    function GetFTextSettings: TTextSettings;
    procedure SetFTextSettings(const Value: TTextSettings);
    function GetFComboBoxSelectedColor: TAlphaColor;
    procedure SetFComboBoxSelectedColor(const Value: TAlphaColor);
    function GetFComboBoxBackgroudColor: TBrush;
    procedure SetFComboBoxBackgroudColor(const Value: TBrush);
    function GetFCursor: TCursor;
    procedure SetFCursor(const Value: TCursor);
    function GetFOnChange: TNotifyEvent;
    function GetFOnClick: TNotifyEvent;
    function GetFOnClosePopup: TNotifyEvent;
    function GetFOnDblClick: TNotifyEvent;
    function GetFOnEnter: TNotifyEvent;
    function GetFOnExit: TNotifyEvent;
    function GetFOnMouseDown: TMouseEvent;
    function GetFOnMouseEnter: TNotifyEvent;
    function GetFOnMouseLeave: TNotifyEvent;
    function GetFOnMouseMove: TMouseMoveEvent;
    function GetFOnMouseUp: TMouseEvent;
    function GetFOnMouseWheel: TNotifyEvent;
    procedure SetFOnChange(const Value: TNotifyEvent);
    procedure SetFOnClick(const Value: TNotifyEvent);
    procedure SetFOnClosePopup(const Value: TNotifyEvent);
    procedure SetFOnDblClick(const Value: TNotifyEvent);
    procedure SetFOnEnter(const Value: TNotifyEvent);
    procedure SetFOnMouseDown(const Value: TMouseEvent);
    procedure SetFOnMouseEnter(const Value: TNotifyEvent);
    procedure SetFOnMouseLeave(const Value: TNotifyEvent);
    procedure SetFOnMouseMove(const Value: TMouseMoveEvent);
    procedure SetFOnMouseUp(const Value: TMouseEvent);
    procedure SetFOnMouseWheel(const Value: TNotifyEvent);
    procedure SetFOnExit(const Value: TNotifyEvent);
    { Private declarations }
  protected
    { Protected declarations }
    FSolidInput: TSolidInput;
    FLayoutClick: TLayout;
    FCardChoices: TCard;
    FScrollChoices: TVertScrollBox;

    FItems: TStringList;
    FItemIndex: Integer;
    FItemsChanged: Boolean;
    FItemsCount: Integer;

    FBackgroundItemSelect: TRectangle;
    FLabelItemSelect: TLabel;

    procedure Paint; override;
    procedure Resize; override;
    procedure Painting; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitializeComboBox();
    function Text(): String;
    procedure ValidateText();
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
    property Cursor: TCursor read GetFCursor write SetFCursor;
    property Items: TStringList read GetFItems write SetFItems;
    property ItemIndex: Integer read GetFItemIndex write SetFItemIndex;
    property ComboBoxAlign: TComboBoxAlign read GetFComboBoxAlign write SetFComboBoxAlign;
    property ComboBoxSelectedColor: TAlphaColor read GetFComboBoxSelectedColor write SetFComboBoxSelectedColor;
    property ComboBoxBackgroudColor: TBrush read GetFComboBoxBackgroudColor write SetFComboBoxBackgroudColor;
    property TextSettings: TTextSettings read GetFTextSettings write SetFTextSettings;

    { Events }
    property OnPainting;
    property OnPaint;
    property OnResize;

    { Mouse events }
    property OnClick: TNotifyEvent read GetFOnClick write SetFOnClick;
    property OnDblClick: TNotifyEvent read GetFOnDblClick write SetFOnDblClick;
    property OnMouseDown: TMouseEvent read GetFOnMouseDown write SetFOnMouseDown;
    property OnMouseUp: TMouseEvent read GetFOnMouseUp write SetFOnMouseUp;
    property OnMouseWheel: TNotifyEvent read GetFOnMouseWheel write SetFOnMouseWheel;
    property OnMouseMove: TMouseMoveEvent read GetFOnMouseMove write SetFOnMouseMove;
    property OnMouseEnter: TNotifyEvent read GetFOnMouseEnter write SetFOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read GetFOnMouseLeave write SetFOnMouseLeave;
    property OnEnter: TNotifyEvent read GetFOnEnter write SetFOnEnter;
    property OnExit: TNotifyEvent read GetFOnExit write SetFOnExit;
    property OnClosePopup: TNotifyEvent read GetFOnClosePopup write SetFOnClosePopup;
    property OnChange: TNotifyEvent read GetFOnChange write SetFOnChange;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Componentes Customizados', [TSolidComboBox]);
end;

{ TSolidAppleComboBox }

constructor TSolidComboBox.Create(AOwner: TComponent);
begin
  inherited;
  Self.Width := 400;
  Self.Height := 200;

  if not Assigned(FItems) then
    FItems := TStringList.Create;

  FItemsChanged := False;
  FItemsCount := 0;
  SetFItemIndex(-1);

  { SolidAppleEdit }
  FSolidInput := TSolidInput.Create(Self);
  Self.AddObject(FSolidInput);
  FSolidInput.Align := TAlignLayout.Top;
  FSolidInput.SetSubComponent(True);
  FSolidInput.Stored := False;
  FSolidInput.IconData.Data := 'M7.41,8.58L12,13.17L16.59,8.58L18,10L12,16L6,10L7.41,8.58Z';
  FSolidInput.IconPosition := Input.Right;
  FSolidInput.Caret.Color := TAlphaColor($FFFFFFFF);
  FSolidInput.OnExit := OnComboBoxExit;
  FSolidInput.ReadOnly := True;

  { LayoutClick }
  FLayoutClick := TLayout.Create(Self);
  FSolidInput.AddObject(FLayoutClick);
  FLayoutClick.Align := TAlignLayout.Client;
  FLayoutClick.SetSubComponent(True);
  FLayoutClick.Stored := False;
  FLayoutClick.HitTest := True;
  FLayoutClick.Cursor := crHandPoint;
  FLayoutClick.OnClick := OnComboBoxEnter;

  { CardChoices }
  FCardChoices := TCard.Create(Self);
  Self.AddObject(FCardChoices);
  FCardChoices.Align := TAlignLayout.Client;
  FCardChoices.SetSubComponent(True);
  FCardChoices.Stored := False;
  FCardChoices.CornerRound := 5;
  FCardChoices.ElevationOpacity := 0.1;
  FCardChoices.ElevationDistance := 7;
  FCardChoices.Visible := False;

  { ScrollChoices }
  FScrollChoices := TVertScrollBox.Create(Self);
  FCardChoices.AddObject(FScrollChoices);
  FScrollChoices.SetSubComponent(True);
  FScrollChoices.Stored := False;
  FScrollChoices.Align := TAlignLayout.Client;
  FScrollChoices.Margins.Top := 5;
  FScrollChoices.Margins.Bottom := 5;
end;

destructor TSolidComboBox.Destroy;
begin
  if Assigned(FScrollChoices) then
    FScrollChoices.Free;
  if Assigned(FCardChoices) then
    FCardChoices.Free;
  if Assigned(FLayoutClick) then
    FLayoutClick.Free;
  if Assigned(FSolidInput) then
    FSolidInput.Free;
  if Assigned(FItems) then
    FItems.Free;
  inherited;
end;

procedure TSolidComboBox.Paint;
begin
  inherited;
  InitializeComboBox();
  ItemSelect(GetFItemIndex);
end;

procedure TSolidComboBox.Painting;
begin
  inherited;
end;

procedure TSolidComboBox.Resize;
begin
  inherited;
end;

procedure TSolidComboBox.InitializeComboBox();
var
  Item: TRectangle;
  Data: TLabel;
  Animation: TColorAnimation;
begin
  if FItemsChanged or (FItemsCount <> FItems.Count) then
  begin
    TTask.Run(
      procedure
      begin
        TThread.Synchronize(TThread.CurrentThread,
          procedure
          var
            I, J: Integer;
          begin
            if not((not FItemsChanged) and (FItems.Count > FItemsCount)) then
            begin
              for J := Pred(FScrollChoices.Content.ChildrenCount) downto 0 do
              begin
                Item := TRectangle(FScrollChoices.Content.Children[J]);
                FScrollChoices.Content.RemoveObject(Item);
                Item.Visible := False;
                Item.DisposeOf;
                Item := nil;
              end;
              FItemsCount := 0;
            end;

            { Preenche os items }
            for I := FItemsCount to FItems.Count - 1 do
            begin

              Item := TRectangle.Create(Self);
              Item.Parent := FScrollChoices;
              FScrollChoices.Content.AddObject(Item);
              Item.Align := TAlignLayout.Top;
              Item.Stroke.Kind := TBrushKind.None;
              Item.Fill.Color := TAlphaColor($FFFFFFFFFF);
              Item.Cursor := crHandPoint;
              Item.Tag := I;
              Item.OnClick := OnItemComboBoxClick;
              Item.Position.Y := MaxSingle;

              Data := TLabel.Create(Self);
              Data.Parent := Item;
              Item.AddObject(Data);
              Data.Align := TAlignLayout.Client;
              Data.HitTest := False;
              Data.Margins.Left := 15;
              Data.Margins.Right := 15;
              Data.StyledSettings := [];
              Data.TextSettings := FSolidInput.TextSettings;
              Data.Text := FItems[I];

              Animation := TColorAnimation.Create(Self);
              Animation.Parent := Item;
              Item.AddObject(Animation);
              Animation.Duration := 0.1;
              Animation.PropertyName := 'Fill.Color';
              Animation.StartValue := TAlphaColor($FFFFFFFF);
              Animation.StopValue := TAlphaColor($FFF2F2F2);
              Animation.Trigger := 'IsMouseOver=true';
              Animation.TriggerInverse := 'IsMouseOver=false';
            end;
            FItemsChanged := False;
            FItemsCount := FItems.Count;
          end);
      end);
  end;
end;

procedure TSolidComboBox.OnComboBoxEnter(Sender: TObject);
begin
  FSolidInput.SetFocus;
  if not FCardChoices.Visible then
  begin
    InitializeComboBox();
    ItemSelect(GetFItemIndex);
    FCardChoices.Open(0.1);
  end
  else
    OnComboBoxExit(Sender);
end;

procedure TSolidComboBox.OnComboBoxExit(Sender: TObject);
begin
  if FCardChoices.Visible then
    FCardChoices.Close(0.1);
end;

procedure TSolidComboBox.OnItemComboBoxClick(Sender: TObject);
begin
  ItemSelect(TRectangle(Sender).Tag);
  ShowItemSelect(Sender);
  OnComboBoxExit(Sender);
end;

procedure TSolidComboBox.ItemSelect(Index: Integer);
begin
  if (Index > -1) and (Index <= FItems.Count - 1) then
  begin
    FSolidInput.Text := FItems[Index];
    SetFItemIndex(Index);
    if FScrollChoices.Content.ChildrenCount > Index then
      ShowItemSelect(FScrollChoices.Content.Children[Index]);
  end
  else
  begin
    ResetItemSelect();
    FSolidInput.Clear;
  end;
end;

procedure TSolidComboBox.ResetItemSelect();
begin
  if Assigned(FLabelItemSelect) then
  begin
    FLabelItemSelect.Visible := False;
    FLabelItemSelect := nil;
  end;
  if Assigned(FBackgroundItemSelect) then
  begin
    FBackgroundItemSelect.Visible := False;
    FBackgroundItemSelect := nil;
  end;
end;

procedure TSolidComboBox.ShowItemSelect(Sender: TObject);
begin
  ResetItemSelect();

  FBackgroundItemSelect := TRectangle.Create(Self);
  TRectangle(Sender).AddObject(FBackgroundItemSelect);
  FBackgroundItemSelect.Align := TAlignLayout.Client;
  FBackgroundItemSelect.Stroke.Kind := TBrushKind.None;
  FBackgroundItemSelect.Fill.Color := TAlphaColor($FFE4EDF8);
  FBackgroundItemSelect.Cursor := crHandPoint;
  FBackgroundItemSelect.HitTest := False;

  FLabelItemSelect := TLabel.Create(Self);
  FBackgroundItemSelect.AddObject(FLabelItemSelect);
  FLabelItemSelect.Align := TAlignLayout.Client;
  FLabelItemSelect.HitTest := False;
  FLabelItemSelect.Margins.Left := 15;
  FLabelItemSelect.Margins.Right := 15;
  FLabelItemSelect.StyledSettings := [];
  FLabelItemSelect.TextSettings := FSolidInput.TextSettings;
  FLabelItemSelect.TextSettings.FontColor := TAlphaColor($FF1867C0);
  FLabelItemSelect.HitTest := False;

  FLabelItemSelect.Text := FItems[TRectangle(Sender).Tag];
end;

function TSolidComboBox.Text: String;
begin
  Result := FSolidInput.Text;
end;

procedure TSolidComboBox.ValidateText;
begin
  FSolidInput.ValidateText();
end;

function TSolidComboBox.GetFItems: TStringList;
begin
  Result := FItems;
end;

function TSolidComboBox.GetFOnChange: TNotifyEvent;
begin
  //Result := FLayoutClick.on
end;

function TSolidComboBox.GetFOnClick: TNotifyEvent;
begin
  Result := FLayoutClick.OnClick;
end;

function TSolidComboBox.GetFOnClosePopup: TNotifyEvent;
begin
  //Result :=  PONTEIRO
end;

function TSolidComboBox.GetFOnDblClick: TNotifyEvent;
begin
  Result := FLayoutClick.OnDblClick;
end;

function TSolidComboBox.GetFOnEnter: TNotifyEvent;
begin
  Result := FSolidInput.OnEnter;
end;

function TSolidComboBox.GetFOnExit: TNotifyEvent;
begin
  Result := FSolidInput.OnExit;
end;

function TSolidComboBox.GetFOnMouseDown: TMouseEvent;
begin
  Result := FLayoutClick.OnMouseDown;
end;

function TSolidComboBox.GetFOnMouseEnter: TNotifyEvent;
begin
  Result := FLayoutClick.OnMouseEnter;
end;

function TSolidComboBox.GetFOnMouseLeave: TNotifyEvent;
begin
  Result := FLayoutClick.OnMouseLeave;
end;

function TSolidComboBox.GetFOnMouseMove: TMouseMoveEvent;
begin
  Result := FLayoutClick.OnMouseMove;
end;

function TSolidComboBox.GetFOnMouseUp: TMouseEvent;
begin
  Result := FLayoutClick.OnMouseUp;
end;

function TSolidComboBox.GetFOnMouseWheel: TNotifyEvent;
begin
  Result := FScrollChoices.OnVScrollChange;
end;

procedure TSolidComboBox.SetFItems(const Value: TStringList);
begin
  SetFItemIndex(-1);
  FItems.Clear;
  FItems.AddStrings(Value);
  FItemsChanged := True;
  FItemsCount := 0;
end;

procedure TSolidComboBox.SetFOnChange(const Value: TNotifyEvent);
begin
  //Ponteiro
end;

procedure TSolidComboBox.SetFOnClick(const Value: TNotifyEvent);
begin
  FLayoutClick.OnClick := Value;
end;

procedure TSolidComboBox.SetFOnClosePopup(const Value: TNotifyEvent);
begin
  //Ponteiro
end;

procedure TSolidComboBox.SetFOnDblClick(const Value: TNotifyEvent);
begin
  FLayoutClick.OnDblClick := Value;
end;

procedure TSolidComboBox.SetFOnEnter(const Value: TNotifyEvent);
begin
  FSolidInput.OnEnter := Value;
end;

procedure TSolidComboBox.SetFOnExit(const Value: TNotifyEvent);
begin
  FSolidInput.OnExit := Value;
end;

procedure TSolidComboBox.SetFOnMouseDown(const Value: TMouseEvent);
begin
  FLayoutClick.OnMouseDown := Value;
end;

procedure TSolidComboBox.SetFOnMouseEnter(const Value: TNotifyEvent);
begin
  FLayoutClick.OnMouseEnter := Value;
end;

procedure TSolidComboBox.SetFOnMouseLeave(const Value: TNotifyEvent);
begin
  FLayoutClick.OnMouseLeave := Value;
end;

procedure TSolidComboBox.SetFOnMouseMove(const Value: TMouseMoveEvent);
begin
  FLayoutClick.OnMouseMove := Value;
end;

procedure TSolidComboBox.SetFOnMouseUp(const Value: TMouseEvent);
begin
  FLayoutClick.OnMouseUp := Value;
end;

procedure TSolidComboBox.SetFOnMouseWheel(const Value: TNotifyEvent);
begin
  FScrollChoices.OnVScrollChange := Value;
end;

procedure TSolidComboBox.SetFComboBoxSelectedColor(const Value: TAlphaColor);
begin
  FSolidInput.SelectedColor := Value;
end;

function TSolidComboBox.GetFComboBoxSelectedColor: TAlphaColor;
begin
  Result := FSolidInput.SelectedColor;
end;

procedure TSolidComboBox.SetFCursor(const Value: TCursor);
begin
  FLayoutClick.Cursor := Value;
end;

function TSolidComboBox.GetFCursor: TCursor;
begin
  Result := FLayoutClick.Cursor;
end;

function TSolidComboBox.GetFTextSettings: TTextSettings;
begin
  Result := FSolidInput.TextSettings;
end;

procedure TSolidComboBox.SetFTextSettings(const Value: TTextSettings);
begin
  FSolidInput.TextSettings := Value;
end;

function TSolidComboBox.GetFItemIndex: Integer;
begin
  Result := FItemIndex;
end;

procedure TSolidComboBox.SetFItemIndex(const Value: Integer);
begin
  if (Value < FItems.Count) then
    FItemIndex := Value;
end;

function TSolidComboBox.GetFComboBoxAlign: TComboBoxAlign;
begin
  Result := TComboBoxAlign.Top;
  if FSolidInput.Align = TAlignLayout.Top then
    Result := TComboBoxAlign.Top
  else if FSolidInput.Align = TAlignLayout.Bottom then
    Result := TComboBoxAlign.Bottom;
end;

function TSolidComboBox.GetFComboBoxBackgroudColor: TBrush;
begin
  Result := FSolidInput.BackgroudColor;
end;

procedure TSolidComboBox.SetFComboBoxBackgroudColor(const Value: TBrush);
begin
  FSolidInput.BackgroudColor := Value;
end;

procedure TSolidComboBox.SetFComboBoxAlign(const Value: TComboBoxAlign);
begin
  if Value = TComboBoxAlign.Top then
  begin
    FSolidInput.Align := TAlignLayout.Top;
    FSolidInput.IconData.Data := 'M7.41,8.58L12,13.17L16.59,8.58L18,10L12,16L6,10L7.41,8.58Z';
    FCardChoices.ElevationDistance := 7;
  end
  else if Value = TComboBoxAlign.Bottom then
  begin
    FSolidInput.Align := TAlignLayout.Bottom;
    FSolidInput.IconData.Data := 'M7.41,15.41L12,10.83L16.59,15.41L18,14L12,8L6,14L7.41,15.41Z';
    FCardChoices.ElevationDistance := 0;
  end;
end;

end.
