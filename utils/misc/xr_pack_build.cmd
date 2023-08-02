
if [%1]==[] (
  echo Please, specify configuration
  EXIT /B
)

if [%2]==[] (
  echo Please, specify platform
  EXIT /B
)

set CONFIGURATION=%~1
set PLATFORM=%~2

if %PLATFORM%==x64 (
    set EDITION_NAME=%CONFIGURATION% 64-bit
) else (
    set EDITION_NAME=%CONFIGURATION% %PLATFORM%
)

rem Replace spaces with dots to avoid possible problems (e.g. with GitHub nighly builds uploading)
set EDITION_NAME=%EDITION_NAME: =.%

@echo on

md Bin\

rem Prepare files
copy "Bin\%PLATFORM%\%CONFIGURATION%\*.dll" res\Bin\
copy "Bin\%PLATFORM%\%CONFIGURATION%\*.exe" res\Bin\
copy "Bin\%PLATFORM%\%CONFIGURATION%\*.pdb" res\Bin\
copy License.txt res\
copy README.md res\
copy gamedata res\
copy rawdata res\
copy utils\oalinst.exe res\utils\

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
rem We don't need MFC stuff which Visual Studio automatically copies
del /q /f /s "res\Bin\mfc*.dll"

cd res

rem Make archives
7z a "HybridXRay.%EDITION_NAME%.7z" bin gamedata rawdata utils -xr!.* -xr!*.pdb -i!fs.ltx -i!fs_cs.ltx -i!fs_soc.ltx -i!fsgame.ltx -i!fsgame_cs.ltx -i!fsgame_soc.ltx -i!tool_compile_xrAI.cmd -i!tool_compile_xrAI_draft.cmd -i!tool_compile_xrDO.cmd -i!tool_compile_xrLC.cmd -i!tool_create_spawn.cmd -i!tool_verify_ai_map.cmd -i!tool_compile_xrAI.cmd -i!License.cmd
7z a "Symbols.%EDITION_NAME%.7z" bin\*.pdb -i!License.txt -xr!.*

cd ..