if [[ -s "/data/YG/games.txt" && -z "$(tail -c 1 "/data/YG/games.txt")" ]]; then
    echo "True"
    #echo "$filename 檢查正常，繼續執行更新程式。"
else
    echo "False"
    #echo "$filename 為空檔案或者檔案末端沒有空行，更新程式中止。"
fi
