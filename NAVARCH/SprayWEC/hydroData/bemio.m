hydro = struct();

hydro = readCAPYTAINE(hydro,'spray_hydrodynamics.nc');
hydro = radiationIRF(hydro,[],[],[],[],[]);
hydro = radiationIRFSS(hydro,[],[]);
hydro = excitationIRF(hydro,[],[],[],[],[]);
writeBEMIOH5(hydro)
plotBEMIO(hydro)

