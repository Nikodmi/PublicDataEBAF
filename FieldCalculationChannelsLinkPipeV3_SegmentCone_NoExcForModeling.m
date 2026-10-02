close all
clear all
addpath('C:\Users\nikodmi\OneDrive - University of Helsinki\Work\ETLA\Force tube\TubeVortex\MFiles\MFiles')
% SpiralPoint=15;
% Shift=2+SpiralPoint*0.25; %in mm
% polAngle=(SpiralPoint-1)*20;

polAngle=0;
ipolAngle=1;
pollAngle=polAngle(ipolAngle);

Shift=8;
phasePi=0;
PhaseAlongChannel=phasePi*pi;

hirality=1;
f0=40e3;

ifocus=32;

% fnm=['PipeV3_H' num2str(hirality) '_' num2str(f0) 'Hz_FocusPoint' num2str(ifocus) '_Petal'];
%fnm=['PipeV3_H' num2str(hirality) '_' num2str(f0) 'Hz_Straight' num2str(ifocus) '_Focused'];


Calibr=82.23779327*0.1;%Single emitter radiation
% Shift=10; %in mm
% polAngle=90;



% %letter E, 16 points
% dxy=2.5;%in mm
% iPoint=12;
% Coordinates=-[2 3; 1 3; 0 3; -1 3; -1 2; -1 1; -1 0; 0 0; 1 0; 2 0; -1 -1; -1 -2; -1 -3; 0 -3; 1 -3; 2 -3];
% Shift=sqrt(Coordinates(iPoint,1)^2+Coordinates(iPoint,2)^2)*dxy;
% polAngle=atan2(Coordinates(iPoint,2),Coordinates(iPoint,1))/pi*180;



% %Points
% iPoint=9;
% dxy=8;%in mm
% 
% Coordinates=[0 0; 0 -1; 1 -1; 1 0; 1 1; 0 1; -1 1; -1 0; -1 -1; -1 -2; 0 -2; 1 -2; 2 -2; 2 -1; 2 0; 2 1; 2 2; 1 2; 0 2;-1 2; -2 2; -2 1; -2 0; -2 -1; -2 -2];
% Shift=sqrt(Coordinates(iPoint,1)^2+Coordinates(iPoint,2)^2)*dxy;
% polAngle=atan2(Coordinates(iPoint,2),Coordinates(iPoint,1))/pi*180+22.5;

RingStart=1;
RingEnd=16;

fnm=['CylinderCylinder_H' num2str(hirality) '_' num2str(f0) 'Hz_Shift' num2str(Shift,'%.1f') '_Vortex'];
% fnm=['PipeV3_H' num2str(hirality) '_' num2str(f0) 'Hz_Angle' num2str(polAngle) 'deg_SegmentCone_HalfParabola_OnlyCurvedPart_HalfPipe'];
% fnm=['PipeV3_H' num2str(hirality) '_' num2str(f0) 'Hz_ SegmentCone_Focused_HalfPipe'];
% fnm=['PipeV3_H' num2str(hirality) '_' num2str(f0) 'Hz_Spiral_' num2str(SpiralPoint) '_SegmentCone_Parabola_OnlyCurvedPart_HalfPipe'];
% fnm=['PipeV3_H' num2str(hirality) '_' num2str(f0) 'Hz_Points_' num2str(Points) '_SegmentCone_Parabola_OnlyCurvedPart_HalfPipe_Petal_PhaseChange' num2str(phasePi) 'PI'];
% fnm=['PipeV3_' num2str(f0) 'Hz_Shift' num2str(Shift,'%.1f') 'SegmentCone_LineParabola_AllField1'];
% fnm=['Test'];

% fnm=['PipeV3_H' num2str(hirality) '_' num2str(f0) 'Hz_Shift' num2str(Shift,'%.1f') '_Angle' num2str(polAngle,'%.1f') 'Cone_MergingLines12_Focused'];

% fnm=['PipeV3_H' num2str(hirality) '_' num2str(f0) 'Hz_Shift' num2str(Shift,'%.1f') '_Angle' num2str(polAngle,'%.1f') 'SegmentCone_LineParabola_AllPipePetal' num2str(iPoint,'%.1f') ];

% fnm=['PipeV3_H' num2str(hirality) '_' num2str(f0) 'Hz_Cone_Parabola_HalfPipePoints_Focused' num2str(iPoint)];


% fnm=['PipeV3_Channel1'];
% fnm=['Pipe_H' num2str(hirality) '_' num2str(-hirality) num2str(f0) 'Hz'];

% fnm=['PipeV3_H' num2str(hirality) '_' num2str(f0) 'Hz_Shift' num2str(Shift) 'Line_SegmentCone_Line_Parabola_OnlyCurvedPart_HalfPipe_Rings' num2str(RingStart) '_' num2str(RingEnd)];
% fnm=['PipeV3_H' num2str(hirality) '_' num2str(f0) 'HzFocused_SegmentCone'];
c=343;
k0=2*pi*f0/c;
lambda=c/f0;
D=89e-3;
d=10e-3;
% d=1e-3;

Nrtr=16;

dh=5.075e-3*2;
NzTr=16;

% dh=4.3e-3*2;
% NzTr=18;

Ntr=NzTr*Nrtr;
Nch=Ntr;

TransducersInfo={};

for itr=1:Nch
    TransducersInfo(end+1).transducer=itr;

