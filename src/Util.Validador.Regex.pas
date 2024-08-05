unit Util.Validador.Regex;

interface

uses
  variants,
  Util.Validador.Types,
  Util.Validador.Base;

type
  TValidacaoRegex = class(TValidacaoBase<String>)
  private
    FRegex: String;
  public
    constructor Create(aRegex: String);
    function Valido: Boolean; override;
    function Valida(const aValue: String): IValidacao<String>; override;
    class function New(aRegex: String): IValidacao<String>;
  end;

implementation

uses
  System.SysUtils, System.RegularExpressions;

constructor TValidacaoRegex.Create(aRegex: String);
begin
  inherited Create('Valor n�o condiz com o padr�o');
  FRegex := aRegex;
end;

class function TValidacaoRegex.New(aRegex: String): IValidacao<String>;
begin
  Result := Self.Create(aRegex);
end;

function TValidacaoRegex.Valida(const aValue: String): IValidacao<String>;
begin
  Result := Self;
  inherited Valida(aValue);
  FMensagem := Format('Valor %s condiz com o padr�o %s',[VarToStr(FValue),FRegex])
end;

function TValidacaoRegex.Valido: Boolean;
begin
  Result := TRegex.create(FRegex).IsMatch(FValue);
end;


end.
