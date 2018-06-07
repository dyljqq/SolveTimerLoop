# 如何解决NSTimer的循环引用

我们都知道，NSTimer使用不当会造成循环引用。为什么会造成循环引用呢，关键的点还是在于:
	
	[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(printNum:) userInfo:nil repeats:YES];
	
方法的repeates，经过我的测试，当将repeats参数设置为YES的时候，NSTimer内部应该就会强引用target，而Runloop又强引用了target， target又引用了NSTimer，之所以这里用引用是，不管你的timer是weak or strong，都还是会造成循环引用。

	target -> timer
	timer -> target
	runloop -> timer
	
->符号表示强引用

### 如何破解这个循环引用呢

其实方法很简单，那就是在合适的时候，将timer给释放掉：

	合适的时机有：
	在viewWillDisappear的时候
	在用户触发比如某个方法的时候，叫做stopTimer，里面就可以写释放timer的操作
	
但是很多时候，我们都会忘记做这些释放的操作，因此，弱target了解一下。

### 使用NSProxy解决

关于什么是NSProxy呢，我的理解就是，是一个实现了NSObject协议，然后根级跟NSObject相同的一个抽象类，为啥说是抽象类呢，因为NSProxy里面压根就没有实例化的方法，应该也是为了防止人为的滥用吧。

两个必须实现的方法：

	- (void)forwardInvocation:(NSInvocation *)invocation
	- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector

相信了解OC消息转发的朋友一定对这两个方法不陌生吧，这两个方法都是配套出现的，即methodSignatureForSelector方法构造一个invocation，然后forwardInvocation方法执行。这一步也是防止因为找不到方法而奔溃的最后一步。

> PS：消息转发的机制，即NSObject类接受到消息的时候，会先从当前类中找是否存在这个方法，找不到则继续沿着父类往上找，如果都找不到的话，那么不要急，还有三个步骤做保证，即先会在resolveInstanceMethod和-forwardingTargetForSelector:做处理，如果也没有的话，那么就会用到上面的两个：forwardInvocation和methodSignatureForSelector方法了，如果都找不到的话，那么才会奔溃。