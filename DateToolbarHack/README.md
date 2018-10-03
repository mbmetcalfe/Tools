# Date in Toolbar Windows Hack

The scripts and files in this folder are needed to display the date in the Windows toolbar when small icons are used.

The idea is to create a new toolbar pointing to a folder whose only content is a shortcut file which gets renamed depending on the system date. A taskbar toolbar, a shortcut file, a batch script, and a scheduled task.

## Preliminary steps

1. Create a folder called DateToolbarHack in `C:\Users\<Name>` (or wherever you like).
2. Create a new folder inside DateToolbarHack and name it Date.

## Shortcut file

1. Open the Control Panel and go to **Clock, Language and Region**.
2. Right-click **Date and Time** and select **Create Shortcut** from the context menu.
3. Move the shortcut from the desktop to the `Date` folder.

## Batch script

1. Copy the following code and paste it in a new file called `UpdateToolbar.cmd` inside the `DateToolbarHack` folder:

```dos
@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0\Date"
call :getShortDate
ren *.lnk %month%-%day%.lnk
exit /b

:getShortDate
for /f "skip=1 tokens=1-3" %%A in ('wmic path Win32_LocalTime get day^,month^,year /value /format:table') do (
set day=00%%A
set day=!day:~-2!
set month=00%%B
set month=!month:~-2!
set year=%%C
set year=!year:~-2!
exit /b
)
```

2. Run the batch script and make sure the link got renamed.

## How it works

After setting the working directory it will retrieve the current date and then rename the shortcut file. The code to get the current date was partially borrowed from this page: http://ss64.com/nt/syntax-getdate.html

## Scheduled task

1. Open the **Task Scheduler** (`taskschd.msc`) and click **Action > Create Task**.
2. Name it `DateToolbarHack`.
3. While in the **General** tab, click **Change User or Group**.
4. Type `system` in the textbox, click **Check Names**, and then click **OK**.
5. Change the **Configure for** value to **Windows 7, Windows Server 2008 R2**.
6. Select the **Triggers** tab, and click **New**.
7. Change the **Begin the task** to **At log on**, then press **OK**.
8. Click **New,** select **On workstation unlock**, and press **OK**.
9. Click **New**, and select **On a schedule**. Change the setting to **Daily** and replace the **Start** time with **12:00:00 AM** (midnight). Press **OK**.
10. Switch to the **Actions** tab, and click **New**.
11. Type `"X:\Path\to\UpdateToolbar.cmd"` in the **Program/script** textbox, replacing it with the actual file path, and press **OK**.
12. Click the **Conditions** tab and uncheck **Start the task only if the computer is on AC power** option.
13. Select the **Settings** tab, and uncheck the **Allow task to be run on demand** field.
14. Enable the **Run task as soon as possible after a scheduled start is missed** option.
15. Leave all other settings to default values and press **OK**.

## Taskbar toolbar

1. Right-click the taskbar and uncheck the **Lock the Taskbar** option from the context menu.
2. Click the taskbar again and choose **Toolbars > New Toolbar**.
3. Select the `Date` folder.
4. Right-click the newly created toolbar, and uncheck the **Show Title** option from the menu.
5. Move the toolbar to the position you prefer.
6. Enable the **Lock the Taskbar** option.

## Customization

You can choose any icon you like for the shortcut. The date format can be adjusted by changing the following line in the batch script:

`ren *.lnk %month%-%day%.lnk`

## Known limitations

There should never be anything in the `Date` folder except for the one link you created.
You can't use Windows reserved characters as separators: `< > : " / \ | ? *`