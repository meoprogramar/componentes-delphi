unit TransparentComboBox;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, System.Types,
  FMX.Objects, System.UITypes, FMX.Graphics, FMX.Dialogs, System.Math,
  System.Math.Vectors, FMX.Edit, FMX.Layouts, FMX.Effects, SolidInput, Card,
  FMX.StdCtrls, FMX.Ani, System.Threading, Input, TransparentInput;

type
  TComboBoxAlign = (Top, Bottom);

  TTransparentComboBox = class(TControl)
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
    { Private declarations }
  protected
    { Protected declarations }
    FTransparentInput: TTransparentInput;
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
    // property OnClick: TNotifyEvent read GetFOnClick write SetFOnClick;
    // property OnDblClick: TNotifyEvent read GetFOnDblClick write SetFOnDblClick;
    // property OnKeyDown: TKeyEvent read GetFOnKeyDown write SetFOnKeyDown;
    // property OnKeyUp: TKeyEvent read GetFOnKeyUp write SetFOnKeyUp;
    // property OnMouseDown: TMouseEvent read GetFOnMouseDown write SetFOnMouseDown;
    // property OnMouseUp: TMouseEvent read GetFOnMouseUp write SetFOnMouseUp;
    // property OnMouseWheel: TMouseWheelEvent read GetFOnMouseWheel write SetFOnMouseWheel;
    // property OnMouseMove: TMouseMoveEvent read GetFOnMouseMove write SetFOnMouseMove;
    // property OnMouseEnter: TNotifyEvent read GetFOnMouseEnter write SetFOnMouseEnter;
    // property OnMouseLeave: TNotifyEvent read GetFOnMouseLeave write SetFOnMouseLeave;
  end;


procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Componentes Customizados', [TTransparentComboBox]);
end;

{ TSolidAppleComboBox }

constructor TTransparentComboBox.Create(AOwner: TComponent);
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
  FTransparentInput := TTransparentInput.Create(Self);
  Self.AddObject(FTransparentInput);
  FTransparentInput.Align := TAlignLayout.Top;
  FTransparentInput.SetSubComponent(True);
  FTransparentInput.Stored := False;
  FTransparentInput.IconData.Data := 'M7.41,8.58L12,13.17L16.59,8.58L18,10L12,16L6,10L7.41,8.58Z';
  FTransparentInput.IconPosition := Input.Right;
  FTransparentInput.Caret.Color := TAlphaColor($FFFFFFFF);
  FTransparentInput.OnExit := OnComboBoxExit;
  FTransparentInput.ReadOnly := True;

  { LayoutClick }
  FLayoutClick := TLayout.Create(Self);
  FTransparentInput.AddObject(FLayoutClick);
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
  FScrollChoices.Align := TAlignLayout.Client;
  FScrollChoices.Margins.Top := 5;
  FScrollChoices.Margins.Bottom := 5;
end;

destructor TTransparentComboBox.Destroy;
begin
  if Assigned(FScrollChoices) then
    FScrollChoices.Free;
  if Assigned(FCardChoices) then
    FCardChoices.Free;
  if Assigned(FLayoutClick) then
    FLayoutClick.Free;
  if Assigned(FTransparentInput) then
    FTransparentInput.Free;
  if Assigned(FItems) then
    FItems.Free;
  inherited;
end;

procedure TTransparentComboBox.Paint;
begin
  inherited;
  InitializeComboBox();
  ItemSelect(GetFItemIndex);
end;

procedure TTransparentComboBox.Painting;
begin
  inherited;
end;

procedure TTransparentComboBox.Resize;
begin
  inherited;
end;

procedure TTransparentComboBox.InitializeComboBox();
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
              Data.TextSettings := FTransparentInput.TextSettings;
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

procedure TTransparentComboBox.OnComboBoxEnter(Sender: TObject);
begin
  FTransparentInput.SetFocus;
  if not FCardChoices.Visible then
  begin
    InitializeComboBox();
    ItemSelect(GetFItemIndex);
    FCardChoices.Open(0.1);
  end
  else
    OnComboBoxExit(Sender);
end;

procedure TTransparentComboBox.OnComboBoxExit(Sender: TObject);
begin
  if FCardChoices.Visible then
    FCardChoices.Close(0.1);
end;

