%% EBAF field calculation
% Generates the excitation phases and amplitudes for a cylindrical
% ultrasonic transducer array and calculates the resulting acoustic field.
%
% The active configuration corresponds to a straight channel followed by
% a tilted section.
%
% Required:
%   - MATLAB R2023
%
% Author: Dmitrii Nikolaev
% University of Helsinki

clear;
close all;
clc;

%% User-defined parameters

% Acoustic parameters
frequency = 40e3;                 % [Hz]
soundSpeed = 343;                 % [m/s]
wavelength = soundSpeed / frequency;
waveNumber = 2*pi*frequency/soundSpeed;

% Array geometry
arrayDiameter = 89e-3;            % [m]
transducerDiameter = 10e-3;       % [m]

nRadialTransducers = 16;
nAxialPositions = 16;
axialSpacing = 5.075e-3 * 2;      % [m]

nTransducers = nRadialTransducers * nAxialPositions;

% Acoustic source calibration
calibration = 82.23779327 * 0.1;

% Acoustic mode
chirality = 1;                    % 0: m=0, 1: m=1, 2: m=2

% Channel trajectory
azimuthAngle = 0;                 % [deg]
lateralShift = 13e-3;             % [m]

% Number of points used to describe the acoustic channel
nTrajectoryPoints = 2000;

%% Transducer array geometry

% Parameters describing the expanding part of the array
initialDiameter = 89e-3;          % [m]
finalDiameter = 115e-3;           % [m]

% z-position at which the diameter expansion starts
expansionStartZ = 40.6e-3;        % [m]

% Number of transducers in each half of the array
nTransducersPerHalf = nTransducers / 2;

% Preallocate transducer structure
TransducersInfo = repmat( ...
    struct( ...
        'transducer', [], ...
        'x', [], ...
        'y', [], ...
        'z', [], ...
        'normal', [], ...
        'Phase', [], ...
        'Amp', []), ...
    1, nTransducers);

for transducerIndex = 1:nTransducers
    TransducersInfo(transducerIndex).transducer = transducerIndex;
end

%% First half of the array: cylindrical section

for transducerIndex = 1:nTransducersPerHalf

    angularIndex = floor((transducerIndex - 1) / ...
        (nAxialPositions / 4));

    azimuth = -2*pi/nRadialTransducers/2 * angularIndex;

    radialPosition = arrayDiameter / 2;

    x = radialPosition * cos(azimuth);
    y = radialPosition * sin(azimuth);

    axialIndex = mod(transducerIndex - 1, nAxialPositions / 4);

    z = axialIndex * axialSpacing + ...
        mod(angularIndex, 2) * axialSpacing / 2;

    TransducersInfo(transducerIndex).x = x;
    TransducersInfo(transducerIndex).y = y;
    TransducersInfo(transducerIndex).z = z;

    % Unit normal pointing toward the centre of the array
    TransducersInfo(transducerIndex).normal = ...
        [-x, -y, 0] / hypot(x, y);
end

%% Second half of the array: expanding section

channelOffset = nTransducersPerHalf;

for transducerIndex = 1:nTransducersPerHalf

    angularIndex = floor((transducerIndex - 1) / ...
        (nAxialPositions / 4));

    azimuth = -2*pi/nRadialTransducers/2 * angularIndex;

    axialIndex = mod(transducerIndex - 1, nAxialPositions / 4);

    z = axialSpacing * nAxialPositions / 4 + ...
        axialIndex * axialSpacing + ...
        mod(angularIndex, 2) * axialSpacing / 2;

    % Linear expansion of the array diameter
    arrayDiameterAtZ = initialDiameter + ...
        (z - expansionStartZ) / ...
        (3.5 * axialSpacing) * ...
        (finalDiameter - initialDiameter);

    x = arrayDiameterAtZ / 2 * cos(azimuth);
    y = arrayDiameterAtZ / 2 * sin(azimuth);

    transducerIndexGlobal = transducerIndex + channelOffset;

    TransducersInfo(transducerIndexGlobal).x = x;
    TransducersInfo(transducerIndexGlobal).y = y;
    TransducersInfo(transducerIndexGlobal).z = z;

    % Unit normal pointing toward the centre of the array
    TransducersInfo(transducerIndexGlobal).normal = ...
        [-x, -y, 0] / hypot(x, y);
