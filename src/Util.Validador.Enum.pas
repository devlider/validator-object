unit Util.Validador.Enum;

interface

uses
  Util.Validador.Types,
  Util.Validador.Base,
  System.Generics.Collections;

type
  TEnumValues = Array of string;
  TValidacaoEnum = class(TValidacaoBase<String>)
  private
    FEnumValues: TEnumValues;
  public
    constructor Create(aEnum: TEnumValues);
    function Valido: Boolean; override;
    class function New(aEnum: TEnumValues): IValidacao<String>;
  end;

implementation

uses
  System.SysUtils, Variants;

constructor TValidacaoEnum.Create(aEnum: TEnumValues);
begin
  inherited Create(Concat('Valor informado não esta contido no enumerado(', String.Join(',', aEnum), ')'));
  FEnumValues := Copy(aEnum, Low(aEnum), Length(aEnum)); ;
end;

class function TValidacaoEnum.New(aEnum: TEnumValues): IValidacao<String>;
begin
  Result := Self.Create(aEnum);
end;

function TValidacaoEnum.Valido: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := Low(FEnumValues) to High(FEnumValues) do
  begin
    if FEnumValues[i] = FValue then
    begin
      Result := True;
      Break;
    end;
  end;
end;

end.
