unit Util.Validador.MenorQue;

interface

uses
  variants,
  Util.Validador.Types,
  Util.Validador.Base;

type
  TValidacaoMenorQue = class(TValidacaoBase<variant>)
  private
    FComparador: variant;
  public
    function Valido: Boolean; override;
    constructor Create(aComparador: variant);
    class function New(aComparador: variant): IValidacao<variant>;
  end;

  TValidacaoMenorOuIgualQue = class(TValidacaoBase<variant>)
  private
    FComparador: variant;
  public
    function Valido: Boolean; override;
    constructor Create(aComparador: variant);
    class function New(aComparador: variant): IValidacao<variant>;
  end;

implementation

uses
  System.SysUtils;

{ TValidacaoMenorOuIgualQue }

constructor TValidacaoMenorOuIgualQue.Create(aComparador: variant);
begin
  inherited Create(Format('Deve ser menor ou igual que %s', [VarToStr(aComparador)]));
  FComparador := aComparador;
end;

class function TValidacaoMenorOuIgualQue.New(aComparador: variant): IValidacao<variant>;
begin
  Result := Self.Create(aComparador);
end;

function TValidacaoMenorOuIgualQue.Valido: Boolean;
begin
  if VarIsEmpty(FValue) then
    Exit(False);

  if VarIsStr(FValue) then
    Exit(VarToStr(fValue).trim.length <= FComparador);

  Result := FValue <= FComparador;
end;

{ TValidacaoMenorQue }

constructor TValidacaoMenorQue.Create(aComparador: variant);
begin
  inherited Create(Format('Deve ser menor que %s', [VarToStr(aComparador)]));
  FComparador := aComparador;
end;

class function TValidacaoMenorQue.New(aComparador: variant): IValidacao<variant>;
begin
  Result := Self.Create(aComparador);
end;

function TValidacaoMenorQue.Valido: Boolean;
begin
  if VarIsEmpty(FValue) then
    Exit(False);

  if VarIsStr(FValue) then
    Exit(VarToStr(fValue).trim.length < FComparador);

  Result := FValue < FComparador;
end;

end.
