unit Util.Validador;

interface

uses
  variants,
  Util.Validador.Enum,
  Util.Validador.Types,
  System.Generics.Collections;

type
  IValidadorAdd = interface;

  IValidador = interface
    ['{07439CC1-095B-4F4B-9B1F-6B6324E3AF78}']
    function Requerido(aMensagem : string = ''): IValidador;
    function Vazio: IValidador;
    function NaoVazio: IValidador;
    function Enum(aEnum: TEnumValues): IValidador;

    function MaiorQue(aComparacao: Real; aMensagem : string = ''): IValidador;
    function MaiorQueOuIgual(aComparacao: Real; aMensagem : string = ''): IValidador;

    function MenorQue(aComparacao: Real; aMensagem : string = ''): IValidador;
    function MenorQueOuIgual(aComparacao: Real; aMensagem : string = ''): IValidador;

    function Igual(aComparacao: Variant; aMensagem : string = ''): IValidador;

    function &End: IValidadorAdd;
  end;


  IValidadorAdd = interface
    ['{07439CC1-095B-4F4B-9B1F-6B6324E3AF78}']
    function Personalizada(aValidacao: IValidacaoBase): IValidadorAdd;
    function Add(aPropriedede: string; aValue: variant): IValidador;
    function Executa: IExecutorValidador;
  end;

  TValidador = class(TInterfacedObject, IValidador, IValidadorAdd)
  private
    FValidador: IExecutorValidador;
    FValue: variant;
    FPropriedede: string;
  public
    function Add(aPropriedede: string; aValue: variant): IValidador;
    function Executa: IExecutorValidador;

    function Requerido(aMensagem : string = ''): IValidador;
    function Vazio: IValidador;
    function NaoVazio: IValidador;
    function Enum(aEnum: TEnumValues): IValidador;

    function MaiorQue(aComparacao: Real; aMensagem : string = ''): IValidador;
    function MaiorQueOuIgual(aComparacao: Real; aMensagem : string = ''): IValidador;

    function MenorQue(aComparacao: Real; aMensagem : string = ''): IValidador;
    function MenorQueOuIgual(aComparacao: Real; aMensagem : string = ''): IValidador;

    function Personalizada(aValidacao: IValidacaoBase): IValidadorAdd;

    function Igual(aComparacao: Variant; aMensagem : string = ''): IValidador;

    function &End: IValidadorAdd;

    constructor Create;
    class function New: IValidadorAdd;
  end;

implementation

uses
  Util.Validador.Igual,
  Util.Validador.Requerido,
  Util.Validador.Vazio,
  Util.Validador.MaiorQue,
  Util.Validador.MenorQue;


function TValidador.Add(aPropriedede: string; aValue: variant): IValidador;
begin
  FValue := aValue;
  FPropriedede := aPropriedede;
  Result := Self;
end;

function TValidador.&End: IValidadorAdd;
begin
  FValue := null;
  FPropriedede := '';
  Result := Self;
end;

function TValidador.Enum(aEnum: TEnumValues): IValidador;
begin
  FValidador.Add(TValidacaoEnum.New(aEnum).Valida(FValue).Propriedade(FPropriedede));
  Result := Self;
end;

constructor TValidador.Create;
begin
  FValidador := TExecutorValidador.New;
end;

function TValidador.Executa: IExecutorValidador;
begin
  Result := FValidador;
end;

function TValidador.Igual(aComparacao: Variant; aMensagem: string): IValidador;
begin
  FValidador.Add(TValidacaoIgual.New(aComparacao).Valida(FValue).Propriedade(FPropriedede).Mensagem(aMensagem));
  Result := Self;
end;

function TValidador.MaiorQue(aComparacao: Real; aMensagem : string = ''): IValidador;
begin
  FValidador.Add(TValidacaoMaiorQue.New(aComparacao).Valida(FValue).Propriedade(FPropriedede).Mensagem(aMensagem));
  Result := Self;
end;

function TValidador.MaiorQueOuIgual(aComparacao: Real; aMensagem : string = ''): IValidador;
begin
  FValidador.Add(TValidacaoMaiorOuIgualQue.New(aComparacao).Valida(FValue).Propriedade(FPropriedede).Mensagem(aMensagem));
  Result := Self;
end;

function TValidador.MenorQue(aComparacao: Real; aMensagem : string): IValidador;
begin
  FValidador.Add(TValidacaoMenorQue.New(aComparacao).Valida(FValue).Propriedade(FPropriedede).Mensagem(aMensagem));
  Result := Self;
end;

function TValidador.MenorQueOuIgual(aComparacao: Real; aMensagem : string = ''): IValidador;
begin
  FValidador.Add(TValidacaoMenorOuIgualQue.New(aComparacao).Valida(FValue).Propriedade(FPropriedede).Mensagem(aMensagem));
  Result := Self;
end;

function TValidador.NaoVazio: IValidador;
begin
  FValidador.Add(TValidacaoNaoEstaVazio.New.Valida(FValue).Propriedade(FPropriedede));
  Result := Self;
end;

class function TValidador.New: IValidadorAdd;
begin
  Result := Self.Create;
end;

function TValidador.Personalizada(aValidacao: IValidacaoBase): IValidadorAdd;
begin
  FValidador.Add(aValidacao);
  Result := Self;
end;

function TValidador.Requerido(aMensagem : string = ''): IValidador;
begin
  FValidador.Add(TValidacaoRequerido.New.Valida(FValue).Propriedade(FPropriedede).Mensagem(aMensagem));
  Result := Self;
end;

function TValidador.Vazio: IValidador;
begin
  FValidador.Add(TValidacaoEstaVazio.New.Valida(FValue).Propriedade(FPropriedede));
  Result := Self;
end;

end.
