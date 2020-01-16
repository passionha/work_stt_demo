package kr.byweb.stt.demo.cm.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
public class FinanceVo {
	private @NonNull String class_cd;
	private @NonNull String class_name;
	private @NonNull String finance_cd;
	private @NonNull String finance_name;
	private Timestamp busi_strt_day;
	private Timestamp busi_end_day;
}
