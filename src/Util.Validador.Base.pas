unit Util.Validador.Base;

interface

uses
  Util.Validador.Types;

type
  TValidacaoBase<T> = class(TInterfacedObject, IValidacao<T>)
  protected
    FMensagem: string;
    FPropriedade: string;
    FValue: T;
  public
    function Propriedade(const aPropriedade: string): IValidacao<T>; overload;
    function Valida(const aValue: T): IValidacao<T>; virtual;
    function Mensagem(const aMensagem: string): IValidacao<T>; overload;
    function Valido: Boolean; virtual; abstract;
    procedure VerificaErro;
    constructor Create(const aMensagem: string); virtual;
    function Mensagem: string; overload;
    function Propriedade: string; overload;
  end;

implementation

uses
  System.SysUtils, Domain.Common.Error, variants;

constructor TValidacaoBase<T>.Create(const aMensagem: string);
begin
  if Trim(aMensagem).Length = 0 then
    raise Exception.Create('Mensagem é requerida');

  FMensagem := aMensagem;
end;

function TValidacaoBase<T>.Mensagem(const aMensagem: string): IValidacao<T>;
begin
  if Trim(aMensagem) <> '' then
    FMensagem := aMensagem;
  Result := Self;
end;

function TValidacaoBase<T>.Mensagem: string;
begin
  if FMensagem = null then
    Exit('');

  Result := Trim(FMensagem);
end;

function TValidacaoBase<T>.Propriedade: string;
begin
  Result := FPropriedade;
end;

function TValidacaoBase<T>.Propriedade(const aPropriedade: string)
  : IValidacao<T>;
begin
  FPropriedade := aPropriedade;
  Result := Self;
end;

function TValidacaoBase<T>.Valida(const aValue: T): IValidacao<T>;
begin
  FValue := aValue;
  Result := Self;
end;

procedure TValidacaoBase<T>.VerificaErro;
begin
  if not Valido then
    raise TValidadorException.Create(Mensagem);
end;

end.