end
% Ranging
[~,index] = sortrows([TransducersInfo.transducer].'); 
TransducersInfo = TransducersInfo(index(1:end)); 
clear index
%% Coordinates,Field calculation

% kz=repmat(0,1,10);
% kz=repmat(0.05,1,10);%kz=0.05,0.1,0.15


% kz=[0.15 0.15 0.15 0.15 0.15 0 0 0 0 0];
% kz=[0.1 0.1 0.1 0.1 0.1 -0.1 -0.1 -0.1 -0.1 -0.1];
% kz=[0.3 0.2 0.15 0.1 0 0 -0.1 -0.15 -0.2 -0.3];

% Shift=repmat(0,1,10);
% Shift=linspace(-1,1,10);
% Shift=linspace(-0.5,0.5,10);
% Shift=linspace(-0.25,0.25,10);
% Shift=linspace(-0.1,0.1,10);

% Focusing=repmat(0,1,10);
% Foc=D/6;
% Foc=D/4;
% Foc=D/2;
% Foc=D;
% Foc=D/2;
% Foc=1*D;
% Foc=D*6;
% Focusing=sqrt(Foc^2+(linspace(-4.5,4.5,10)*dh).^2);
% Focusing=Focusing-sqrt(D^2/4+(linspace(-4.5,4.5,10)*dh).^2);
% Focusing=-Focusing;

% X0=0;
% Y0=0;
% sectors=6;
Xcalibr=0;
Ycalibr=0;
Zcalibr=dh*15/2/2;
for itr=1:Ntr/2        
    polangl=-2*pi/Nrtr/2*floor((itr-1)/(NzTr/4));
    x=D/2*cos(polangl);
    y=D/2*sin(polangl);
    z=mod(itr-1,NzTr/4)*dh+mod(floor((itr-1)/(NzTr/4)),2)*dh/2;

    TransducersInfo(itr).x=x;
    TransducersInfo(itr).y=y;
    TransducersInfo(itr).z=z;
    TransducersInfo(itr).n=[-x -y 0]/sqrt(x^2+y^2);

    % Phase=pi/2*(-1)^floor(polangl/pi*hirality);
    Phase=hirality*polangl;
    % Phase=hirality*polangl+k0/2*z;


    % TransducersInfo(itr).Phase=angle(exp(1i*Phase))/pi*180;
    % TransducersInfo(itr).Amp=1;

%     TransducersInfo(itr).Amp=1+0.25*exp(-((z-2/5*dh/2*15)/(dh/2*15)*9).^2);%Peristaltic amplitude

    % TransducersInfo(itr).Amp=mod(z/dh*2,2);
    % if TransducersInfo(itr).z>0*dh/2-1e-3 & TransducersInfo(itr).z<=0*dh/2+1e-3
    %     TransducersInfo(itr).Amp=1;
    % end

% 
% if abs((TransducersInfo(itr).z/dh)-round(TransducersInfo(itr).z/dh))<dh/10
%     TransducersInfo(itr).Amp=1;
% else
%     TransducersInfo(itr).Amp=0.6;
% end
% if abs((TransducersInfo(itr).z/dh)-round(TransducersInfo(itr).z/dh))<dh/10
%     TransducersInfo(itr).Amp=1;
% else
%     TransducersInfo(itr).Amp=0;
% end
% if TransducersInfo(itr).z>dh+dh/10
%     TransducersInfo(itr).Amp=1;
% else
%     TransducersInfo(itr).Amp=0;
% end

end


ChanShift=Ntr/2;
for itr=1:Ntr/2  
    polangl=-2*pi/Nrtr/2*floor((itr-1)/(NzTr/4));
    z=dh*NzTr/4+mod(itr-1,NzTr/4)*dh+mod(floor((itr-1)/(NzTr/4)),2)*dh/2;
    D2=D+(z-0.0406)/3.5/dh*(115e-3-89e-3);
    % D2=D;
    x=D2/2*cos(polangl);
    y=D2/2*sin(polangl);

    TransducersInfo(itr+ChanShift).x=x;
    TransducersInfo(itr+ChanShift).y=y;
    TransducersInfo(itr+ChanShift).z=z;
    TransducersInfo(itr+ChanShift).n=[-x -y 0]/sqrt(x^2+y^2);

    % Phase=pi/2*(-1)^floor(polangl/pi*hirality);

    Phase=hirality*polangl;
    % Phase=hirality*polangl+k0/2*z;

    % TransducersInfo(itr+ChanShift).Phase=angle(exp(1i*Phase))/pi*180;
    % TransducersInfo(itr+ChanShift).Amp=mod(z/dh*2,2);
%     TransducersInfo(itr+ChanShift).Amp=1+0.25*exp(-((z-2/5*dh/2*15)/(dh/2*15)*9).^2);%Peristaltic amplitude

    % TransducersInfo(itr+ChanShift).Amp=1;

% if TransducersInfo(itr+NChanShift).z<=5*dh/2+1e-3
%     TransducersInfo(itr+ChanShift).Amp=1;
% end
% if abs((TransducersInfo(itr+ChanShift).z/dh)-round(TransducersInfo(itr+ChanShift).z/dh))<dh/10
%     TransducersInfo(itr+ChanShift).Amp=1;
% else
%     TransducersInfo(itr+ChanShift).Amp=0.6;
% end

% if abs((TransducersInfo(itrChanShift).z/dh)-round(TransducersInfo(itr+ChanShift).z/dh))<dh/10
%     TransducersInfo(itr+ChanShift).Amp=1;
% else
%     TransducersInfo(itr+ChanShift).Amp=0;
% end
% if TransducersInfo(itr+ChanShift).z<4*dh+dh/10
%     TransducersInfo(itr+ChanShift).Amp=1;
% else
%     TransducersInfo(itr+ChanShift).Amp=0;
% end
end

figure
set(gcf, 'Position', get(0, 'Screensize'));
c = hsv
colormap('hsv')
for itr=1:Nch
plot3(TransducersInfo(itr).z*1e3,TransducersInfo(itr).x*1e3,TransducersInfo(itr).y*1e3,'.r','Markersize', 45)
axis equal 
hold on
xlim([-D/2 D/2]*1.5*1e3)
ylim([-D/2 D/2]*1.5*1e3)
% zlim([0 58e-3]*1e3)
xlabel('x, mm')
ylabel('y, mm')
zlabel('z, mm')
end
colorbar('Ticks',[0,1],'Ticklabels',{'-\pi', '\pi'})


%% Phase, amplitude calculation
Ncurve=2e3;
Ladd=0e-2;
L=max([TransducersInfo(:).z])+Ladd;
% L=1e-3;
l=hirality;
m=hirality;
c30=assocLegendre(l,m);

% Rmx=zeros(1,Ncurve);
CurvAmpl=Shift*1e-3*L/2/(L-Ladd)*2;


FocusPosition=(ifocus-1)/31*max([TransducersInfo(:).z]);

% AmplPeriod=82e-3/8;
% Amplmodul=0.25;
% VortexAmpl=1+0*exp(-(((1:Ncurve)-Ncurve*(Ladd/2)/(L)-2*Ncurve/5*(L-Ladd)/L)/Ncurve*75).^2);
VortexAmpl=1*ones(1,Ncurve);
% VortexAmpl=exp(-1i*2*2*pi*(1:Ncurve)/Ncurve);
% VortexAmpl=1-0.75*(1:Ncurve)/Ncurve;

% VortexAmpl=[ones(1,round(Ncurve/3))*exp(1i*2*pi/4) ones(1,round(Ncurve/3))*exp(1i*0) ones(1,round(Ncurve/3))*exp(1i*2*pi/8)];


% VortexAmpl=[VortexAmpl 1*ones(1,Ncurve/2)];
% figure
% plot(VortexAmpl)
% VortexAmpl=1+1*(exp(-(((1:Ncurve)-Ncurve/4)/Ncurve*20).^2)+exp(-(((1:Ncurve)-Ncurve/2)/Ncurve*20).^2)+exp(-(((1:Ncurve)-3*Ncurve/4)/Ncurve*20).^2));
% VortexAmpl=1-Amplmodul*cos(2*pi*(1:Ncurve)/Ncurve*L/AmplPeriod-2*pi*Ncurve/Ncurve/2*L/AmplPeriod);
% VortexAmpl=VortexAmpl>=1.4999;

% LateralShift=Shift*1e-3;
% fnm=['PipeV3_H' num2str(hirality) '_' num2str(f0) 'Hz_Shift' num2str(LateralShift*1e3,'%.1f') '_Angle' num2str(polAngle,'%.1f') 'Cone_MergingLines_Vortex'];

for iCurvAmpl=1:length(CurvAmpl)
    iCurvAmpl
% Rmx=[zeros(1,Ncurve/4) ones(1,Ncurve/4)*10e-3 -ones(1,Ncurve/4)*10e-3 -ones(1,Ncurve/4)*5e-3];
% Rmx=zeros(1,Ncurve);
% Rmx=[-lambda*ones(1,Ncurve/2) lambda*ones(1,Ncurve/2)];
% %%%Curved vortex
% Rmz=linspace((max([TransducersInfo(:).z])-L)/2,L+(max([TransducersInfo(:).z])-L)/2,Ncurve);
% Rmx=linspace(0,0,Ncurve/2);
% Rmy=linspace(0,0,Ncurve/2);
% 
% p=Shift*1e-3/(max([TransducersInfo(:).z])/2)^2;
% 
% Rmx=[Rmx p*(Rmz(length(Rmz)/2+1:end)-Rmz(length(Rmz)/2+1)).^2*cos(polAngle/180*pi)];
% Rmy=[Rmy p*(Rmz(length(Rmz)/2+1:end)-Rmz(length(Rmz)/2+1)).^2*sin(polAngle/180*pi)];

% %%%Curved vortex parabola half pipe
% Rmz=linspace((max([TransducersInfo(:).z]))/2,L+(max([TransducersInfo(:).z])-L)/2,Ncurve/2);
% 
% p=Shift*1e-3/(max([TransducersInfo(:).z])/2)^2;
% 
% Rmx=p*(Rmz-(max([TransducersInfo(:).z]))/2).^2*cos(polAngle/180*pi);
% Rmy=p*(Rmz-(max([TransducersInfo(:).z]))/2).^2*sin(polAngle/180*pi);

% % %%%Curved vortex inverted parabola
% Rmz=linspace((max([TransducersInfo(:).z]))/2,L+(max([TransducersInfo(:).z])-L)/2,Ncurve/2);
% 
% p=Shift*1e-3/(max([TransducersInfo(:).z])/2)^2;
% 
% Rmx=p*(Rmz-(max([TransducersInfo(:).z]))/2).^2*cos(polAngle/180*pi)-Shift*1e-3;
% Rmy=p*(Rmz-(max([TransducersInfo(:).z]))/2).^2*sin(polAngle/180*pi);
% Rmx=-Rmx;
% Rmz=Rmz(end:-1:1);

% %%%Curved vortex line
% Rmz=linspace((max([TransducersInfo(:).z]))/2,L+(max([TransducersInfo(:).z])-L)/2,Ncurve/2);
% 
% p=Shift*1e-3/(max([TransducersInfo(:).z])/2);
% 
% Rmx=p*(Rmz-(max([TransducersInfo(:).z]))/2)*cos(polAngle/180*pi);
% Rmy=p*(Rmz-(max([TransducersInfo(:).z]))/2)*sin(polAngle/180*pi);

% %%%Curved vortex sinus
% Rmz=linspace((max([TransducersInfo(:).z]))/2,L+(max([TransducersInfo(:).z])-L)/2,Ncurve/2);
% p=Shift*1e-3;
% 
% Rmx=p*sin(pi/2+(Rmz-(max([TransducersInfo(:).z]))/2)/(max([TransducersInfo(:).z])/2)*pi+pi/2)*cos(polAngle/180*pi);
% Rmy=p*sin(pi/2+(Rmz-(max([TransducersInfo(:).z]))/2)/(max([TransducersInfo(:).z])/2)*pi+pi/2)*sin(polAngle/180*pi);


% %%%Curved vortex sinus full pipe
Rmz=linspace(0,max([TransducersInfo(:).z]),Ncurve);
p=Shift*1e-3;

Rmx=p*sin(Rmz/max([TransducersInfo(:).z])*2*pi)*cos(polAngle/180*pi);
Rmy=zeros(1,Ncurve);


% %%%Spiral field
% Rmz=linspace(0,max([TransducersInfo(:).z]),Ncurve);
% 
% Rmx=Shift*1e-3*sin(Rmz/max([TransducersInfo(:).z])*2*pi);
% Rmy=Shift*1e-3*cos(Rmz/max([TransducersInfo(:).z])*2*pi);

% % %%% Straight + Parabola half pipe
% % Rmz1=linspace(max([TransducersInfo(:).z])/2,L/2*2/3+max([TransducersInfo(:).z])/2,floor(2*Ncurve/3));
% % 
% % p=Shift*1e-3/(max([TransducersInfo(:).z])/4);
% % 
% % Rmx1=p*(Rmz1-(max([TransducersInfo(:).z]))/2)*cos(polAngle/180*pi);
% % Rmy1=p*(Rmz1-(max([TransducersInfo(:).z]))/2)*sin(polAngle/180*pi);
% % 
% % Rmz2=linspace(max([TransducersInfo(:).z])/2,L/2/3+max([TransducersInfo(:).z])/2,ceil(Ncurve/3));
% % 
% % Rmz=[Rmz2 Rmz1+L/2/3];
% % Rmx=[zeros(1,ceil(Ncurve/3)) Rmx1];
% % Rmy=[zeros(1,ceil(Ncurve/3)) Rmy1];

% % %%% Straight + Tilted line
% Rmz1=linspace(max([TransducersInfo(:).z])/2,L/2+max([TransducersInfo(:).z])/2,Ncurve/2);
% 
% p=Shift*1e-3/(max([TransducersInfo(:).z])/2);
% 
% Rmx1=p*(Rmz1-(max([TransducersInfo(:).z]))/2)*cos(polAngle/180*pi);
% Rmy1=p*(Rmz1-(max([TransducersInfo(:).z]))/2)*sin(polAngle/180*pi);
% 
% Rmz2=linspace(0,max([TransducersInfo(:).z])/2,Ncurve/2);
% Rmx2=zeros(1,Ncurve/2);
% Rmy2=zeros(1,Ncurve/2);
% 
% Rmz=[Rmz2 Rmz1];
% Rmx=[Rmx2 Rmx1];
% Rmy=[Rmy2 Rmy1];

% % %%% Straight + half pipe

% Rmz=linspace(0,max([TransducersInfo(:).z])/2,Ncurve);
% Rmx=zeros(1,Ncurve);
% Rmy=zeros(1,Ncurve);



% %%% Straight + Tilted line

% Rmz=linspace(FocusPosition-0.1e-3,FocusPosition+0.1e-3,Ncurve);
% Rmx=zeros(1,Ncurve);
% Rmy=zeros(1,Ncurve);

% %%% Straight + Parabola full pipe
% Rmz=linspace((max([TransducersInfo(:).z])-L)/2,L+(max([TransducersInfo(:).z])-L)/2,Ncurve);
% Rmx=linspace(0,0,Ncurve/2);
% Rmy=linspace(0,0,Ncurve/2);
% 
% p=Shift*1e-3/(max([TransducersInfo(:).z])/2)^2;
% 
% Rmx=[Rmx p*(Rmz(length(Rmz)/2+1:end)-Rmz(length(Rmz)/2+1)).^2*cos(polAngle/180*pi)];
% Rmy=[Rmy p*(Rmz(length(Rmz)/2+1:end)-Rmz(length(Rmz)/2+1)).^2*sin(polAngle/180*pi)];

%%% Parabola full pipe
% Rmz=linspace(0,max([TransducersInfo(:).z]),Ncurve);
% 
% 
% p=Shift*1e-3/(max([TransducersInfo(:).z]))^2;
% 
% Rmx=p*(Rmz).^2*cos(polAngle/180*pi);
% Rmy=p*(Rmz).^2*sin(polAngle/180*pi);



%%% Straight + 2 Curved vortex
% Rmz=linspace((max([TransducersInfo(:).z]))/2,L+(max([TransducersInfo(:).z])-L)/3,round(Ncurve/3));
% 
% p=Shift*1e-3/(max([TransducersInfo(:).z])/2)^2;
% 
% Rmx1=p*(Rmz-(max([TransducersInfo(:).z]))/2).^2*cos(polAngle/180*pi);
% Rmy1=p*(Rmz-(max([TransducersInfo(:).z]))/2).^2*sin(polAngle/180*pi);
% Rmx2=-p*(Rmz-(max([TransducersInfo(:).z]))/2).^2*cos(polAngle/180*pi);
% Rmy2=-p*(Rmz-(max([TransducersInfo(:).z]))/2).^2*sin(polAngle/180*pi);
% 
% Rmz=[Rmz Rmz linspace((max([TransducersInfo(:).z])-L)/2,(max([TransducersInfo(:).z]))/2,round(Ncurve/3))];
% Rmx=[Rmx1 Rmx2 zeros(1,round(Ncurve/3))];
% Rmy=[Rmy1 Rmy2 zeros(1,round(Ncurve/3))];


% %%% 2 Curved vortex parabola
% Rmz1=linspace((max([TransducersInfo(:).z]))/2,L/2+max([TransducersInfo(:).z])/2,Ncurve/2);
% 
% p=Shift*1e-3/(max([TransducersInfo(:).z])/2)^2;
% 
% Rmx1=p*(Rmz1-(max([TransducersInfo(:).z]))/2).^2*cos(polAngle/180*pi);
% Rmy1=p*(Rmz1-(max([TransducersInfo(:).z]))/2).^2*sin(polAngle/180*pi)-LateralShift;
% 
% Rmz2=linspace((max([TransducersInfo(:).z]))/2,L/2+max([TransducersInfo(:).z])/2,Ncurve/2);
% 
% p=Shift*1e-3/(max([TransducersInfo(:).z])/2)^2;
% 
% Rmx2=p*(Rmz1-(max([TransducersInfo(:).z]))/2).^2*cos((polAngle+180)/180*pi);
% Rmy2=p*(Rmz1-(max([TransducersInfo(:).z]))/2).^2*sin((polAngle+180)/180*pi)+LateralShift;
% 
% Rmx=[Rmx1 Rmx2];
% Rmy=[Rmy1 Rmy2];
% Rmz=[Rmz1 Rmz2];

% %%% 2 Curved vortex parabola and straight line
% Rmz1=linspace((max([TransducersInfo(:).z]))/2,1e-3+max([TransducersInfo(:).z])/2,Ncurve/3);
% 
% p=Shift*1e-3/(max([TransducersInfo(:).z])/2);
% 
% Rmx1=p*(Rmz1-(max([TransducersInfo(:).z]))/2)*cos(polAngle/180*pi);
% Rmy1=p*(Rmz1-(max([TransducersInfo(:).z]))/2)*sin(polAngle/180*pi)-LateralShift;
% 
% Rmz2=linspace((max([TransducersInfo(:).z]))/2,1e-3+max([TransducersInfo(:).z])/2,Ncurve/3);
% 
% p=Shift*1e-3/(max([TransducersInfo(:).z])/2);
% 
% Rmx2=p*(Rmz1-(max([TransducersInfo(:).z]))/2)*cos((polAngle+180)/180*pi);
% Rmy2=p*(Rmz1-(max([TransducersInfo(:).z]))/2)*sin((polAngle+180)/180*pi)+LateralShift;
% 
% 
% Rmz3=linspace(L/2+(max([TransducersInfo(:).z]))/2,L/2+1e-3+max([TransducersInfo(:).z])/2,Ncurve/3);
% 
% 
% Rmx3=zeros(1,length(Rmz3));
% Rmy3=zeros(1,length(Rmz3));
% 
% Rmx=[Rmx1 Rmx2 Rmx3];
% Rmy=[Rmy1 Rmy2 Rmy3];
% Rmz=[Rmz1 Rmz2 Rmz3];

%%%Focused field
% Rmz=linspace((max([TransducersInfo(:).z]))/2-1e-5,(max([TransducersInfo(:).z]))/2+1e-5,Ncurve);
% 
% Rmx=zeros(1,Ncurve);
% Rmy=zeros(1,Ncurve);

% x=0:1e-5:shift;
% p=shift/H^pow(ipow);
% 
% y=-power(x/p,1/pow(ipow));

% Rmy=zeros(1,Ncurve);
%%%
% %%%Split vortex
% Rmz=linspace((max([TransducersInfo(:).z])-L)/2,L+(max([TransducersInfo(:).z])-L)/2,Ncurve);
% Rmz=[Rmz linspace(max([TransducersInfo(:).z])/2,L+(max([TransducersInfo(:).z])-L)/2,Ncurve/2)];
% Rmx=linspace(0,0,Ncurve/2);
% Rmx=[Rmx linspace(0,CurvAmpl(iCurvAmpl),Ncurve/2)];
% Rmx=[Rmx linspace(0,-CurvAmpl(iCurvAmpl),Ncurve/2)];
% Rmy=zeros(1,3/2*Ncurve);
% %%%

% Rmx=CurvAmpl(iCurvAmpl)*cos(Rmz/max(Rmz)*pi/2);
% Rmx=linspace(-CurvAmpl(iCurvAmpl),CurvAmpl(iCurvAmpl),Ncurve);


% Rmx=linspace(-CurvAmpl(iCurvAmpl),-CurvAmpl(iCurvAmpl),Ncurve);
% Rmx=-25e-3*cos(Rmz/max(Rmz)*pi);

% Rmy=zeros(1,Ncurve);
% Rmz=linspace(max([TransducersInfo(:).z])/2-1e-4,max([TransducersInfo(:).z])/2+1e-4,Ncurve);
% Rmx=linspace(-1e-4,1e-4,Ncurve);
for itr=1:Nch
    itr
Sn=[TransducersInfo(itr).x TransducersInfo(itr).y TransducersInfo(itr).z];
U1=0;
U2=0;
for ip=2:length(Rmx)-1
Rm=[Rmx(ip) Rmy(ip) Rmz(ip)];
Rm1=[Rmx(ip-1) Rmy(ip-1) Rmz(ip-1)];
Rm2=[Rmx(ip+1) Rmy(ip+1) Rmz(ip+1)];
am=(Rm2-Rm1)/(sqrt(sum((Rm2-Rm1).^2)));
bm=[0 1 0];
cm=cross(am,bm);
r=sqrt(sum((Rm-Sn).^2));
U1=U1+exp(-1i*k0*r)/4/pi/r*(dot((Rm-Sn)/r,bm+1i*cm));

% theta=acos(dot(Rm-Sn,TransducersInfo(itr).n)/sqrt(dot(Rm-Sn,Rm-Sn))/sqrt(dot(TransducersInfo(itr).n,TransducersInfo(itr).n)));
% Const=k0*d/2*sin(theta);
% if Const<0.0001
%     K=0.5;
% else
%     K=besselj(1,Const)/(Const);
% end
% U=U+exp(-1i*k0*c1)/4/pi/c1*dot((Rm-Sn)/c1,bm+1i*cm)*K;

% theta=acos((Rm(3)-Sn(3))/r);
theta=acos(dot(am,(Sn-Rm)/r));
[c1] = hn(l,-k0*r);
% [c1] = exp(1i*k0*r)/r;
% % % c2=exp(-1i*m*atan2(Sn(1),Sn(2)));
c2=exp(-1i*m*angle(dot((Rm-Sn)/r,bm+1i*cm)));%for vortex
% c2=exp(-1i*m*(angle(dot((Rm-Sn)/r,bm+1i*cm))+pi/2-polAngle/180*pi))+exp(1i*m*(angle(dot((Rm-Sn)/r,bm+1i*cm))+pi/2-polAngle/180*pi));%for petal beam
% c2=exp(-1i*m*(angle(dot((Rm-Sn)/r,bm+1i*cm))-pi/2-polAngle/180*pi))+exp(1i*m*(angle(dot((Rm-Sn)/r,bm+1i*cm))+pi/2-polAngle/180*pi));%for petal beam
% c2=exp(-1i*pi*round((angle(dot((Rm-Sn)/r,bm+1i*cm))+pi)/pi*m));%for petal beam
% % % c2=exp(-1i*pi*round(atan2(TransducersInfo(itr).y,TransducersInfo(itr).x)/pi*m));%for petal beam
% % % double(subs(c3,cos(theta)));
% c3=1;%l=m=0
c3=-(1 - cos(theta)^2)^(1/2); % l=m=1
% c3=-15*cos(theta)*(cos(theta)^2 - 1); %l=m=3
% x11=cos(theta);
% c3=-3*x11*(1 - x11^2)^(1/2);
% c3=3 - 3*cos(theta)^2; % l=m=2
% c3=dot((Rm-Sn)/r,bm);
% c3=dot((Rm-Sn)/r,bm+1i*cm);

theta2=acos(dot(Rm-Sn,TransducersInfo(itr).n)/sqrt(dot(Rm-Sn,Rm-Sn))/sqrt(dot(TransducersInfo(itr).n,TransducersInfo(itr).n)));    
Const=k0*d/2*sin(theta2);
if Const<0.0001
K=1;
else
K=2*besselj(1,Const)/(Const);
end 
if itr < Nch/2
    U2=U2+c1*c2*c3*VortexAmpl(ip)*sqrt(TransducersInfo(itr).x^2+TransducersInfo(itr).y^2);
else
    U2=U2+c1*c2*c3*VortexAmpl(ip)*sqrt(TransducersInfo(itr).x^2+TransducersInfo(itr).y^2)/cos(atan((0.0575-0.0445)/(max([TransducersInfo(:).z])/2)));
end
% U2=U2+c1*c2*c3*VortexAmpl(ip);
% U2=U2+c1*c2*c3*VortexAmpl(ip)*exp(1i*PhaseAlongChannel*ip/Ncurve*L/(L-Ladd));
end
TransducersInfo(itr).Phase=angle(U2)/pi*180;
TransducersInfo(itr).Amp=abs(U2);
% TransducersInfo(itr).Amp=1;

% [~,Ix]=min(abs(Rmz-TransducersInfo(itr).z));
% x0=Rmx(Ix);
% y0=Rmy(Ix);
% TransducersInfo(itr).Phase{iCurvAmpl}=angle(exp(1i*(m*atan2(TransducersInfo(itr).y,TransducersInfo(itr).x)-k0*sqrt((TransducersInfo(itr).x-x0)^2+(TransducersInfo(itr).y-y0)^2))))/pi*180;
% TransducersInfo(itr).Ampl{iCurvAmpl}=1/sqrt((TransducersInfo(itr).x-x0)^2+(TransducersInfo(itr).y-y0)^2);

end
end
%%
% for itr=1:Ntr/2
%     TransducersInfo(itr).Amp=0;
% end

%% Data to txt
Norm=0;

for itr=1:Nch
Norm=max([Norm TransducersInfo(itr).Amp]);
end
for itr=1:Nch
TransducersInfo(itr).Amp=(TransducersInfo(itr).Amp)/Norm;
end

T = table([TransducersInfo(:).transducer]',...
    [TransducersInfo(:).x]',[TransducersInfo(:).y]',[TransducersInfo(:).z]',[TransducersInfo(:).Amp]',[TransducersInfo(:).Phase]',...
    'VariableNames', {'Transducer', 'x', 'y', 'z', 'Amp','Phase'} );
writetable(T, ['C:\Users\nikodmi\OneDrive - University of Helsinki\Work\ETLA\Force tube\TubeVortex\MFiles\ChannelsLink\' fnm '.txt'])
%% figures
Lx=18e-3;
dx=0.5e-3;
y=0;
x=-Lx:dx:Lx;
% x=-1e-2:dx:1e-2;
% y=x;
dz=dx;
z=-10e-3:dz:max([TransducersInfo(:).z])+10e-3;
% z=0:dz:91e-3;
[X Y Z]=meshgrid(x,y,z);
P1=zeros(length(x),length(y),length(z));
P2=zeros(length(x),length(z),length(y));

for ix=1:length(x)
    ix;
for iy=1:length(y)
if x(ix)^2+y(iy)^2<(0.95*D/2)^2
for iz=1:length(z)
for itr=1:Nch
        l=sqrt((x(ix)-TransducersInfo(itr).x)^2+(y(iy)-TransducersInfo(itr).y)^2+(z(iz)-TransducersInfo(itr).z)^2);
        % theta=asin(abs(z(iz)-TransducersInfo(itr).z)/l);
        r=[x(ix)-TransducersInfo(itr).x y(iy)-TransducersInfo(itr).y z(iz)-TransducersInfo(itr).z];
        theta=acos(sum(TransducersInfo(itr).n.*r)/sqrt(sum(TransducersInfo(itr).n.*TransducersInfo(itr).n))/sqrt(sum(r.*r)));

        Const=2*pi/lambda*d/2*sin(theta);
        if Const<0.0001
            K=1;
        else
            K=besselj(1,Const)/(Const)*2;
        end
        P1(ix,iy,iz)=P1(ix,iy,iz)+Calibr*TransducersInfo(itr).Amp*K/l*exp(1i*k0*l+1i*TransducersInfo(itr).Phase/180*pi);
        P2(ix,iz,iy)=P1(ix,iy,iz);
end
end
end
end
end

figure
set(gcf, 'WindowState', 'maximized');
imagesc(x*1e3,z(end:-1:1)*1e3,squeeze(abs(P1(:,1,end:-1:1)))'/max(max(abs(P1(:,1,(end:-1:1))))))
colormap('hot')
axis equal tight
xlabel('y, mm')
ylabel('z, mm')
ylim([-10 max([TransducersInfo(:).z])*1e3+10])
set(gcf, 'Color', 'black');
set(gca, 'FontSize', 25, 'LineWidth',3, 'FontName', 'Times New Roman')
set(gca, 'XColor', 'w', 'YColor', 'w');
filePath = ['C:\Users\nikodmi\OneDrive - University of Helsinki\Work\ETLA\Articles preparation\Massless tube\For submission\Revision PNAS\Fig New2\Data to process\Continuous stream\Fields\' 'XZ' num2str(Shift) '_Mode' num2str(hirality) '.png'];
exportgraphics(gcf, filePath, 'Resolution', 300, 'BackgroundColor', 'black');
%%

x=-Lx:dx:Lx;
y=-Lx:dx:Lx;
dz=dx;
z0=max([TransducersInfo(:).z])/2-0e-3;
P3=zeros(length(x),length(y));
for ix=1:length(x)
    ix
for iy=1:length(y)
for itr=1:Nch
        l=sqrt((x(ix)-TransducersInfo(itr).x)^2+(y(iy)-TransducersInfo(itr).y)^2+(z0-TransducersInfo(itr).z)^2);
        theta=asin(abs(z0-TransducersInfo(itr).z)/l);
        Const=2*pi/lambda*d/2*sin(theta);
        if Const<0.0001
            K=1;
        else
            K=besselj(1,Const)/(Const)*2;
        end
        P3(ix,iy)=P3(ix,iy)+Calibr*TransducersInfo(itr).Amp*K/l*exp(1i*k0*l+1i*TransducersInfo(itr).Phase/180*pi);
end

end
end



figure
set(gcf, 'WindowState', 'maximized');
imagesc(x*1e3,y*1e3,squeeze(abs(P3(:,:,1)))'/max(max(abs(P3(:,:,1)))))
colormap('hot')
axis equal tight
xlabel('y, mm')
ylabel('x, mm')
% ylim([max([TransducersInfo(:).z])/2*1e3-10 max([TransducersInfo(:).z])*1e3+10])
set(gcf, 'Color', 'black');
set(gca, 'FontSize', 25, 'LineWidth',3, 'FontName', 'Times New Roman')
set(gca, 'XColor', 'w', 'YColor', 'w');
filePath = ['C:\Users\nikodmi\OneDrive - University of Helsinki\Work\ETLA\Articles preparation\Massless tube\For submission\Revision PNAS\Fig New2\Data to process\Continuous stream\Fields\' 'XY' num2str(Shift) '_Mode' num2str(hirality) '.png'];
exportgraphics(gcf, filePath, 'Resolution', 300, 'BackgroundColor', 'black');
%%
%% figures
Lx=10e-3;
dx=0.5e-3;
x=-Lx:dx:Lx;
y=x;
% x=-1e-2:dx:1e-2;
% y=x;
dz=dx;
z=-10e-3:dz:max([TransducersInfo(:).z])+10e-3;
% z=0:dz:91e-3;
[X Y Z]=meshgrid(x,y,z);
P3=zeros(length(x),length(y),length(z));

for ix=1:length(x)
    ix;
for iy=1:length(y)
for iz=1:length(z)
for itr=1:Nch
        l=sqrt((x(ix)-TransducersInfo(itr).x)^2+(y(iy)-TransducersInfo(itr).y)^2+(z(iz)-TransducersInfo(itr).z)^2);
        % theta=asin(abs(z(iz)-TransducersInfo(itr).z)/l);
        r=[x(ix)-TransducersInfo(itr).x y(iy)-TransducersInfo(itr).y z(iz)-TransducersInfo(itr).z];
        theta=acos(sum(TransducersInfo(itr).n.*r)/sqrt(sum(TransducersInfo(itr).n.*TransducersInfo(itr).n))/sqrt(sum(r.*r)));

        Const=2*pi/lambda*d/2*sin(theta);
        if Const<0.0001
            K=1;
        else
            K=besselj(1,Const)/(Const)*2;
        end
        P3(ix,iy,iz)=P3(ix,iy,iz)+Calibr*TransducersInfo(itr).Amp*K/l*exp(1i*k0*l+1i*TransducersInfo(itr).Phase/180*pi);
end
end
end
end

volumeViewer(abs(P3))

% % 
% % 
% % figure
% % MaxP1=max(abs(P1(:)));
% % MaxP3=max(abs(P3(:)));
% % MaxP=max(MaxP1,MaxP3);
% % set(gcf, 'Position', get(0, 'Screensize'));
% % subplot(1,3,1:2)
% % colormap('hot')
% % imagesc(z*1e3,x*1e3,squeeze(abs(P1(:,ceil(length(x)/2),:))))
% % hold on
% % plot([z0 z0]*1e3,[-Lx Lx]*1e3,'--','Color',[0 0 0],'Linewidth',2)
% % plot([0 0]*1e3,[-Lx Lx]*1e3,'-','Color',[0 0 0],'Linewidth',2)
% % plot([5.8e-3*9 5.8e-3*9]*1e3,[-Lx Lx]*1e3,'-','Color',[0 0 0],'Linewidth',2)
% % axis equal tight
% % xlabel('z, mm')
% % ylabel('y, mm')
% % caxis([0 MaxP1])
% % set(gca, 'FontSize', 25, 'LineWidth',3, 'FontName', 'Times New Roman')
% % 
% % subplot(1,3,3)
% % colormap('hot')
% % imagesc(x*1e3,y*1e3,squeeze(abs(P3(:,:,1))))
% % axis equal tight
% % colorbar('Ticks',[0,MaxP],'Ticklabels',{0, num2str(MaxP)})
% % xlabel('x, mm')
% % ylabel('y, mm')
% % caxis([0 MaxP])
% % set(gca, 'FontSize', 25, 'LineWidth',3, 'FontName', 'Times New Roman')
% % % saveas(gcf,['\\ad.helsinki.fi\home\n\NikoDmi\Documents\Work\ETLA\Force tube\TubeVortex\DifferentFields\' fnm '.png'])
% % 
% % figure
% % set(gcf, 'Position', get(0, 'Screensize'));
% % c = hsv
% % colormap('hsv')
% % for itr=1:Nch
% % plot3(TransducersInfo(itr).z*1e3,TransducersInfo(itr).x*1e3,TransducersInfo(itr).y*1e3,'.', 'Color', c(round((TransducersInfo(itr).Phase+180)/360*63)+1,:),'Markersize', 45)
% % axis equal 
% % hold on
% % xlim([-D/2 D/2]*1.5*1e3)
% % ylim([-D/2 D/2]*1.5*1e3)
% % % zlim([0 58e-3]*1e3)
% % xlabel('x, mm')
% % ylabel('y, mm')
% % zlabel('z, mm')
% % end
% % colorbar('Ticks',[0,1],'Ticklabels',{'-\pi', '\pi'})
% % 
% % figure
% % set(gcf, 'Position', get(0, 'Screensize'));
% % c = flipud(hot)
% % colormap(flipud(hot))
% % for itr=1:Nch
% % plot3(TransducersInfo(itr).z*1e3,TransducersInfo(itr).x*1e3,TransducersInfo(itr).y*1e3,'.', 'Color', c(round((TransducersInfo(itr).Amp)/max([TransducersInfo(:).Amp])*63)+1,:),'Markersize', 45)
% % axis equal 
% % hold on
% % xlim([-D/2 D/2]*1.5*1e3)
% % ylim([-D/2 D/2]*1.5*1e3)
% % % zlim([0 58e-3]*1e3)
% % xlabel('x, mm')
% % ylabel('y, mm')
% % zlabel('z, mm')
% % end
% % caxis([min([TransducersInfo(:).Amp])/max([TransducersInfo(:).Amp]) 1])
% % colorbar
% % % saveas(gcf,['\\ad.helsinki.fi\home\n\NikoDmi\Documents\Work\ETLA\Force tube\TubeVortex\DifferentFields\Phases' fnm '.png'])
% % figure
% % plot(Rmx,Rmz)
% % axis equal
% % 
% % 
% % 
% % 
% % 
% % figure
% % set(gcf, 'Position', get(0, 'Screensize'));
% % colormap('hot')
% % imagesc(z*1e3+1,x*1e3,squeeze(abs(P1(:,ceil(length(x)/2),end:-1:1))))
% % hold on
% % % plot([max([TransducersInfo(:).z]) max([TransducersInfo(:).z])]*1e3,[-Lx Lx]*1e3,'-','Color',[0 0 0],'Linewidth',2)
% % % plot([0 0]*1e3,[-Lx Lx]*1e3,'-','Color',[0 0 0],'Linewidth',2)
% % % plot([max([TransducersInfo(:).z])/2 max([TransducersInfo(:).z])/2]*1e3,[-Lx Lx]*1e3,'--','Color',[0 0 0],'Linewidth',2)
% % % % plot([5.8e-3*9 5.8e-3*9]*1e3,[-Lx Lx]*1e3,'-','Color',[0 0 0],'Linewidth',2)
% % % 
% % % plot(Rmz(1:length(Rmz))*1e3,Rmx(1:length(Rmy))*1e3,'--','Color',[1 1 1],'Linewidth',2)
% % % % plot(Rmz((length(Rmz)/2+1):end)*1e3,Rmx((length(Rmz)/2+1):end)*1e3,'-','Color',[0 0 0],'Linewidth',2)
% % axis equal tight
% % set(gca, 'YDir', 'normal');
% % 
% % % xlim([max([TransducersInfo(:).z])/2*1e3-0.7e-2*1e3 max([TransducersInfo(:).z])*1e3+0.7e-2*1e3])
% % xlabel('z, mm')
% % ylabel('y, mm')
% % set(gca, 'FontSize', 35, 'LineWidth',3, 'FontName', 'Times New Roman')
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % figure
% % imagesc(x*1e3,y*1e3,squeeze(abs(P1(:,:,ceil(length(z)/2)))))
% % colormap('hot')
% % 
% % axis equal tight
% % colorbar('Ticks',[0,MaxP],'Ticklabels',{0, num2str(MaxP)})
% % xlabel('x, mm')
% % ylabel('y, mm')
% % caxis([0 MaxP])
% % set(gca, 'FontSize', 25, 'LineWidth',3, 'FontName', 'Times New Roman')
% % % saveas(gcf,['\\ad.helsinki.fi\home\n\NikoDmi\Documents\Work\ETLA\Force tube\TubeVortex\DifferentFields\' fnm '.png'])

%% Potential calculation
% % dens_air=1.2;
% % c_air=343;
% % 
% % 
% % % dens_gas=1.98;%N2O
% % % dens_gas=1.03;%70C air
% % dens_gas=1.21;%18C air
% % % c_gas=268;%N2O
% % % c_gas=365;%70C air
% % c_gas=342.2;%18C air
% % 
% % f1=1-dens_air*c_air^2/dens_gas/c_gas^2;
% % f2=2*(dens_gas-dens_air)/(2*dens_gas+dens_air);
% % 
% % 
% % 
% % Vx=diff(P1,1,1)/dx;
% % Vx(:,end,:)=[];
% % Vx(:,:,end)=[];
% % Vy=diff(P1,1,2)/dx;
% % Vy(end,:,:)=[];
% % Vy(:,:,end)=[];
% % Vz=diff(P1,1,3)/dx;
% % Vz(end,:,:)=[];
% % Vz(:,end,:)=[];
% % 
% % Pmod=P1;
% % Pmod(end,:,:)=[];
% % Pmod(:,end,:)=[];
% % Pmod(:,:,end)=[];
% % 
% % Pmod=Pmod/max(max(max(abs(Pmod))))*5.3*1e3;
% % 
% % figure
% % imagesc(x*1e3,y*1e3,abs(Pmod(:,:,ceil(length(z)/4))))
% % colormap('hot')
% % axis equal tight
% % xlabel('x, mm')
% % ylabel('y, mm')
% % set(gca, 'FontSize', 25, 'LineWidth',3, 'FontName', 'Times New Roman')
% % 
% % figure
% % imagesc(z*1e3,y*1e3,squeeze(abs(Pmod(ceil(length(x)/2),:,:)))/1e3)
% % colormap('hot')
% % axis equal tight
% % xlabel('z, mm')
% % ylabel('x, mm')
% % colorbar
% % set(gca, 'FontSize', 25, 'LineWidth',3, 'FontName', 'Times New Roman')
% % 
% % 
% % 
% % Epot=1/4/dens_air/c_air/c_air*Pmod.*conj(Pmod);
% % Ekin=1/4/dens_air/(2*pi*f0)^2*(Vx.*conj(Vx)+Vy.*conj(Vy)+Vz.*conj(Vz));
% % U=f1/3*Epot-f2/2*Ekin;
% % 
% % xmod=x;
% % xmod(end)=[];
% % ymod=y;
% % ymod(end)=[];
% % zmod=z;
% % zmod(end)=[];
% % 
% % figure
% % colormap('jet')
% % MaxValue=max(max(max(abs(real(U(:,:,:))))))*1e3;
% % 
% % imagesc(xmod*1e3,ymod*1e3,real(U(:,:,ceil(length(z)/4)))*1e3)
% % axis equal tight
% % xlabel('x (mm)')
% % ylabel('y (mm)')
% % caxis([-MaxValue MaxValue])
% % xlim([-10 10])
% % ylim([-10 10])
% % set(gca, 'FontSize', 25, 'LineWidth',3, 'FontName', 'Times New Roman')
% % 
% % 
% % figure
% % colormap('jet')
% % % MaxValue=max(max(abs(squeeze(real(U(end:-1:1,ceil(length(x)/2),:))))));
% % imagesc(zmod*1e3,ymod*1e3,squeeze(real(U(ceil(length(x)/2),end:-1:1,:)))*1e3)
% % axis equal tight
% % xlabel('z (mm)')
% % ylabel('y (mm)')
% % caxis([-MaxValue MaxValue])
% % 
% % set(gca, 'FontSize', 25, 'LineWidth',3, 'FontName', 'Times New Roman')
% % colorbar