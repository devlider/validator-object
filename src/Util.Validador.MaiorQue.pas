unit Util.Validador.MaiorQue;

interface

uses
  variants,
  Util.Validador.Types,
  Util.Validador.Base;

type
  TValidacaoMaiorQue = class(TValidacaoBase<Variant>)
  private
    FComparador: Variant;
  public
    function Valido: Boolean; override;
    constructor Create(aComparador: Variant);
    class function New(aComparador: Variant): IValidacao<Variant>;
  end;

  TValidacaoMaiorOuIgualQue = class(TValidacaoBase<Variant>)
  private
    FComparador: Variant;
  public
    function Valido: Boolean; override;
    constructor Create(aComparador: Variant);
    class function New(aComparador: Variant): IValidacao<Variant>;
  end;

implementation

uses
  System.SysUtils;

{ TValidacaoMaiorOuIgualQue }

constructor TValidacaoMaiorOuIgualQue.Create(aComparador: Variant);
begin
  inherited Create(Format('Deve ser maior ou igual que %s', [VarToStr(aComparador)]));
  FComparador := aComparador;
end;

class function TValidacaoMaiorOuIgualQue.New(aComparador: Variant): IValidacao<Variant>;
begin
  Result := Self.Create(aComparador);
end;

function TValidacaoMaiorOuIgualQue.Valido: Boolean;
begin
   if VarIsEmpty(FValue) then
    Exit(False);

  if VarIsStr(FValue) then
    Exit(FValue.Trim.length <= FComparador);

  Result := FValue >= FComparador;
end;

{ TValidacaoMaiorQue }

constructor TValidacaoMaiorQue.Create(aComparador: Variant);
begin
  inherited Create(Format('Deve ser maior que %s', [VarToStr(aComparador)]));
  FComparador := aComparador;
end;

class function TValidacaoMaiorQue.New(aComparador: Variant): IValidacao<Variant>;
begin
  Result := Self.Create(aComparador);
end;

function TValidacaoMaiorQue.Valido: Boolean;
begin
  if VarIsEmpty(FValue) then
    Exit(False);

  if VarIsStr(FValue) then
  Exit(VarToStr(fValue).trim.length >= FComparador);

  Result := FValue > FComparador;
end;
end.
