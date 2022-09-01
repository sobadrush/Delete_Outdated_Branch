@ECHO OFF
ECHO ^>^>^> 刪除【本地^&遠端】Branches

SET currentDir=%cd%

SET /P isDeleteRemote=是否刪除遠端BRANCH?(y/n):

REM 【STEP1】輸入工作目錄路徑
SET mmbWorkspaceRoot=D:\01.workspaces\workspace_MMB_intellij
ECHO Enter into: %mmbWorkspaceRoot%
cd %mmbWorkspaceRoot%

REM 啟用驚嘆號語法(延遲變數): !variable!
SETLOCAL ENABLEDELAYEDEXPANSION

FOR /F %%b IN (!currentDir!\outdated_Branch.txt) DO (
	SET branchName=%%b
	echo Now handle branch is: !branchName!
	FOR /F %%a IN (!currentDir!\repo_folder_list.txt) DO (
		SET repoFolderFullPath=%cd%\%%a
		ECHO Enter into: !repoFolderFullPath!
		cd /d !repoFolderFullPath!
		
		CALL :getOriginBranchName "git rev-parse --abbrev-ref HEAD"
		ECHO origin Branch is: !originBranch!
		
		git checkout master
		git branch -d %%b
		if %isDeleteRemote% == y (
			ECHO '... Delete Remote Branch ...'
			git push origin --delete %%b
		)
		git checkout !originBranch!
		cd ..
		ECHO ===========================================================
	)
)
PAUSE

REM 取得當前HEAD 所在的 branch name函數
:getOriginBranchName
	REM ECHO. Got Param#1: %~1
	FOR /f "delims=" %%i IN ('%~1') DO (SET originBranch=%%i)
	EXIT /B 0