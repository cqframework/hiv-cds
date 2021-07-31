@ECHO off
SET tooling_jar=tooling-1.3.1-SNAPSHOT-jar-with-dependencies.jar
SET input_cache_path=%~dp0input-cache
SET datadictionary_directory=input/datadictionary/
REM the next 3 lines need to be edited
SET datadictionary_filename=%datadictionary_directory%\NACHC-DD.xlsx
SET datadictionary_sheetname="NACHC.A0 Contact & Profile, NACHC.A1 HIV, NACHC.A2 HIV test, NACHC.B1 HCV, NACHC.B2 HCV test, NACHC.C1 Syphilis, NACHC.C2 Syphilis test, NACHC.D1 Gonorrhea, NACHC.D2 Gonorrhea test,  NACHC.E1 Chlamydia, NACHC.E2 Chlamydia test, NACHC.F1 Injection Drug Use, NACHC.F2 Pregnancy, NACHC.G1 Post Exposure Prophylaxis, NACHC.G2 Pre Exposure Prophylaxis, NACHC.H1 Risk Factors"
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
