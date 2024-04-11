package kr.co.hivesys.client.setting.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.hivesys.main.mapper.MainMapper;
import kr.co.hivesys.main.service.MainService;
import kr.co.hivesys.client.setting.mapper.AcUserMapper;
import kr.co.hivesys.client.setting.service.AcUserService;
import kr.co.hivesys.user.vo.UserVO;

@Service("acUserService")
public class AcUserServiceImpl implements AcUserService{
	@Resource(name="acUserMapper")
	private AcUserMapper acUserMapper;
}
