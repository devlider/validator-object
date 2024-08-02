unit Util.Validador.MaiorQue;

interface

uses
  Util.Validador.Types,
  Util.Validador.Base;

type
  TValidacaoMaiorQue = class(TValidacaoBase<Real>)
  private
    FComparador: Real;
  public
    function Valido: Boolean; override;
    constructor Create(aComparador: Real);
    class function New(aComparador: Real): IValidacao<Real>;
  end;

  TValidacaoMaiorOuIgualQue = class(TValidacaoBase<Real>)
  private
    FComparador: Real;
  public
    function Valido: Boolean; override;
    constructor Create(aComparador: Real);
    class function New(aComparador: Real): IValidacao<Real>;
  end;

implementation

uses
  System.SysUtils;

{ TValidacaoMaiorOuIgualQue }

constructor TValidacaoMaiorOuIgualQue.Create(aComparador: Real);
begin
  inherited Create(Format('Deve ser maior ou igual que %g', [aComparador]));
  FComparador := aComparador;
end;

class function TValidacaoMaiorOuIgualQue.New(aComparador: Real): IValidacao<Real>;
begin
  Result := Self.Create(aComparador);
end;

function TValidacaoMaiorOuIgualQue.Valido: Boolean;
begin
  Result := FValue >= FComparador;
end;

{ TValidacaoMaiorQue }

constructor TValidacaoMaiorQue.Create(aComparador: Real);
begin
  inherited Create(Format('Deve ser maior que %g', [aComparador]));
  FComparador := aComparador;
end;

class function TValidacaoMaiorQue.New(aComparador: Real): IValidacao<Real>;
begin
  Result := Self.Create(aComparador);
end;

function TValidacaoMaiorQue.Valido: Boolean;
begin
  Result := FValue > FComparador;
end;

end.
