package kr.byweb.stt.demo.cm.service;

import java.io.File;

public class TmUtil {
	private static final String SYNC = "SYNC";
	//logger
	
	/**
	 * 공유자원 간섭을 피하기 위해 동기화 후 파일 삭제
	 * @param f
	 */
	public void fileDelete(File f) {
		synchronized (SYNC) {
			f.delete();
		}
	}
}
