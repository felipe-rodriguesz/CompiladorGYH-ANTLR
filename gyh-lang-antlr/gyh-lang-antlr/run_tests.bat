@echo off
(for /L %%i in (1,1,19) do (
    echo ==== TEST: programa%%i.gyh ====
    call "C:\Program Files\Apache NetBeans\java\maven\bin\mvn.cmd" -q exec:java "-Dexec.args=programa%%i.gyh"
)) > resultado_dos_testes.md 2>&1
