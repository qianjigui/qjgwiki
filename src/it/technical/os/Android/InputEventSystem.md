---
title: "Android 事件处理系统"
tags: EventProcess
---

#主要参考#
http://blog.csdn.net/myarrow/article/details/7091061

#Source Code view@Android 4.2 #
* Focus Activity
    * ActivityManagerService.java::setFocusedActivity
* Input System
    * Window Manager Service
        * com_android_server_KeyInputQueue.cpp::readEvent
        * WindowMangerService.java::KeyQ
        * KeyInputQueue.java::KeyInputQ
        * WindowMangerService.java::InputDispatcherThread
    * Client
        * ViewRoot.java::IWindow
        * ViewRoot.java::ViewRoot

## 事件输入与分发 ##
### 主体结构 ###
#### 事件表示与管理####
* EventHub.h
    * RawEvent
        * when
        * deviceId
        * type
        * code
        * value
    * RawAbsoluteAxisInfo

它是系统中所有事件的中央处理站。它管理所有系统中可以识别的输入设备的输入事件，此外，当设备增加或删除时，EventHub将产生相应的输入事件给系统。

EventHub通过getEvents函数，给系统提供一个输入事件流。
它也支持查询输入设备当前的状态（如哪些键当前被按下）。
而且EventHub还跟踪每个输入调入的能力，比如输入设备的类别，输入设备支持哪些按键。

#### InputReader ####

InputReader从EventHub中读取原始事件数据(RawEvent)，并由各个InputMapper处理之后输入对应的input listener.

InputReader拥有一个InputMapper集合。
它做的大部分工作在InputReader线程中完成，但是InputReader可以接受任意线程的查询。
为了可管理性，InputReader使用一个简单的Mutex来保护它的状态。

InputReader拥有一个EventHub对象，但这个对象不是它创建的，而是在创建InputReader时作为参数传入的。


#### InputDispatcher ####

InputDispatcher负责把事件分发给输入目标，其中的一些功能（如识别输入目标）由独立的policy对象控制。

#### InputManager ####

InputManager是系统事件处理的核心，它虽然不做具体的事，但管理工作还是要做的，比如接受我们客户的投诉和索赔要求，或者老板的出所筒。

InputManager使用两个线程：
1. InputReaderThread叫做"InputReader"线程，它负责读取并预处理RawEvent，applies policy并且把消息送入DispatcherThead管理的队列中。
1. InputDispatcherThread叫做"InputDispatcher"线程，它在队列上等待新的输入事件，并且异步地把这些事件分发给应用程序。

InputReaderThread类与InputDispatcherThread类不共享内部状态，所有的通信都是单向的，从InputReaderThread到InputDispatcherThread。两个类可以通过InputDispatchPolicy进行交互。

InputManager类从不与Java交互，而InputDispatchPolicy负责执行所有与系统的外部交互，包括调用DVM业务。

### 创建与启动流程 ###
1. com_android_server_input_InputManagerService.cpp::nativeInit
    1. 获取一个messageQueue
    1. im <- new NativeInputManager
        1. mInputManage <- new InputManager(new EventHub())
            1. mDispatcher <- new InputDispatcher(dispatcherPolicy);
            1. mReader <- new InputReader(eventHub, readerPolicy, mDispatcher);
            1. mReaderThread <- new InputReaderThread(mReader);
            1. mDispatcherThread <- new InputDispatcherThread(mDispatcher);
1. com_android_server_input_InputManagerService.cpp::nativeStart
    1. mReader->loopOnce (InputReader.cpp)
    1. mDispatcher -> dispatchOnce (InputDispatcher.cpp)
1. SystemServer
    1. Create InputManager
    1. WindowManagerService.main 创建一个WindowManagerService对象，作为inputManager的回调

##事件反馈##
由InputDispatcher进行事件的分发处理:
    * mDispatcher
        * dispatchOnce
            * dispatchOnceInnerLocked
                * Check EventType
                    1. TYPE_CONFIGURATION_CHANGED: dispatchConfigurationChangedLocked
                    1. TYPE_DEVICE_RESET: dispatchDeviceResetLocked
                    1. TYPE_KEY: dispatchKeyLocked
                    1. TYPE_MOTION: dispatchMotionLocked
                        * findFocusedWindowTargetsLocked
                        * dispatchEventLocked
                            * prepareDispatchCycleLocked
                                * enqueueDispatchEntriesLocked
                                    * startDispatchCycleLocked
                                        * connection->inputPublisher.publishMotionEvent
                                            * mChannel -> sendMessage()
            * poll
                * pollInter
                    * handler -> handleMessage(message)

### InputManagerService::handleMessage ###
InputManagerHandler::handleMessage

### WindowManagerService::handleMessage ###

### ViewRootImpl::ViewRootHandler::handleMessage ###
case MSG_PROCESS_INPUT_EVENTS:
    * doProcessInputEvents
        * deliverInputEvent
            * deliverPointerEvent
                * mView.dispatchPointerEvent
                    * dispatchTouchEvent
                        * onTouchEvent
