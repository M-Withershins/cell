# 实验记录

- python.m是MATLAB和python混编的接口，[具体参考](https://www.cnblogs.com/q735613050/p/9170494.html)
- otsu和膨胀腐蚀算法
- zsi相似指数评价标准
- getpoints.py是自己编写的python模块，如何传参，如何往外传值作为参考。
  - 往外传值，主要要用print 而不是return！！！ bug卡了一天。0.0
  - 读取标注之后的json文件未完成，分为两种情况，图像上只有一个区域，和图像上有多个区域
  - eval函数使用了一下，执行参数语句。