unit Util.Validador.Vazio;

interface

uses
  Util.Validador.Types,
  Util.Validador.Base;

type
  TValidacaoEstaVazio = class(TValidacaoBase<String>)
  public
    constructor Create;
    function Valido: Boolean; override;
    class function New: IValidacao<String>;
  end;

  TValidacaoNaoEstaVazio = class(TValidacaoBase<String>)
  public
    constructor Create;
    function Valido: Boolean; override;
    class function New: IValidacao<String>;
  end;

implementation

uses
  System.SysUtils;

constructor TValidacaoEstaVazio.Create;
begin
  inherited Create('Deve ser Vazio');
end;

class function TValidacaoEstaVazio.New: IValidacao<String>;
begin
  Result := Self.Create;
end;

function TValidacaoEstaVazio.Valido: Boolean;
begin
  Result := Trim(FValue).IsEmpty;
end;

{ TValidacaoNaoEstaVazio }

constructor TValidacaoNaoEstaVazio.Create;
begin
  inherited Create('Não deve ser Vazio');
end;

class function TValidacaoNaoEstaVazio.New: IValidacao<String>;
begin
  Result := Self.Create;
end;

function TValidacaoNaoEstaVazio.Valido: Boolean;
begin
  Result := not Trim(FValue).IsEmpty;
end;

end.
