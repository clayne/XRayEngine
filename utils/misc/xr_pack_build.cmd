@echo off

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

rem Make archives
7z a "HybridXRay.%EDITION_NAME%.7z" Bin\%PLATFORM%\%CONFIGURATION%\*.dll Bin\%PLATFORM%\%CONFIGURATION%\*.exe -r0 Bin\compilers_sky_x64 -r0 gamedata -r0 rawdata -i!utils\oalinst.exe -i!utils\tool_compile_xrAI.cmd -i!utils\tool_compile_xrAI_draft.cmd -i!utils\tool_compile_xrDO.cmd -i!utils\tool_compile_xrLC.cmd -i!utils\tool_create_spawn.cmd -i!utils\tool_verify_ai_map.cmd -i!_ActorEditor.cmd -i!_LevelEditor.cmd -i!_ParticleEditor.cmd -i!_ShaderEditor.cmd -i!Compiler_AI_map.cmd -i!Compiler_Batch.cmd -i!Compiler_Details.cmd -i!Compiler_Geometry.cmd -i!Compiler_Make_spawn.cmd -i!Compiler_Menu.cmd -i!Compiler_Readme.txt -i!fs.ltx -i!fs_cs.ltx -i!fs_soc.ltx -i!fsfactory.ltx -i!fsgame.ltx -i!fsgame_cs.ltx -i!fsgame_soc.ltx -i!License.txt
7z a "Symbols.%EDITION_NAME%.7z" Bin\%PLATFORM%\%CONFIGURATION%\*.pdb -i!License.txt -xr!.*
