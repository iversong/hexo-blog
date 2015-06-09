title: jquery省市区三级联动
date: 2015-06-09 16:00:30
categories: 前端技术
tags:
- js
- jquery
- 插件

---

忙碌的5月，度过了紧张的开发任务，终于可以喘口气休息一下了，借此机会也记录一下开发中用到的小工具-基于jquery的ajax省市区联动，数据可存到文件和数据库，比较方便顺手。

数据跨域问题不方便上demo,直接贴插件代码，json数据文件放最后，可打包下载：

### demo:

#### HTML

html中引入jquery和cityselect插件

	<script type="text/javascript" src="js/jquery.js"></script> 
	<script type="text/javascript" src="js/jquery.cityselect.js"></script>

定义三个select，class属性分别为prov、city、dist，表示省市区三个下拉框

	<div id="city"> 
	    <select class="prov"></select>  
	    <select class="city" disabled="disabled"></select> 
	    <select class="dist" disabled="disabled"></select> 
	</div>

#### Jquery调用

	$("#city").citySelect();
	//或者自定义数据来源和初始化选择
	$("#city").citySelect({  
	    url:"ajax.php/get_area",  
	    prov:"浙江", //省份 
	    city:"杭州", //城市 
	    dist:"西湖区", //区县 
	    nodata:"none" //当子集无数据时，隐藏select 
	})

<!-- more -->

#### ajax.php/get_area
	
	//取数据，建议缓存
	public function get_area(){
		$this->load->library('dcache');
 		$this->dcache->set_dir("application");
		$city_jsonlist = $this->dcache->get('city_jsonlist');
		if ($city_jsonlist == false) {
			$result = $this->db->select('no,name,pid,level')->from('areas')->get()->result_array();
			$city_jsonlist = $this->get_area_json($result);
			$this->dcache->set('city_jsonlist',$city_jsonlist);
		}
		$this->json_output(array('citylist'=>$city_jsonlist));
	}
	//数据递归格式化
	function get_area_json($alldata,$pid=0){
		$list = array();
		foreach ($alldata as $key => $item) {
			if ($item['pid'] == $pid) {
				switch ($item['level']) {
					case '1':
						$item['p'] = $item['name'];
						$item['c'] = $this->get_area_json($alldata,$item['no']);
						unset($item['name'],$item['pid'],$item['level']);
						break;
					case '2':
						$item['n'] = $item['name'];
						$item['a'] = $this->get_area_json($alldata,$item['no']);
						unset($item['name'],$item['pid'],$item['level']);
						break;
					case '3':
						$item['s'] = $item['name'];
						unset($item['name'],$item['pid'],$item['level']);
						break;
					default:
						$item['s'] = $item['name'];
						unset($item['name'],$item['pid'],$item['level']);
						break;
				}
				$list[] = $item;
			}
		}
		return $list;
	}
                                                                                          
--------------

[插件源码下载](http://pan.baidu.com/s/1bnyJz0j) 请放到web服务器环境下访问

参考[基于jQuery+JSON的省市联动效果](http://www.helloweba.com/view-blog-188.html)