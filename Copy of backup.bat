chcp 1251
"c:\Program Files\7-Zip\7z.exe" a -t7z -ssw -mx5 -r0 -scsWIN -sccWIN E:\backup\sasha3\Nalog%date%.7z "D:\Налогоплательщик ЮЛ"

"c:\Program Files\7-Zip\7z.exe" a -t7z -ssw -mx5 -r0 -scsWIN -sccWIN E:\backup\sasha3\SPU%date%.7z "C:\Spu_orb"

"c:\Program Files\7-Zip\7z.exe" a -t7z -ssw -mx5 -r0 -scsWIN -sccWIN E:\backup\sasha3\Infotecs%date%.7z "C:\ProgramData\InfoTeCS"

"c:\Program Files\7-Zip\7z.exe" a -t7z -ssw -mx5 -r0 -scsWIN -sccWIN E:\backup\sasha3\Cert%date%.7z "C:\Users\sasha\AppData\Local\Infotecs"


"c:\Program Files\7-Zip\7z.exe" a -t7z -ssw -mx5 -r0 -scsWIN -sccWIN E:\backup\sasha3\fss%date%.7z "C:\FSSRF"

D:\ALL\backup\BackupTasks\RemoveOldFiles.vbs
rem add to task or uncomment
"c:\Program Files (x86)\WinSCP\WinSCP.exe" /script=E:\all\BackupTasks\TransferWithDelete.txt