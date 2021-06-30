@ECHO off
SET tooling_jar=tooling-1.3.1-SNAPSHOT-jar-with-dependencies.jar
SET input_cache_path=%~dp0input-cache
SET datadictionary_directory=input/datadictionary/
REM the next 3 lines need to be edited
SET datadictionary_filename=%datadictionary_directory%\NACHC-DD.xlsx
SET datadictionary_sheetname="NACHC.A1 HIV_DD_PROCESS, NACHC.A2 HIV test_DD_PROCESS, NACHC.B1 HCV_DD_PROCESS, NACHC.B2 HCV test_DD_PROCESS, NACHC.C1 Syphilis_DD_PROCESS, NACHC.C2 Syph test_DD_PROCESS, NACHC.D1 Gonorrhea_DD_PROCESS, NACHC.D2 Gono test_DD_PROCESS,  NACHC.E1 Chlamydia_DD_PROCESS, NACHC.E2 Chla test_DD_PROCESS, NACHC.F1 IDU_DD_PROCESS, NACHC.F2 Preg_DD_PROCESS, NACHC.F3 PEP_DD_PROCESS"
SET scope=nachc-hiv
SET tooling=%input_cache_path%\%tooling_jar%
SET upper_path=%%~dpx

if EXIST "%tooling%" (
	JAVA -jar "%tooling%" -ProcessAcceleratorKit -s="%scope%" -pts="%datadictionary_filename%" -dep="%datadictionary_sheetname%" -op=.
) ELSE (
	ECHO "%tooling%"
	if EXIST "%tooling%" (
		JAVA -jar $tooling -ProcessAcceleratorKit -s=$scope -pts=./input/l2/$datadictionary_filename -dep=$datadictionary_sheetname -op=.
	) ELSE (
		ECHO [91m ProcessAcceloratorKit NOT FOUND in input-cache or parent folder.  Please run _updateCQFTooling.  Aborting...
		ECHO [0m
    )
)
