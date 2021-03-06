unit ColorClass;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, System.Types,
  FMX.Objects, FMX.StdCtrls, System.UITypes, FMX.Graphics, FMX.Dialogs, System.Math,
  System.Math.Vectors, FMX.Edit, FMX.Layouts, FMX.Effects;

const
  SOLID_PRIMARY_COLOR: TAlphaColor = ($FF1867C0);
  SOLID_ERROR_COLOR: TAlphaColor = ($FFFF5252);
  SOLID_NORMAL_COLOR: TAlphaColor = ($FFF5F5F5);
  SOLID_SECONDARY_COLOR: TAlphaColor = ($FF5CBBF6);
  SOLID_WARNING_COLOR: TAlphaColor = ($FFFB8C00);
  SOLID_SUCCESS_COLOR: TAlphaColor = ($FF4CAF50);

  TRANSPARENT_PRIMARY_COLOR: TAlphaColor = ($1E1867C0);
  TRANSPARENT_ERROR_COLOR: TAlphaColor = ($1EFF5252);
  TRANSPARENT_NORMAL_COLOR: TAlphaColor = ($1E323232);
  TRANSPARENT_SECONDARY_COLOR: TAlphaColor = ($1E5CBBF6);
  TRANSPARENT_WARNING_COLOR: TAlphaColor = ($1EFB8C00);
  TRANSPARENT_SUCCESS_COLOR: TAlphaColor = ($1E4CAF50);

  SOLID_BLACK : TAlphaColor = ($FF323232);
  SOLID_WHITE : TAlphaColor = ($FFFFFFFF);

  TRANSPARENT_BLACK : TAlphaColor = ($1E323232);
  TRANSPARENT_WHITE : TAlphaColor = ($1EFFFFFF);

type
  TColorClass = (Primary, Error, Normal, Secondary, Warning, Success, Custom);

implementation

end.
