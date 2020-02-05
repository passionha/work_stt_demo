package kr.byweb.stt.demo.mng.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.byweb.stt.demo.mng.model.PrdlnMngVo;

@Mapper
public interface ProductLineManagementMapper {

	public List<PrdlnMngVo> getProductList(Map pMap) throws Exception;
	
}
