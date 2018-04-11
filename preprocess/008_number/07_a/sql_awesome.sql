SELECT *
FROM work.production_missn_tb

-- thicknessがnullのレコードを削除
WHERE thickness is not NULL
