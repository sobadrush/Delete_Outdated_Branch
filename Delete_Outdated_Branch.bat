@ECHO OFF
ECHO ^>^>^> �R���i���a^&���ݡjBranches

SET currentDir=%cd%

SET /P isDeleteRemote=�O�_�R������BRANCH?(y/n):

REM �iSTEP1�j��J�u�@�ؿ����|
SET mmbWorkspaceRoot=D:\01.workspaces\workspace_MMB_intellij
ECHO Enter into: %mmbWorkspaceRoot%
cd %mmbWorkspaceRoot%

REM �ҥ���ĸ��y�k(�����ܼ�): !variable!
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

REM ���o��eHEAD �Ҧb�� branch name���
:getOriginBranchName
	REM ECHO. Got Param#1: %~1
	FOR /f "delims=" %%i IN ('%~1') DO (SET originBranch=%%i)
	EXIT /B 0