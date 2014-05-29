title: PHPWord初使用
date: 2014-05-21 16:34:57
tags: PHPWord
---
最近项目中使用到导出网页内容到word功能，使用php内置函数也能实现导出，但是样式比较单一，于是找到一个开源的工具 PHPWord，研究了一番，比较强大，这里介绍下使用；
###　[PHPWord](https://github.com/PHPOffice/PHPWord) 要求PHP版本5.3+，因为5.3之后引入了命名空间的概念；

## Requirements
* PHP 5.3+
* PHP Zip extension
* PHP XML Parser extension
## Optional PHP extensions
+ PHP GD extension
+ PHP XMLWriter extension
+ PHP XSL extension
## Installation
　特别注意官方给出下面的初始化方法：  
 　Alternatively, you can download the latest release from the releases page. In this case, you will have to register the autoloader.
~~~~{php}
require_once 'path/to/PhpWord/src/PhpWord/Autoloader.php';
\PhpOffice\PhpWord\Autoloader::register();
~~~~
<!-- more -->
## Basic usage
~~~~{python}
$phpWord = new \PhpOffice\PhpWord\PhpWord();

// Every element you want to append to the word document is placed in a section.
// To create a basic section:
$section = $phpWord->addSection();

// After creating a section, you can append elements:
$section->addText('Hello world!');

// You can directly style your text by giving the addText function an array:
$section->addText('Hello world! I am formatted.',
    array('name'=>'Tahoma', 'size'=>16, 'bold'=>true));

// If you often need the same style again you can create a user defined style
// to the word document and give the addText function the name of the style:
$phpWord->addFontStyle('myOwnStyle',
    array('name'=>'Verdana', 'size'=>14, 'color'=>'1B2232'));
$section->addText('Hello world! I am formatted by a user defined style',
    'myOwnStyle');

// You can also put the appended element to local object like this:
$fontStyle = new \PhpOffice\PhpWord\Style\Font();
$fontStyle->setBold(true);
$fontStyle->setName('Verdana');
$fontStyle->setSize(22);
$myTextElement = $section->addText('Hello World!');
$myTextElement->setFontStyle($fontStyle);

// Finally, write the document:
$objWriter = \PhpOffice\PhpWord\IOFactory::createWriter($phpWord, 'Word2007');
$objWriter->save('helloWorld.docx');
~~~~
上面的示例代码可以输出简单的Word文档，涉及到命名空间的语法，导入，限定名称，完全限定名称等概念可以自行查找资料学习，未完待续！