end

%% Display array geometry

figure;
set(gcf, 'WindowState', 'maximized');

hold on;

for transducerIndex = 1:nTransducers

    plot3( ...
        TransducersInfo(transducerIndex).z * 1e3, ...
        TransducersInfo(transducerIndex).x * 1e3, ...
        TransducersInfo(transducerIndex).y * 1e3, ...
        '.r', ...
        'MarkerSize', 45);

end

axis equal;
xlim([-arrayDiameter/2, arrayDiameter/2] * 1.5 * 1e3);
ylim([-arrayDiameter/2, arrayDiameter/2] * 1.5 * 1e3);

xlabel('z (mm)');
ylabel('x (mm)');
zlabel('y (mm)');
title('Ultrasonic transducer array');

%% Define acoustic channel trajectory

maximumArrayZ = max([TransducersInfo.z]);

channelLength = maximumArrayZ;

% Azimuth angle of the tilted section
azimuth = deg2rad(azimuthAngle);

% Chirality determines the azimuthal mode order
modeOrder = chirality;

% Generate a trajectory consisting of:
%   1. a straight section
%   2. a tilted section

nStraightPoints = nTrajectoryPoints / 2;
nTiltedPoints = nTrajectoryPoints / 2;

% Straight section
trajectoryZ1 = linspace( ...
    0, ...
    maximumArrayZ / 2, ...
    nStraightPoints);

trajectoryX1 = zeros(1, nStraightPoints);
trajectoryY1 = zeros(1, nStraightPoints);

% Tilted section
trajectoryZ2 = linspace( ...
    maximumArrayZ / 2, ...
    channelLength / 2 + maximumArrayZ / 2, ...
    nTiltedPoints);

tiltSlope = lateralShift / (maximumArrayZ / 2);

trajectoryX2 = ...
    tiltSlope * ...
    (trajectoryZ2 - maximumArrayZ / 2) * cos(azimuth);

trajectoryY2 = ...
    tiltSlope * ...
    (trajectoryZ2 - maximumArrayZ / 2) * sin(azimuth);

% Complete trajectory
trajectoryX = [trajectoryX1, trajectoryX2];
trajectoryY = [trajectoryY1, trajectoryY2];
trajectoryZ = [trajectoryZ1, trajectoryZ2];

%% Calculate transducer excitation

% Weight applied along the trajectory
trajectoryWeight = ones(1, nTrajectoryPoints);

