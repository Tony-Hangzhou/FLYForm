#FLYForm 

FLYForm是一个用XML文件统一管理APP表单的框架，运行在iOS平台，功能如下：
####1. Cell元数据管理
在表单中，通常描述一个Cell大概有以下几种元素：标题、填写控件、验证类、绑定的数据源组成，这些在FLYForm里称之为Cell元数据。而这些通常散落在代码的各个角落或者有诸多不优雅的if...else...实现，XML方式会更加优雅和具有可扩展性。
####2. 表单验证管理
数据合法性验证是表单开发中不可缺少的环节，FLYForm统一表单验证方式，内置10种验证类，通过写XML文件即可灵活的为Cell配置一种或多种验证类。开发者在提交表单时调用[self.flyFormModel doValidate]即可完成表单验证。
####2. ViewModel <-> View 双向映射
一直以来视图模型是表单开发中重要环节，其核心包括：a、数据更新，表单界面自动更新 b、表单界面更新，数据自动更新。FLYForm引入轻量级的K-V映射做为ViewModel，并完成ViewModel和View自动双向映射。
## 如何开始?

Coding
```xml
<?xml version="1.0" encoding="utf-8"?>
<Root>
    <!-- 
     支持include，按模块划分XML配置文件。
     <include file="FLYForm.ModuleName.xml"/>
     -->
    
    <!-- 表单ID唯一 -->
    <Form id="修改订单">
        <Section>
            <Cell key="price" title="价格" cellClass="FLYFormInputCell"  placeholder="auto" validateClass="FLYValidateMust,FLYValidateDecimals" />
            <Cell key="number" title="数量" cellClass="XJNumCell" validateClass="" placeholder=""/>
            <Cell key="unit" title="单位" cellClass="FLYFormGeneralCell" />
            <Cell key="totalAmount" title="总计" cellClass="FLYFormGeneralCell"/>
        </Section>
        <Section  headerClass="DefaultSection" >
            <Cell key="name" title="姓名" cellClass="FLYFormInputCell" validateClass="FLYValidateMust" placeholder="请填写姓名"/>
            <Cell key="phone" title="手机号" cellClass="FLYFormInputCell" validateClass="FLYValidateMust,FLYValidateMobile" placeholder="auto"/>
            <!-- 单项选择属性optionsData表示选项的数据源，在plist文件统一配置：FLYForm.OptionSingleData.plist -->
            <Cell key="specifyDeliveryTimeText" title="送货时间" cellClass="FLYFormPickerCell" optionsData="送货时间" validateClass="FLYValidateMust" placeholder="auto"/>
        </Section>
    </Form>
</Root>
```
说明 `NSLayoutConstraint constraintsWithVisualFormat:` .

## 如何使用？

#### 1. MASViewAttribute

```obj-c
make.centerX.lessThanOrEqualTo(view2.mas_left);
```



