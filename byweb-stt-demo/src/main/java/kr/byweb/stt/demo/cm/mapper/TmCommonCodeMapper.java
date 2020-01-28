package kr.byweb.stt.demo.cm.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.byweb.stt.demo.cm.model.TmCmCdVo;

@Mapper
public interface TmCommonCodeMapper {
	public List<TmCmCdVo> getPrdlnList(Map pMap) throws Exception;
	
	public List<TmCmCdVo> getKwdKndCd() throws Exception;
	
	public List<TmCmCdVo> getReqDeptList(Map pMap) throws Exception;

	public List<TmCmCdVo> getTitleList() throws Exception;

	public List<TmCmCdVo> getNavTitleList(String req_cd) throws Exception;
}
