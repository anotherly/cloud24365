package kr.co.hivesys.admin.opr.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.hivesys.admin.opr.mapper.OprMapper;
import kr.co.hivesys.admin.opr.service.OprService;

@Service("oprService")
public class OprServiceImpl implements OprService{
	@Resource(name="oprMapper")
	private OprMapper oprMapper;
}