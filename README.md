NQBarGraph
=================

This is a control that draw bar graph according to NQData objects giving to it. 

![NQBarGraph](http://farm3.staticflickr.com/2859/9148749570_007902a0a2.jpg)

![NQBarGraph](http://farm8.staticflickr.com/7337/9146520251_07ac1957d1.jpg)

NQData object take two parameter date and number the number is the hight of the bare on the vertical 
axes and the date is on the horizontal axes ,the bar order is according to thier order in the array like this: Example: 

initialise the graph view 

```objc
NQBarGraph * barGraph=[[NQBarGraph alloc] initWithFrame:self.view.bounds];
```

add it to the controller view 

```objc
[self.view addSubview:barGraph];
```
 

set the dataSource 

```objc
barGraph.dataSource=dataArray;
```



This controller under MIT license just mention me in the app thanks

The MIT License (MIT)

Copyright (c) 2013 ahmed elnaqah

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
