unit RadioField;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, CheckField,
  FMX.Dialogs, System.Generics.Collections, FMX.Objects, FMX.Graphics,
  ColorClass;

type
  TRadioField = class(TCheckField)
  private
    { Private declarations }
    FGrupoRadioFields: String;
    procedure DeselectAllOfGroup();
  protected
    { Protected declarations }
    procedure OnCheckFieldClick(Sender: TObject); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;

    function ValidateGroup(): Boolean;
  published
    { Published declarations }
    { Additional properties }
    property GroupRadioFields: String read FGrupoRadioFields write FGrupoRadioFields;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Componentes Customizados', [TRadioField]);
end;

{ TRadioField }

procedure TRadioField.DeselectAllOfGroup;
var
  Obj: TFmxObject;
  I: Integer;
begin
  Obj := Self.Parent;
  for I := Pred(Obj.ChildrenCount) downto 0 do
  begin
    if (Obj.Children[I] is TRadioField) and (TRadioField(Obj.Children[I]).GroupRadioFields.Equals(Self.GroupRadioFields))
    then
    begin
      TRadioField(Obj.Children[I]).IsChecked := False;
      TRadioField(Obj.Children[I]).HideEffectValidation;
    end;
  end;
end;

procedure TRadioField.OnCheckFieldClick(Sender: TObject);
var
  CircleEffect: TCircle;
  Obj: TFmxObject;
  I: Integer;
begin
  FButtonLockFocus.SetFocus; { Takes the focus off other components }

  CircleEffect := TCircle.Create(Self);
  CircleEffect.HitTest := False;
  CircleEffect.Parent := FLayoutIcon;
  CircleEffect.Align := TAlignLayout.Center;
  CircleEffect.Stroke.Kind := TBrushKind.None;
  CircleEffect.Fill.Color := FCheckedIcon.Fill.Color;
  CircleEffect.SendToBack;

  CircleEffect.Height := 0;
  CircleEffect.Width := 0;
  CircleEffect.Opacity := 0.6;
  CircleEffect.AnimateFloat('Height', FCircleSelect.Height, 0.4, TAnimationType.Out, TInterpolationType.Circular);
  CircleEffect.AnimateFloat('Width', FCircleSelect.Width, 0.4, TAnimationType.Out, TInterpolationType.Circular);
  CircleEffect.AnimateFloat('Opacity', 0, 0.5);

  if not FCheckedIcon.Visible then
  begin
    if FUncheckedIcon.Fill.Color = SOLID_ERROR_COLOR then
    begin
      FText.TextSettings.FontColor := FBackupFontColor;
      FUncheckedIcon.Fill.Color := FBackupUncheckedIconColor;
    end;

    DeselectAllOfGroup();
    FCheckedIcon.Visible := True;
    FUncheckedIcon.Visible := False;
  end;

  if Assigned(FPointerOnClick) then
    FPointerOnClick(Sender);

  if Assigned(FPointerOnChange) then
    FPointerOnChange(Sender);
end;

constructor TRadioField.Create(AOwner: TComponent);
begin
  inherited;
  FUncheckedIcon.Data.Data :=
    'M12,20A8,8 0 0,1 4,12A8,8 0 0,1 12,4A8,8 0 0,1 20,12A8,8 0 0,1 12,20M12,2A10,10 0 0,0 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12A10,10 0 0,0 12,2Z';

  FCheckedIcon.Data.Data :=
    'M12,20A8,8 0 0,1 4,12A8,8 0 0,1 12,4A8,8 0 0,1 20,12A8,8 0 0,1 12,20M12,2A10,10 0 0,0 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12A10,10 0 0,0 12,2M12,7A5,5 0 0,0 7,12A5,5 0 0,0 12,17A5,5 0 0,0 17,12A5,5 0 0,0 12,7Z';
end;

function TRadioField.ValidateGroup: Boolean;
var
  Obj: TFmxObject;
  I: Integer;
  ResultGroup: Boolean;
  ListGroupRadioFields: TList<TRadioField>;
begin
  if Self.IsChecked then
    Result := True
  else
  begin
    Result := False;
    ListGroupRadioFields := TList<TRadioField>.Create;
    Result := False;
    Obj := Self.Parent;

    for I := Pred(Obj.ChildrenCount) downto 0 do
    begin
      if (Obj.Children[I] is TRadioField) and
        (TRadioField(Obj.Children[I]).GroupRadioFields.Equals(Self.GroupRadioFields)) then
      begin
        ListGroupRadioFields.Add(TRadioField(Obj.Children[I]));
        if (TRadioField(Obj.Children[I]).IsChecked) then
        begin
          Result := True;
          Break;
        end;
      end;
    end;

    if not Result then
    begin
      for I := Pred(ListGroupRadioFields.Count) downto 0 do
        ListGroupRadioFields.Items[I].ValidateIsChecked;
    end;

    FreeAndNil(ListGroupRadioFields);
  end;
end;

end.