procedure TTransparentComboBox.OnItemComboBoxClick(Sender: TObject);
begin
  ItemSelect(TRectangle(Sender).Tag);
  ShowItemSelect(Sender);
  OnComboBoxExit(Sender);
end;

procedure TTransparentComboBox.ItemSelect(Index: Integer);
begin
  if (Index > -1) and (Index <= FItems.Count - 1) then
  begin
    FTransparentInput.Text := FItems[Index];
    SetFItemIndex(Index);
    if FScrollChoices.Content.ChildrenCount > Index then
      ShowItemSelect(FScrollChoices.Content.Children[Index]);
  end
  else
  begin
    ResetItemSelect();
    FTransparentInput.Clear;
  end;
end;

procedure TTransparentComboBox.ResetItemSelect();
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

procedure TTransparentComboBox.ShowItemSelect(Sender: TObject);
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
  FLabelItemSelect.TextSettings := FTransparentInput.TextSettings;
  FLabelItemSelect.TextSettings.FontColor := TAlphaColor($FF1867C0);
  FLabelItemSelect.HitTest := False;

  FLabelItemSelect.Text := FItems[TRectangle(Sender).Tag];
end;

procedure TTransparentComboBox.ValidateText;
begin
  FTransparentInput.ValidateText();
end;

function TTransparentComboBox.GetFItems: TStringList;
begin
  Result := FItems;
end;

procedure TTransparentComboBox.SetFItems(const Value: TStringList);
begin
  SetFItemIndex(-1);
  FItems.Clear;
  FItems.AddStrings(Value);
  FItemsChanged := True;
  FItemsCount := 0;
end;

procedure TTransparentComboBox.SetFComboBoxSelectedColor(const Value: TAlphaColor);
begin
  FTransparentInput.SelectedColor := Value;
end;

function TTransparentComboBox.GetFComboBoxSelectedColor: TAlphaColor;
begin
  Result := FTransparentInput.SelectedColor;
end;

procedure TTransparentComboBox.SetFCursor(const Value: TCursor);
begin
  FLayoutClick.Cursor := Value;
end;

function TTransparentComboBox.GetFCursor: TCursor;
begin
  Result := FLayoutClick.Cursor;
end;

function TTransparentComboBox.GetFTextSettings: TTextSettings;
begin
  Result := FTransparentInput.TextSettings;
end;

procedure TTransparentComboBox.SetFTextSettings(const Value: TTextSettings);
begin
  FTransparentInput.TextSettings := Value;
end;

function TTransparentComboBox.GetFItemIndex: Integer;
begin
  Result := FItemIndex;
end;

procedure TTransparentComboBox.SetFItemIndex(const Value: Integer);
begin
  if (Value < FItems.Count) then
    FItemIndex := Value;
end;

function TTransparentComboBox.GetFComboBoxAlign: TComboBoxAlign;
begin
  Result := TComboBoxAlign.Top;
  if FTransparentInput.Align = TAlignLayout.Top then
    Result := TComboBoxAlign.Top
  else if FTransparentInput.Align = TAlignLayout.Bottom then
    Result := TComboBoxAlign.Bottom;
end;

function TTransparentComboBox.GetFComboBoxBackgroudColor: TBrush;
begin
  Result := FTransparentInput.BackgroudColor;
end;

procedure TTransparentComboBox.SetFComboBoxBackgroudColor(const Value: TBrush);
begin
  FTransparentInput.BackgroudColor := Value;
end;

procedure TTransparentComboBox.SetFComboBoxAlign(const Value: TComboBoxAlign);
begin
  if Value = TComboBoxAlign.Top then
  begin
    FTransparentInput.Align := TAlignLayout.Top;
    FTransparentInput.IconData.Data := 'M7.41,8.58L12,13.17L16.59,8.58L18,10L12,16L6,10L7.41,8.58Z';
    FCardChoices.ElevationDistance := 7;
  end
  else if Value = TComboBoxAlign.Bottom then
  begin
    FTransparentInput.Align := TAlignLayout.Bottom;
    FTransparentInput.IconData.Data := 'M7.41,15.41L12,10.83L16.59,15.41L18,14L12,8L6,14L7.41,15.41Z';
    FCardChoices.ElevationDistance := 0;
  end;
end;

end.
