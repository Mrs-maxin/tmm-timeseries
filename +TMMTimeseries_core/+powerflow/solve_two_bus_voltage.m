function [voltagePu, powerResidualPu] = solve_two_bus_voltage(pPu, qPu, impedancePu)
%SOLVE_TWO_BUS_VOLTAGE Solve the high-voltage branch with a 1 + 0i p.u. slack.
% The reduced two-bus AC equations are in 01_IDEA/derivation.md, Section 2.
arguments
    pPu (:,1) double {mustBeReal, mustBeFinite}
    qPu (:,1) double {mustBeReal, mustBeFinite}
    impedancePu (1,1) double {mustBeFinite}
end

assert(numel(pPu) == numel(qPu), "TMMTimeseries:UnequalInjectionSize", ...
    "P and Q must each provide one value per operating point.");
assert(impedancePu ~= 0, "TMMTimeseries:ZeroLineImpedance", ...
    "The two-bus line impedance must be nonzero.");

zConjPower = conj(impedancePu) .* complex(pPu, qPu);
voltageImag = -imag(zConjPower);
discriminant = 1 + 4 * (real(zConjPower) - voltageImag.^2);
assert(all(discriminant >= 0), "TMMTimeseries:NoTwoBusSolution", ...
    "The two-bus AC equations have no real voltage solution for input row %d.", ...
    find(discriminant < 0, 1));

voltageReal = (1 + sqrt(discriminant)) / 2;
voltagePu = complex(voltageReal, voltageImag);
currentPu = (voltagePu - 1) / impedancePu;
recoveredPowerPu = voltagePu .* conj(currentPu);
powerResidualPu = abs(recoveredPowerPu - complex(pPu, qPu));
end
