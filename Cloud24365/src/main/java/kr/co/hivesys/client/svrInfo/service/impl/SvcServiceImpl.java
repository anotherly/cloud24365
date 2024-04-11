package kr.co.hivesys.client.svrInfo.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.hivesys.main.mapper.MainMapper;
import kr.co.hivesys.main.service.MainService;
import kr.co.hivesys.client.svrInfo.mapper.SvcMapper;
import kr.co.hivesys.client.svrInfo.service.SvcService;
import kr.co.hivesys.user.vo.UserVO;

@Service("svcService")
public class SvcServiceImpl implements SvcService{
	@Resource(name="svcMapper")
	private SvcMapper svcMapper;
}
