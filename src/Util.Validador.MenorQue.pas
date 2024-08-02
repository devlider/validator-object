unit Util.Validador.MenorQue;

interface

uses
  Util.Validador.Types,
  Util.Validador.Base;

type
  TValidacaoMenorQue = class(TValidacaoBase<Real>)
  private
    FComparador: Real;
  public
    function Valido: Boolean; override;
    constructor Create(aComparador: Real);
    class function New(aComparador: Real): IValidacao<Real>;
  end;

  TValidacaoMenorOuIgualQue = class(TValidacaoBase<Real>)
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

{ TValidacaoMenorOuIgualQue }

constructor TValidacaoMenorOuIgualQue.Create(aComparador: Real);
begin
  inherited Create(Format('Deve ser menor ou igual que %g', [aComparador]));
  FComparador := aComparador;
end;

class function TValidacaoMenorOuIgualQue.New(aComparador: Real): IValidacao<Real>;
begin
  Result := Self.Create(aComparador);
end;

function TValidacaoMenorOuIgualQue.Valido: Boolean;
begin
  Result := FValue <= FComparador;
end;

{ TValidacaoMenorQue }

constructor TValidacaoMenorQue.Create(aComparador: Real);
begin
  inherited Create(Format('Deve ser menor que %g', [aComparador]));
  FComparador := aComparador;
end;

class function TValidacaoMenorQue.New(aComparador: Real): IValidacao<Real>;
begin
  Result := Self.Create(aComparador);
end;

function TValidacaoMenorQue.Valido: Boolean;
begin
  Result := FValue < FComparador;
end;

end.
