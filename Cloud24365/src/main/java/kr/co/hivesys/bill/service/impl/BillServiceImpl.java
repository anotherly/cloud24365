package kr.co.hivesys.bill.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.hivesys.bill.mapper.BillMapper;
import kr.co.hivesys.bill.service.BillService;
import kr.co.hivesys.bill.vo.BillVo;

@Service("billService")
public class BillServiceImpl implements BillService{
	@Resource(name="billMapper")
	private BillMapper billMapper;
	
	@Override
	public List<BillVo> selectList(BillVo inputVo) {
		return billMapper.selectList(inputVo);
	}
	
	@Override
	public String createId(BillVo inputVo) {
		return billMapper.createId(inputVo);
	}

	@Override
	public int insert(BillVo inputVo) {
		return billMapper.insert(inputVo);
	}

	@Override
	public BillVo selectOne(BillVo inputVo) {
		return billMapper.selectOne(inputVo);
	}

	@Override
	public int update(BillVo inputVo) {
		return billMapper.update(inputVo);
	}

	@Override
	public int delete(List<String> inputList) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("chkList",inputList);
		return billMapper.delete(map);	
	}

	@Override
	public int firstNumber(BillVo inputVo) {
		return billMapper.firstNumber(inputVo);
	}
}
