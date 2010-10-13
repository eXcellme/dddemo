package com.redhat.demo.application;

import org.junit.Assert;
import org.junit.Test;

import com.dayatang.domain.InstanceFactory;
import com.dayatang.springtest.PureSpringTestCase;
import com.redhat.demo.domain.FunctionEntity;

public class applicationTest extends PureSpringTestCase {

	private FunctionEntityApplication app;

	@Override
	public void setup() {
		super.setup();
		app = InstanceFactory.getInstance(FunctionEntityApplication.class);
	}

	@Override
	protected String[] springXmlPath() {
		return new String[] { "classpath*:spring/*.xml" };
	}

	@Test
	public void testGetFunctionEntityById() {
		FunctionEntity entity = null;
		try {
			entity = app.getFunctionEntityById(999999L);
			Assert.assertNotNull(entity);
		} catch (RuntimeException e) {
			Assert.assertNull(entity);
		}

	}
}
