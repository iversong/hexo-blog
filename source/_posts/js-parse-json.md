title: js请求服务器返回JSON解析问题
date: 2014-06-15 22:32:00
categories: 前端技术
tags: 
- js 
- Ajax 
- json

---

体制问题，在目前这家公司一直搞后端，好久没写js没搞前后端交互了，还真有点想念啊，想念那两年开着多个浏览器挨个调试的日子。

少扯两句，话入正题，今天朋友问一js解析问题，索性记录一下js通过 HTTP 请求加载远程数据，以及数据解析的相关问题。

无论是同源请求实现异步操作，还是跨域请求获取第三方数据，js端请求加载远程数据通常是通过底层Ajax实现的，一般我们都是使用jQuery框架来直接请求，这里有`$.ajax(),$.post(),$.get(),$.getJson()`；个人比较喜欢用的是`$.ajax()`，因为它可以通过参数实现其它三种的所有功能，当然了，这里可以根据个人爱好和使用场景自由选择；这几个函数的详细区别([教程这里](http://www.w3school.com.cn/jquery/jquery_ref_ajax.asp))查看；

**重点来了：**两种解析方式

<!-- more -->

一、使用eval()函数。
-------------

1、当使用`$.get() or $.post() or $.ajax()`的时候没有指定 **dataType**(预期服务器响应数据类型)，虽然jquery可以智能判断，但是当返回数据是以json字符串呈现时，就需要做一次对象化处理；

 - 如果这段字符串符合标准的json格式，可以使用jquery的`$.parseJSON()`直接解析为json对象。
 - 如果返回的json字符串不符合标准json格式，那就只能使用`eval()`函数解析为json对象了。  

**例子：** 打开谷歌或火狐，F12开发者模式下如下调试
```javascript

> var jsonStr = '{name:"Iversong",age:24}'; //定义一个非标准json字符串
  undefined
  
> console.info(eval("+jsonStr+"));  //eval("+data+")方式打印
  SyntaxError: Unexpected end of input //报错：输入意外结束
  
> console.info(eval("("+jsonStr+")")); //eval("("+data+")")方式打印
  Object {name: "Iversong", age: 24} //返回正确的json对象
  
```
**问题：** `eval("("+data+")");`为什么要这么使用才正确返回json对象？？
**答案：** 由于json是以”{}”的方式来开始以及结束的，在JS中，它会被当成一个语句块来处理，所以必须强制性的将它转换成一种表达式。
	`eval("({})");`加上圆括号的目的是迫使eval函数在处理JavaScript代码的时候强制将括号内的表达式（expression）转化为对象，而不是作为语句（statement）来执行。举一个例子，例如对象字面量{}，如若不加外层的括号，那么eval会将大括号识别为JavaScript代码块的开始和结束标记，那么{}将会被认为是执行了一句空语句。所以下面两个执行结果是不同的：
```javascript
	
	console.log(eval("{}"); // return undefined
	console.log(eval("({})");// return object[Object]

```



2、当指定 **dataType**参数值为 `'json'` 或者直接使用`$.getJSON()`方法请求服务器时，是不需要对返回的数据进行解析的，因为这时候得到的结果已经是json对象了，只需直接调用该对象即可；

**例如：**

```javascript
//实例1
$.getJSON("test.js", { name: "John", time: "2pm" }, function(json){
  console.log("JSON Data: " + json.users[3].name);
});
//实例2
$.post("http://www.phpzixue.cn/",{param:"xxx"},function(data){
        console.log(data.itemName);
    },
    "json"
);
```
 
-------------

二、使用Function对象来进行返回解析
---

```
var json='{"name":"Iversong","age":24}';
myJson =(new Function("good","return "+json))(); //Function方式解析

console.log(myJson);
return Object {name: "Iversong", age: 24}  //返回对象
```
  

