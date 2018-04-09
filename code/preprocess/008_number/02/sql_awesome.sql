SELECT
	*,

  -- total_priceを1000で割り、1足した結果を対数化
  LOG(total_price / 1000 + 1) AS total_price_log

FROM work.reserve_tb
