if "%CONFIGURATION%"=="Debug" (
    if %PLATFORM%==x64 (
        set PLATFORM_FOLDER=x64
        set EDITION_NAME=Debug 64-bit
        goto :START
    )
)

echo ! Unknown configuration and/or platform
goto :EOF

:START
md Bin\
md gamedata\
md rawdata\
call :COPY_ENGINE

cd utils
7z a "HybridXRay.%EDITION_NAME%.7z" * -xr!.* -xr!*.pdb
7z a "Symbols.%EDITION_NAME%.7z" Bin\*.pdb -i!License.txt -xr!.*
cd ..

rem Return edition name
set NEED_OUTPUT=%1
if defined NEED_OUTPUT (
    set %~1=%EDITION_NAME%
)
goto :EOF

:COPY_ENGINE
copy "Bin\%PLATFORM_FOLDER%\%CONFIGURATION%\*.dll" utils\Bin\
copy "Bin\%PLATFORM_FOLDER%\%CONFIGURATION%\*.exe" utils\Bin\
copy "Bin\%PLATFORM_FOLDER%\%CONFIGURATION%\*.pdb" utils\Bin\
copy "gamedata\*.*" utils\
copy "rawdata\*.*" utils\

copy License.txt utils\
copy fs.ltx utils\
copy fs_cs.ltx utils\
copy fs_soc.ltx utils\
copy fsgame.ltx utils\
copy fsgame_cs.ltx utils\
copy fsgame_soc.ltx utils\
copy tool_compile_xrAI.cmd utils\
copy tool_compile_xrAI_draft.cmd utils\
copy tool_compile_xrDO.cmd utils\
copy tool_compile_xrLC.cmd utils\
copy tool_create_spawn.cmd utils\
copy tool_verify_ai_map.cmd utils\
copy tool_compile_xrAI.cmd utils\
goto :EOF