for transducerIndex = 1:nTransducers

    sourcePosition = [ ...
        TransducersInfo(transducerIndex).x, ...
        TransducersInfo(transducerIndex).y, ...
        TransducersInfo(transducerIndex).z];

    excitationCoefficient = 0;

    for trajectoryIndex = 2:nTrajectoryPoints-1

        % Current trajectory point
        trajectoryPoint = [ ...
            trajectoryX(trajectoryIndex), ...
            trajectoryY(trajectoryIndex), ...
            trajectoryZ(trajectoryIndex)];

        % Previous and next trajectory points
        previousPoint = [ ...
            trajectoryX(trajectoryIndex - 1), ...
            trajectoryY(trajectoryIndex - 1), ...
            trajectoryZ(trajectoryIndex - 1)];

        nextPoint = [ ...
            trajectoryX(trajectoryIndex + 1), ...
            trajectoryY(trajectoryIndex + 1), ...
            trajectoryZ(trajectoryIndex + 1)];

        % Local tangent vector
        tangent = nextPoint - previousPoint;
        tangent = tangent / norm(tangent);

        % Reference vector and local binormal
        referenceVector = [0, 1, 0];
        binormal = cross(tangent, referenceVector);

        % Distance between the source and trajectory point
        sourceToTrajectory = trajectoryPoint - sourcePosition;
        distance = norm(sourceToTrajectory);

        % Angle between the local trajectory direction and
        % the direction from the trajectory point to the source
        theta = acos( ...
            dot(tangent, sourcePosition - trajectoryPoint) / ...
            distance);

        % Spherical Hankel function
        hankelTerm = sphericalHankel1( ...
            modeOrder, ...
            -waveNumber * distance);

        % Vortex phase
        vortexAngle = angle( ...
            dot( ...
                sourceToTrajectory / distance, ...
                referenceVector + 1i * binormal));

        vortexPhase = exp(-1i * modeOrder * vortexAngle);

        % Angular factor for l = m = 1
        angularFactor = -sqrt(1 - cos(theta)^2);

        % Contribution from this trajectory point
        contribution = ...
            hankelTerm .* ...
            vortexPhase .* ...
            angularFactor .* ...
            trajectoryWeight(trajectoryIndex);

        % Account for the radial position of the transducer
        radialPosition = hypot( ...
            TransducersInfo(transducerIndex).x, ...
            TransducersInfo(transducerIndex).y);

        excitationCoefficient = ...
            excitationCoefficient + ...
            contribution * radialPosition;

    end

    % Store phase and amplitude
    TransducersInfo(transducerIndex).Phase = ...
        rad2deg(angle(excitationCoefficient));

    TransducersInfo(transducerIndex).Amp = ...
        abs(excitationCoefficient);

end

%% Normalize transducer amplitudes

maximumAmplitude = max([TransducersInfo.Amp]);

for transducerIndex = 1:nTransducers
    TransducersInfo(transducerIndex).Amp = ...
        TransducersInfo(transducerIndex).Amp / maximumAmplitude;
end

%% Calculate longitudinal acoustic field

fieldHalfWidth = 18e-3;
fieldStep = 0.5e-3;

x = -fieldHalfWidth:fieldStep:fieldHalfWidth;
y = 0;
z = -10e-3:fieldStep:maximumArrayZ + 10e-3;

pressureXZ = zeros(length(x), length(z));

for ix = 1:length(x)

    for iz = 1:length(z)

        observationPoint = [x(ix), y, z(iz)];

        % Exclude points inside the transducer aperture
        if x(ix)^2 + y^2 >= (0.95 * arrayDiameter / 2)^2
            continue;
        end

        for transducerIndex = 1:nTransducers

            sourcePosition = [ ...
                TransducersInfo(transducerIndex).x, ...
                TransducersInfo(transducerIndex).y, ...
                TransducersInfo(transducerIndex).z];

            sourceToObservation = observationPoint - sourcePosition;
            distance = norm(sourceToObservation);

            sourceNormal = TransducersInfo(transducerIndex).normal;

            theta = acos( ...
                dot(sourceNormal, sourceToObservation) / ...
                (norm(sourceNormal) * distance));

            directivityArgument = ...
                waveNumber * transducerDiameter / 2 * sin(theta);

            directivity = besselDirectivity(directivityArgument);

            phase = deg2rad( ...
                TransducersInfo(transducerIndex).Phase);

            pressureXZ(ix, iz) = ...
                pressureXZ(ix, iz) + ...
                calibration * ...
                TransducersInfo(transducerIndex).Amp * ...
                directivity / distance * ...
                exp(1i * waveNumber * distance + 1i * phase);

        end
    end
end

%% Plot longitudinal field

figure;
set(gcf, 'WindowState', 'maximized');

normalizedPressure = abs(pressureXZ);
normalizedPressure = normalizedPressure / max(normalizedPressure(:));

