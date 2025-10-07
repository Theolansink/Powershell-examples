# 1 Get CIM namespaces
Get-CimInstance -Namespace root -ClassName __Namespace

#2 find CIM Classes
Get-CimClass *network*
Get-CimClass *operatingsystem*
Get_CimClass *BIOS*

#3 Find CIM objects
get-ciminstance –classname win32_networkadapter | select-object *
get-ciminstance –classname win32_operatingsystem | select-object *
get-ciminstance –classname Win32_BIOS | select-object *

#4 Find methods
Get-CimInstance -Class Win32_Service | Get-Member -MemberType Method
Get-CimInstance -Class Win32_Service | Get-Member -MemberType Property

#Aanroepen methoden
Get-CimInstance Win32_Process -Filter "Name='notepad.exe'" | Invoke-CimMethod -MethodName Terminate



