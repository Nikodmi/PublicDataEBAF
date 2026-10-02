#### **2D\_gas\_dynamics.mph**



* COMSOL FEM simulation file for simulating gas mixture dynamics in a 2D circular domain
* Dynamics governed by acoustic streaming flow, acoustic force due to the inhomogeneous fluid and diffusion
* Includes six different gases in a nitrogen environment, separated into different physics nodes and studies
* Default settings have a circular initial gas distribution in a focused (m=0) acoustic field



###### Running the simulation:

* Pick a study and hit Compute



###### Optional changes to the main default settings:

* Initial gas distribution can be changed under the Transport of concentrated species node
* Pressure acoustics node includes an option for the m=1 field
* Pressure magnitude can be changed by adjusting the p\_focused and p\_vortex parameters in Parameters 1



##### 

#### **3D\_acoustic\_streaming.mph**



* COMSOL FEM simulation file for simulating pressure distribution and acoustic streaming in a straight section of an acoustic pipe in 3D
* Three different acoustic fields: focused (m=0), vortex (m=1) and vortex superposition (m=+-1)
* Default settings set the max pressure to 5.3 kPa by setting a suitable normal displacement value (d0) for each case



###### Running the simulation:

* The acoustics and fluid flow simulations are divided into different studies
* Run the acoustics studies first, then followed by the respective flow studies



###### Optional changes to the main default settings:

* Pipe radius and length: adjust respective parameters in General parameters
* Pressure: adjust d0 in General parameters





#### **2D\_particle\_dynamics.mph**



* COMSOL FEM simulation file for simulating particle dynamics in a 2D acoustic field
* Particle dynamics governed by acoustic radiation force, fluid drag due to acoustic streaming, and a shear lift force
* Three different acoustic fields: focused (m=0), vortex (m=1) and vortex superposition (m=+-1)



###### Running the simulation:

* Run the acoustics \& flow studies first (studies 1 \& 2), followed by the particle tracing studies (studies 3, 4 \& 5)



###### Adjustable parameters:

* Particle parameters can be adjusted by changing suitable parameters in Parameters 1, e.g. particle diameter, density and speed of sound
* The domain size and surface normal displacement (pressure) can be adjusted similarly
* Initial particle distribution can be either set via a coordinate file (here initial\_particle\_coordinates.txt) or by enabling the Release from grid option under the Particle tracing physics node 

