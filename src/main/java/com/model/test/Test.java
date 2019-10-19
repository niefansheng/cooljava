package com.model.test;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import com.model.page.PageDto;

/**
 * @功能说明：test
 */
public class Test extends PageDto implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	
	//字段
	private int id;//id
	private String value;//数据值
	private String label;//标签名
	private String type;//类型
	private String description;//描述
	private int sort;//排序（升序）
	private String status;//可用状态：0可用 1不可用
	private String testValue;//数据值
	private Date testData;//数据值
	private String testTest;//数据值
	
	//构造方法
	public Test() {
	}
	
	//get和set方法
	
	@Id @Column( name = "id"  ,nullable = false  , length = 10  )
	public int getId() {
		return  id;
	}

	public void setId(int id) {
		this.id = id;
	}

	
	@Column( name = "value"  , length = 100  )
	public String getValue() {
		return  value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	
	@Column( name = "label"  , length = 100  )
	public String getLabel() {
		return  label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	
	@Column( name = "type"  , length = 100  )
	public String getType() {
		return  type;
	}

	public void setType(String type) {
		this.type = type;
	}

	
	@Column( name = "description"  , length = 100  )
	public String getDescription() {
		return  description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	
	@Column( name = "sort"  , length = 10  )
	public int getSort() {
		return  sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

	
	@Column( name = "status"  , length = 1  )
	public String getStatus() {
		return  status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	
	@Column( name = "test_value"  , length = 100  )
	public String getTestValue() {
		return  testValue;
	}

	public void setTestValue(String testValue) {
		this.testValue = testValue;
	}

	
	 @Temporal(TemporalType.TIMESTAMP) @Column( name = "test_data"  , length = 10  )
	public Date getTestData() {
		return  testData;
	}

	public void setTestData(Date testData) {
		this.testData = testData;
	}

	
	@Column( name = "test_test" )
	public String getTestTest() {
		return  testTest;
	}

	public void setTestTest(String testTest) {
		this.testTest = testTest;
	}

	
}