imagesc( ...
    x * 1e3, ...
    z * 1e3, ...
    normalizedPressure');

axis equal tight;
set(gca, 'YDir', 'normal');

xlabel('x (mm)');
ylabel('z (mm)');
title('Normalized acoustic pressure amplitude');

colormap hot;
colorbar;

%% Calculate transverse field

x = -fieldHalfWidth:fieldStep:fieldHalfWidth;
y = x;

observationZ = maximumArrayZ / 2;

pressureXY = zeros(length(x), length(y));

for ix = 1:length(x)

    for iy = 1:length(y)

        observationPoint = [x(ix), y(iy), observationZ];

        for transducerIndex = 1:nTransducers

            sourcePosition = [ ...
                TransducersInfo(transducerIndex).x, ...
                TransducersInfo(transducerIndex).y, ...
                TransducersInfo(transducerIndex).z];

            sourceToObservation = observationPoint - sourcePosition;
            distance = norm(sourceToObservation);

            % Equivalent angle used in the original calculation
            theta = asin(abs(observationZ - ...
                TransducersInfo(transducerIndex).z) / distance);

            directivityArgument = ...
                waveNumber * transducerDiameter / 2 * sin(theta);

            directivity = besselDirectivity(directivityArgument);

            phase = deg2rad( ...
                TransducersInfo(transducerIndex).Phase);

            pressureXY(ix, iy) = ...
                pressureXY(ix, iy) + ...
                calibration * ...
                TransducersInfo(transducerIndex).Amp * ...
                directivity / distance * ...
                exp(1i * waveNumber * distance + 1i * phase);

        end
    end
end

%% Plot transverse field

figure;
set(gcf, 'WindowState', 'maximized');

normalizedPressure = abs(pressureXY);
normalizedPressure = normalizedPressure / max(normalizedPressure(:));

imagesc(x * 1e3, y * 1e3, normalizedPressure');

axis equal tight;
set(gca, 'YDir', 'normal');

xlabel('x (mm)');
ylabel('y (mm)');
title('Normalized acoustic pressure amplitude');

colormap hot;
colorbar;

%% Calculate 3D acoustic field

fieldHalfWidth3D = 15e-3;
fieldStep3D = 1e-3;

x = -fieldHalfWidth3D:fieldStep3D:fieldHalfWidth3D;
y = x;
z = -10e-3:fieldStep3D:maximumArrayZ + 10e-3;

pressure3D = zeros(length(x), length(y), length(z));

for ix = 1:length(x)

    fprintf('3D field: %d / %d\n', ix, length(x));

    for iy = 1:length(y)

        for iz = 1:length(z)

            observationPoint = [x(ix), y(iy), z(iz)];

            for transducerIndex = 1:nTransducers

                sourcePosition = [ ...
                    TransducersInfo(transducerIndex).x, ...
                    TransducersInfo(transducerIndex).y, ...
                    TransducersInfo(transducerIndex).z];

                sourceToObservation = ...
                    observationPoint - sourcePosition;

                distance = norm(sourceToObservation);

                sourceNormal = ...
                    TransducersInfo(transducerIndex).normal;

                theta = acos( ...
                    dot(sourceNormal, sourceToObservation) / ...
                    (norm(sourceNormal) * distance));

                directivityArgument = ...
                    waveNumber * transducerDiameter / 2 * sin(theta);

                directivity = ...
                    besselDirectivity(directivityArgument);

                phase = deg2rad( ...
                    TransducersInfo(transducerIndex).Phase);

                pressure3D(ix, iy, iz) = ...
                    pressure3D(ix, iy, iz) + ...
                    calibration * ...
                    TransducersInfo(transducerIndex).Amp * ...
                    directivity / distance * ...
                    exp(1i * waveNumber * distance + 1i * phase);

            end
        end
    end
end

%% Visualize 3D acoustic field

volumeViewer(abs(pressure3D));

%% Acoustic radiation potential

% Medium properties
airDensity = 1.2;                 % [kg/m^3]
airSoundSpeed = 343;              % [m/s]

particleDensity = 1e3;           % [kg/m^3]
particleSoundSpeed = 1500;       % [m/s]

% Acoustic contrast factors
f1 = 1 - ...
    airDensity * airSoundSpeed^2 / ...
    (particleDensity * particleSoundSpeed^2);

f2 = 2 * (particleDensity - airDensity) / ...
    (2 * particleDensity + airDensity);

%% Calculate pressure gradients

dPressureDx = diff(pressure3D, 1, 1);
dPressureDy = diff(pressure3D, 1, 2);
dPressureDz = diff(pressure3D, 1, 3);

% Match array dimensions
dPressureDx(:, :, end) = [];
dPressureDx(:, end, :) = [];

dPressureDy(end, :, :) = [];
dPressureDy(:, :, end) = [];

dPressureDz(:, end, :) = [];
dPressureDz(end, :, :) = [];

pressure = pressure3D;
pressure(end, :, :) = [];
pressure(:, end, :) = [];
pressure(:, :, end) = [];

%% Normalize pressure for potential calculation

pressure = ...
    pressure / max(abs(pressure(:))) * 5.3e3;

%% Acoustic energy densities

potentialEnergyDensity = ...
    1 / (4 * airDensity * airSoundSpeed^2) .* ...
    pressure .* conj(pressure);

kineticEnergyDensity = ...
    1 / (4 * airDensity * (2*pi*frequency)^2) .* ...
    ( ...
        dPressureDx .* conj(dPressureDx) + ...
        dPressureDy .* conj(dPressureDy) + ...
        dPressureDz .* conj(dPressureDz) ...
    );

%% Gor'kov acoustic potential

GorkovPotential = ...
    f1 / 3 .* potentialEnergyDensity - ...
    f2 / 2 .* kineticEnergyDensity;

%% Potential at central transverse plane

xPotential = x(1:end-1);
yPotential = y(1:end-1);
zPotential = z(1:end-1);

potentialSlice = ...
    real(GorkovPotential(:, :, ceil(length(zPotential)/2)));

maximumPotential = ...
    max(abs(GorkovPotential(:)));

figure;

imagesc( ...
    xPotential * 1e3, ...
    yPotential * 1e3, ...
    potentialSlice * 1e3);

axis equal tight;
set(gca, 'YDir', 'normal');

xlabel('x (mm)');
ylabel('y (mm)');
title('Gor''kov acoustic potential');

colormap jet;
colorbar;

%% Potential in the longitudinal plane

potentialLongitudinal = ...
    squeeze(real( ...
        GorkovPotential(:, ceil(length(xPotential)/2), :) ...
    ));

figure;

imagesc( ...
    zPotential * 1e3, ...
    yPotential * 1e3, ...
    potentialLongitudinal * 1e3);

axis equal tight;
set(gca, 'YDir', 'normal');

xlabel('z (mm)');
ylabel('y (mm)');
title('Gor''kov acoustic potential');

colormap jet;
colorbar;


%% Local functions

function h = sphericalHankel1(order, x)
%SPHERICALHANKEL1 Spherical Hankel function of the first kind.
%
%   h = sphericalHankel1(order, x)
%
%   h_n^(1)(x) = sqrt(pi/(2*x)) H_(n+1/2)^(1)(x)

h = sqrt(pi ./ (2 .* x)) .* ...
    besselh(order + 0.5, 1, x);

end


function directivity = besselDirectivity(argument)
%BESSELDIRECTIVITY Circular piston directivity factor.
%
%   directivity = 2*J_1(argument)/argument
%
%   The limiting value at argument = 0 is 1.

if abs(argument) < 1e-4
    directivity = 1;
else
    directivity = 2 * besselj(1, argument) / argument;
end

end