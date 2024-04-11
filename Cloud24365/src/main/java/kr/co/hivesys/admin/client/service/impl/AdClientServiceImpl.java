package kr.co.hivesys.admin.client.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.hivesys.main.mapper.MainMapper;
import kr.co.hivesys.main.service.MainService;
import kr.co.hivesys.admin.client.mapper.AdClientMapper;
import kr.co.hivesys.admin.client.service.AdClientService;
import kr.co.hivesys.user.vo.UserVO;

@Service("adClientService")
public class AdClientServiceImpl implements AdClientService{
	@Resource(name="adClientMapper")
	private AdClientMapper adClientMapper;
}
