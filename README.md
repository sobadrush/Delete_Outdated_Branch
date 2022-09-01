# Delete_Outdated_Branch

這是一個用來刪除 local & remote branch 的 bat 工具

- 讀取 outdated_Branch.txt 取得要刪除的 branchName，需含 feature 前綴
- 讀取 repo_folder_list.txt 取得要MMB所有 repo
- 要刪除遠端 branch 請輸入 y，否則預設只會刪除 local branch
- 進行 local & remote 的 branch 刪除