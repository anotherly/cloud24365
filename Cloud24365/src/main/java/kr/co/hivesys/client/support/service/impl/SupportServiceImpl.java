package kr.co.hivesys.client.support.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.hivesys.main.mapper.MainMapper;
import kr.co.hivesys.main.service.MainService;
import kr.co.hivesys.client.support.mapper.SupportMapper;
import kr.co.hivesys.client.support.service.SupportService;
import kr.co.hivesys.user.vo.UserVO;

@Service("supportService")
public class SupportServiceImpl implements SupportService{
	@Resource(name="supportMapper")
	private SupportMapper supportMapper;
}
