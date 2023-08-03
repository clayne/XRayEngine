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
md res\bin\
md res\gamedata\
md res\rawdata\
call :COPY_ENGINE

cd res
7z a "HybridXRay.%EDITION_NAME%.7z" * -xr!.* -xr!*.pdb
7z a "Symbols.%EDITION_NAME%.7z" bin\*.pdb -i!License.txt -i!README.md -xr!.*
cd ..

rem Return edition name
set NEED_OUTPUT=%1
if defined NEED_OUTPUT (
    set %~1=%EDITION_NAME%
)
goto :EOF

:COPY_ENGINE
copy "bin\%PLATFORM_FOLDER%\%CONFIGURATION%\*.dll" res\bin\
copy "bin\%PLATFORM_FOLDER%\%CONFIGURATION%\*.exe" res\bin\
copy "bin\%PLATFORM_FOLDER%\%CONFIGURATION%\*.pdb" res\bin\

copy License.txt res\
copy fs.ltx res\
copy fs_cs.ltx res\
copy fs_soc.ltx res\
copy fsgame.ltx res\
copy fsgame_cs.ltx res\
copy fsgame_soc.ltx res\
copy tool_compile_xrAI.cmd res\
copy tool_compile_xrAI_draft.cmd res\
copy tool_compile_xrDO.cmd res\
copy tool_compile_xrLC.cmd res\
copy tool_create_spawn.cmd res\
copy tool_verify_ai_map.cmd res\
copy tool_compile_xrAI.cmd res\
goto :EOF
